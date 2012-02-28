//	Copyright 2012 Jamazing Games©
//	Author: Gordon D Mckendrick
//
//	Throwable
//		A throwable object, such as a jam jar
//		Base class with generic properties
//		Supports parabolic trajectories (including straight lines)


package jamazing.jamstory.object 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import jamazing.jamstory.object.Collidable.Collidable;
	import jamazing.jamstory.events.PlayerEvent;
	
	
	//	Class: Throwable
	public class Throwable extends Sprite
	{
		
		private var xSpeed:Number;			//	Current speed in the x direction
		private var xAccel:Number;			//	Current acceleration in the y direction
		private var ySpeed:Number;
		private var yAccel:Number;
		private var moving:Boolean;			//	True if the object is moving (has been thrown/not collided)
		public var collidable:Collidable;	//	Collision box for checking collisions once thrown
		
		//	Constructor: default
		public function Throwable() 
		{
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	Function: onInit
		//	Initialises the throwable once it's been added to the stage
		private function onInit(e:Event = null):void
		{
			collidable = new Collidable(x, y, 5);
			
			xSpeed = 0;
			ySpeed = 0;
			xAccel = 0;
			yAccel = 0;
			moving = false;
			
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(Event.ENTER_FRAME, onTick);
			addEventListener(PlayerEvent.THROWABLE_COLLISION, onCollide);
		}
		
		//	Listener: onTick
		//	Updates the position each frame
		public function onTick(e:Event):void
		{
			//	Update Movement
			if (moving) {
				x += xSpeed;
				y += ySpeed;
				ySpeed += yAccel;
				xSpeed += xAccel;
			}
			//	Update the collision box position
			collidable.x = x;
			collidable.y = y;
		}
		
		//	Listener: onCollide
		//	Reacts to any collisions by bouncing
		private function onCollide(e:PlayerEvent):void
		{
			ySpeed *= -0.5;
			xSpeed *= 0.5;
			y = e.y;
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
			this.moving = true;
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
			this.moving = true;
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