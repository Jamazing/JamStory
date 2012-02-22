//	Copyright 2012 Jamazing Games©
//	Author: Gordon D Mckendrick
//	TestPlayer
//		Testing of a player class, without disturbing main Player development
//		Testing of movement using accelerations and speeds - from Sonic style games
//		Testing of more events based mechanics for collisions
//		Note: Changes have been made in World to accomodate this testing.

package jamazing.jamstory.entity 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import jamazing.jamstory.object.Collidable.Collidable;
	import jamazing.jamstory.util.Keys;
	import jamazing.jamstory.events.PlayerEvent;
	
	//	Class: TestPlayer
	public class TestPlayer extends Sprite
	{
		public var xSpeed:Number;	//	Amount to increment x position each tick
		public var ySpeed:Number;	
		public var xAccel:Number;	//	Amount to increment x-speed each tick
		public var yAccel:Number;
		public var moving:Boolean;	//	True if currently moving
		public var jumping:Boolean;	//	True if currently jumping
		
		public var collidable:Collidable;
		
		//	Constructor: default
		public function TestPlayer() 
		{
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	Function: onInit
		//	Initialises the object once added to the stage
		private function onInit(e:Event = null):void
		{
			x = 0;
			y = 220;
			//	Memory Allocation
			collidable = new Collidable(x, y, 30);

			//	Variable Initialisation
			xSpeed = 0;
			ySpeed = 0;
			xAccel = 0;
			yAccel = 1;
			moving = false;
			jumping = false;
			
			//	Graphics initialisation
			graphics.beginFill(0xFF6600);
			graphics.drawCircle(0, 0, 30);
			graphics.endFill();
			
			//	Event listeners
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(Event.ENTER_FRAME, onTick);
			stage.addEventListener(PlayerEvent.COLLIDE, onCollide);
		}
		
		//	Listener: onCollide
		//	Fires whenever the player is involved in a collision event
		private function onCollide(e:PlayerEvent):void
		{
			ySpeed = 0;
			y = e.y - height / 2;
		}
		
		//	Listener: onTick
		//	Updates the movement each frame
		private function onTick(e:Event):void
		{
			if (Keys.isDown(Keys.D)) {
				xSpeed = 10;
			}else if (Keys.isDown(Keys.A)) {
				if (xSpeed > 0){
					xSpeed = -30;
				}else {
					xSpeed = -10;
				}
			}else {
				xSpeed *= 0.8;
			}
			if (Math.abs(xSpeed) < 1) {
				xSpeed = 0;
			}

			//	Update speed and position
			xSpeed += xAccel;
			ySpeed += yAccel;
			x += xSpeed;
			y += ySpeed;

			//	Keep the collidable object at the player location
			collidable.x = x;
			collidable.y = y;
		}
		
	}

}