//	Copyright 2012 Jamazing Games©
//	Author: Gordon D Mckendrick
//
//	Throwable
//		A throwable object, such as a jam jar
//		Base class with generic properties
//		Supports parabolic trajectories (including straight lines)


package jamazing.jamstory.entity 
{
	import flash.events.Event;
	import jamazing.jamstory.entity.Dynamic;
	import jamazing.jamstory.entity.Collidable;
	import jamazing.jamstory.events.PlayerEvent;
	
	
	//	Class: Throwable
	public class Throwable extends Dynamic
	{
	
		private var bounces:int;
		public var bouncesMax:int;
		
		//	Constructor: default
		public function Throwable() 
		{
			super();
			bounces = 0;
			bouncesMax = 2;
			
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	Function: onInit
		//	Initialises the throwable once it's been added to the stage
		private function onInit(e:Event = null):void
		{
			hitbox = new Collidable(x, y, trueWidth);
			isMoving = false;
			
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(PlayerEvent.THROWABLE_COLLISION, onCollide);
		}
		
		//	Listener: onCollide
		//	Reacts to any collisions by bouncing
		private function onCollide(e:PlayerEvent):void
		{
			bounces++;
			if (bounces > bouncesMax) {
				isMoving = false;
			}

			var c:BoxCollidable = e.collidable as BoxCollidable;
			if (e.side == Collidable.SIDE_TOP) {
				ySpeed *= -0.5;
				y = (c.y - c.height / 2);
				rotation = 0;
				
			}else if (e.side == Collidable.SIDE_LEFT) {
				xSpeed *= -0.5;
				x = (c.x - c.width / 2);
				rotation = -90;
				
			}else if (e.side == Collidable.SIDE_BOTTOM) {
				ySpeed *= -1;
				y = (c.y + c.height / 2);
				rotation = 0;
				
			}else if (e.side == Collidable.SIDE_RIGHT) {
				xSpeed *= -0.5;
				x = (c.x + c.width / 2);
				rotation = 90;
			}
		}
		
		//	Function: throwPolar
		//	Throws this object
		//		Uses polar values - an initial velocity, and angle of projection
		public function throwPolar(velocity:Number, angle:Number, yAccel:Number = 2, xAccel:Number = 0 ):void
		{
			//	Calculate the starting x and y speed components from the given angle and velocity
			this.xSpeed = velocity * Math.cos(angle*(Math.PI/180));
			this.ySpeed = velocity * Math.sin(angle * (Math.PI / 180));
			
			this.xAccel = xAccel;
			this.yAccel = yAccel;
			this.isMoving = true;
		}
		
		//	Function: throwCartesian
		//	Throws this object
		//		Uses cartesian values - x and y component speeds
		public function throwCartesian(xSpeed:Number, ySpeed:Number, yAccel:Number = -1, xAccel:Number = 0 ):void
		{
			this.xSpeed = xSpeed;
			this.ySpeed = ySpeed;
			this.xAccel = xAccel;
			this.yAccel = yAccel;
			this.isMoving = true;
		}
		
		//	Function: setAcceleration
		//	Sets the current acceleration
		public function setAcceleration(yAccel:Number, xAccel:Number = 0):void
		{
			this.yAccel = yAccel;
			this.xAccel = xAccel;
		}
	}

}