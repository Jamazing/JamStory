//	Copyright 2012 Jamazing Games©
//	Author: Gordon D Mckendrick
//	
//	Living
//		The base class for living enties such as players and enemies
//		Has basic functionality for moving, health etc

package jamazing.jamstory.entity 
{
	import flash.events.Event;
	import jamazing.jamstory.events.JamStoryEvent;

	//	Class: Living
	public class Living extends Dynamic
	{
		public var isJumping:Boolean;	//	True if it is currently mid-jump
		public var timesJumped:int;		//	The number of times jumped in a row
		public var maxJumps:int;		//	The maximum number of times it can jump before landing
		
		public var canWalk:Boolean;		//	True if it is able to use the move functionality
		public var canFly:Boolean;		//	True if it is able to use the fly functionality
		public var canJump:Boolean;		//	True if it is able to use the jump functionality
		
		public var isAlive:Boolean;		//	True if it is still alive
		
		public var jumpHeight:Number;
		public var moveSpeed:Number;
		
		//	Constructor: default
		public function Living() 
		{
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	Function: onInit
		//	Initialisation after being added to the stage
		private function onInit(e:Event = null):void
		{
			isMoving = true;
			xSpeed = 0;
			ySpeed = 0;
			xAccel = 0;
			yAccel = 1;
			isJumping = false;
			isAlive = true;
			canWalk = true;
			canJump = true;
			timesJumped = 0;
			maxJumps = 1;
			jumpHeight = 20;
			moveSpeed = 0;
			
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			stage.addEventListener(JamStoryEvent.TICK_MAIN, onTick);
		}
		
		//	Function: onTick
		//	Updates position and logic each tick
		private function onTick(e:JamStoryEvent):void
		{
			xSpeed *= 0.3;
		}
		
		//	Function: kill
		//	Kills this living entity, and ensures all behaviour is stopped
		public function kill():void
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
		
		public function onSticky():void
		{
			
		}
		
		public function onBouncey():void
		{
			
		}
		
		public function onSlippy():void
		{
			
		}
	}

}