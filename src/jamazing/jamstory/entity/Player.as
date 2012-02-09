//	Copyright 2012 Jamazing Games©
//	Author: Gordon D Mckendrick
//
//	Player Object
//	Represents the player in the level
//	Future versions should extend a generic entity class

package jamazing.jamstory.entity 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import jamazing.jamstory.util.Physics;
	import jamazing.jamstory.util.Keys;
	
	
		
	//	Class: Player
	//	Represents the player entity that the user controls
	public class Player extends Sprite
	{
		[Embed(source = "../../../../resources/jamjar.png")]
		private var JamJar:Class;
	
		public var jamjar:Bitmap;
		
		public var air:Number;
		public var xForce:Number;	//	Horizontal force applied in this frame. +ve is right
		public var xSpeed:Number;	//	Horizontal speed.
		public var yForce:Number;	//	Vertical force applied in this frame. +is down 
		public var ySpeed:Number;	//	Vertical speed.
		public var mass:int;	//	Mass of the player object
		public var jumping:Boolean;	//	True if the player is jumping
		public var friction:int;
		public var stuck:Boolean;
		public var stuck_count:int;
		
		//	Constructor: default
		//	Ensure stage is initialised before initialising the player
		public function Player() 
		{
			super();
			if (stage){
				onInit();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, onInit);
			}

		}
		
		//	Listener: onInit (Event = null)
		//	Initialises the player once it's been added to the stage properly
		private function onInit(e:Event = null):void 
		{
			air = 1;
			xForce = 0;
			xSpeed = 0;
			yForce = 0;
			ySpeed = 0;
			mass = 10;
			friction = 0;
			jamjar = new JamJar();
			jamjar.width = 50;
			jamjar.height = 50;
			jamjar.x = -width/2;
			jamjar.y = -height / 2;
			addChild(jamjar);
			
			x = stage.stageWidth / 2;
			y = stage.stageHeight / 2;
			
			addEventListener(Event.ENTER_FRAME, onTick);
		}
		
		//	Function: jump
		//	Makes the player jump by applying a force upwards
		public function jump():void
		{
			yForce -= 450;
			jumping = true;
		}
		
		//	Function: bounce
		//	Makes the player jump by applying a force upwards
		public function bounce():void
		{
			yForce = -(Math.abs(yForce) * 1.2) - 200;
		}
		
		//	Function: move (int)
		//	Moves the player by applying a horizontal force
		public function move(horizontalForce:Number):void
		{
			if (!stuck){
				xForce += horizontalForce;
			}else {
				xForce += horizontalForce / 5;
			}
		}
		
		//	Listener: onTick (Event)
		//	Runs the update code once per frame
		private function onTick(e:Event):void
		{

			if (Keys.isDown(Keys.A)) {
				move(-12);
			}
			if (Keys.isDown(Keys.D)){
				move(12);
			}
			if ((Keys.isDown(Keys.W)) && (!jumping) && (Math.abs(ySpeed) < 1)) {
				jump();
			}
			xSpeed = xSpeed * (Physics.FRICTION / friction);
			if (stuck) {
				ySpeed *= 0.85
			}
			
			updateSpeed();
			updatePosition();
			xForce = 0;
			yForce = 0;
		}
		
		//	Function: updateSpeed
		//	Works out and applies the speed based on the forces
		private function updateSpeed():void
		{
			xSpeed += Physics.calcAcceleration(xForce, mass);
			ySpeed += Physics.calcAcceleration(yForce, mass);
		}
		
		//	Function updatePosition
		//	Updates the player positions based on their current speed
		private function updatePosition():void
		{
			x += xSpeed;
			y += ySpeed;
		}
		
		
		
	}

}