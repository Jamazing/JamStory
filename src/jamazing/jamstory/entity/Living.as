//	Copyright 2012 Jamazing Games©
//	Author: Gordon D Mckendrick
//	
//	Living
//		The base class for living enties such as players and enemies
//		Has basic functionality for moving, health etc

package jamazing.jamstory.entity 
{
	import flash.events.Event;
	import jamazing.jamstory.engine.Resource;
	import jamazing.jamstory.events.JamStoryEvent;
	import jamazing.jamstory.events.SoundEvent;

	//	Class: Living
	public class Living extends Dynamic
	{
		public var isJumping:Boolean;	//	True if it is currently mid-jump
		public var timesJumped:int;		//	The number of times jumped in a row
		public var maxJumps:int;		//	The maximum number of times it can jump before landing
		
		public var canWalk:Boolean;		//	True if it is able to use the move functionality
		public var canFly:Boolean;		//	True if it is able to use the fly functionality
		public var canJump:Boolean;		//	True if it is able to use the jump functionality
		
		public var jumpHeight:Number;
		public var moveSpeed:Number;
		
		public var isStuck:Boolean;
		public var isSlippy:Boolean;
		public var stickyEscape:int;
		public var stickyJam:Jam;
		
		
		//	Constructor: default
		public function Living() 
		{
			super();
			xSpeed = 0;
			ySpeed = 0;
			xAccel = 0;
			yAccel = 1;
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	Function: onInit
		//	Initialisation after being added to the stage
		private function onInit(e:Event = null):void
		{
			isStuck = false;
			isSlippy = false;
			stickyEscape = 0;
			isMoving = true;
			isJumping = false;
			isAlive = true;
			canWalk = true;
			canJump = true;
			timesJumped = 0;
			maxJumps = 1;
			jumpHeight = 20;
			
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			stage.addEventListener(JamStoryEvent.TICK_MAIN, onTick);
		}
		
		//	Function: onTick
		//	Updates position and logic each tick
		private function onTick(e:JamStoryEvent):void
		{
			
			
			if (isStuck){
				if (stickyEscape > 100) {
					y -= 5;
					ySpeed = -35;
					stickyEscape = 0;
					isStuck = false;
					stickyJam.collisions += 5;
				}
				stickyEscape--;
				if (stickyEscape < 0) {
					stickyEscape = 0;
				}
			}
			
			if (isSlippy) {
				if (isJumping) {
					ySpeed += 2 * (ySpeed / Math.abs(ySpeed));
				}
				else
					xSpeed += 2 * ((xSpeed != 0) ? (xSpeed / (Math.abs(xSpeed))) : 0 );	// A devision by zero here caused the jamjar to warp to beginning of level
				if (xSpeed > moveSpeed) 
					xSpeed = moveSpeed;
			}
			else {
				xSpeed *= 0.3;
			}
		}
		
		//	Function: kill
		//	Kills this living entity, and ensures all behaviour is stopped
		public function kill():void
		{
			die();
		}
		
		protected function die():void
		{
			isAlive = false;
			visible = false;
		}
		
		//	Function: spawn
		//	Spawns the living entity back at it's original spawn location
		public function spawn():void
		{
			
		}
		
		//	Function: jump
		//	Makes it jump into the air
		public function jump():void
		{
			if (!isJumping) {
				if (ySpeed < 0 ) return;
				isJumping = true;
				ySpeed -= jumpHeight;
			}
		}
		
		public function onSticky(side:int, jam:Jam):void
		{
			if (!isStuck)
				stage.dispatchEvent(new SoundEvent(SoundEvent.PLAY, new Resource.SOUND_JAMMED, jam));
				
			var c:Collidable = jam.hitbox;
			isStuck = true;
			ySpeed = 0;
			xSpeed = 0;
			y = c.y - trueHeight / 2;
			x -= (x - c.x) / 10;
			stickyJam = jam;
			
			
				
		}
		
		public function onBouncey(side:int, jam:Jam):void
		{
			stage.dispatchEvent(new SoundEvent(SoundEvent.PLAY, new Resource.SOUND_JAMMED, jam));
				
			var c:Collidable = jam.hitbox;
			
			if (side == Collidable.SIDE_TOP) {
				ySpeed *= -1.3;
				y = (c.y - c.radius) - trueHeight/2;
				
			}else if (side == Collidable.SIDE_LEFT) {
				xSpeed *= 1.3;
				ySpeed *= -1.1;
				
			}else if (side == Collidable.SIDE_BOTTOM) {
				ySpeed *= -1.3;
				y = (c.y + c.radius) + trueHeight/2;
				
			}else if (side == Collidable.SIDE_RIGHT) {
				xSpeed *= 1.3;
				ySpeed *= -1.1;
			}
			
			if (ySpeed < -50) {
				ySpeed = -50;
			}
			jam.collisions++;
		}
		
		public function onSlippy(side:int, jam:Jam):void
		{
			if (!isSlippy)
				stage.dispatchEvent(new SoundEvent(SoundEvent.PLAY, new Resource.SOUND_JAMMED, jam));
				
			var c:Collidable = jam.hitbox;
			
			if (!isSlippy) {
				jam.collisions++;
			}
			
			isSlippy = true;
			
		}
	}

}