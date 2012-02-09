//	Copyright 2012 Jamazing Games©
//	Author: Gordon D Mckendrick
//
//	Player Object
//	Represents the player in the level
//	Future versions should extend a generic entity class

package jamazing.jamstory.entity 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import jamazing.jamstory.util.Physics;
	import jamazing.jamstory.util.Keys;
	
	//	Class: Player
	//	Represents the player entity that the user controls
	public class Player extends Sprite
	{
		
		private var xForce:int;	//	Horizontal force applied in this frame. +ve is right
		private var xSpeed:int;	//	Horizontal speed.
		private var yForce:int;	//	Vertical force applied in this frame. +is down 
		private var ySpeed:int;	//	Vertical speed.
		private var mass:int;	//	Mass of the player object
		private var jumping:Boolean;	//	True if the player is jumping
		
		//	Constructor: default
		//	Ensure stage is initialised before initialising the player
		public function Player() 
		{
			super();
			
			if (stage) {
				onInit();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, onInit);
			}
		}
		
		private function onInit(e:Event = null):void
		{
			xForce = 0;
			xSpeed = 0;
			yForce = 0;
			ySpeed = 0;
			mass = 10;
			
			graphics.beginFill(0xFF0000);
			graphics.drawCircle(-20, -20, 20);
			graphics.endFill();
			
			x = stage.stageWidth / 2;
			y = 400;
			
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(Event.ENTER_FRAME, onTick);
		}
		
		public function jump():void
		{
			yForce -= 500;
			jumping = true;
		}
		
		public function move(horizontalForce:int):void
		{
			xForce += horizontalForce;
		}
		
		private function onTick(e:Event):void
		{
			yForce += Physics.GRAVITY * mass;
			xForce *= 1 - (Physics.FRICTION * mass);
			
			if (y >= (stage.stageHeight - (ySpeed + 80))) {
				y = stage.stageHeight - 80;
				yForce = 0;
				jumping = false;
			}
			
			if (Keys.isDown(Keys.A)) {
				move(-10);
			}
			if (Keys.isDown(Keys.D)){
				move(10);
			}
			if ((Keys.isDown(Keys.W)) && (!jumping) && (ySpeed == 0)) {
				jump();
			}
			
			updateSpeed();
			updatePosition();
		}
		
		private function updateSpeed():void
		{
			xSpeed = Physics.calcAcceleration(xForce, mass);
			ySpeed = Physics.calcAcceleration(yForce, mass);
		}
		
		private function updatePosition():void
		{
			x += xSpeed;
			y += ySpeed;
		}
		
		
		
	}

}