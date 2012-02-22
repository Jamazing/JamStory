//	Copyright 2012 Jamazing Games©
//	Author: Gordon D Mckendrick
//	Throwable
//		A throwable object, such as a jam jar
//		Base class with generic properties
//		Supports parabolic trajectories (including straight lines)


package jamazing.jamstory.object 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import jamazing.jamstory.object.Collidable.Collidable;
	
	//	Class: Throwable
	public class Throwable extends Sprite
	{
		
		private var xSpeed:Number;
		private var xAccel:Number;
		private var ySpeed:Number;
		private var yAccel:Number;
		private var moving:Boolean;
		public var collidable:Collidable;
		
		//	Constructor: default
		public function Throwable() 
		{
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(e:Event = null):void
		{
			
			//	Memory Allocation
			collidable = new Collidable(x, y, 5);
			
			//	Variable Initialisation
			xSpeed = 0;
			ySpeed = 0;
			xAccel = 0;
			yAccel = 0;
			moving = false;
			
			//	Event Listeners
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(Event.ENTER_FRAME, onTick);
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
		}
		
		//	Function: throwPolar
		//	Throws this object
		//	Uses polar values - an initial velocity, and angle of projection
		public function throwPolar(velocity:Number, angle:Number, yAccel:Number = 2, xAccel:Number = 0 ):void
		{
			this.xSpeed = velocity * Math.cos(angle*(Math.PI/180));
			this.ySpeed = velocity * Math.sin(angle*(Math.PI/180));
			this.xAccel = xAccel;
			this.yAccel = yAccel;
			this.moving = true;
		}
		
		//	Function: throwCartesian
		//	Throws this object
		//	Uses cartesian values - x and y component speeds
		public function throwCartesian(xSpeed:Number, ySpeed:Number, yAccel:Number = -1, xAccel:Number = 0 ):void
		{
			this.xSpeed = xSpeed;
			this.ySpeed = ySpeed;
			this.xAccel = xAccel;
			this.yAccel = yAccel;
			this.moving = true;
		}
		
		//	Function: setAcceleration (Number, Number)
		//	Sets the current acceleration
		public function setAcceleration(yAccel:Number, xAccel:Number = 0):void
		{
			this.yAccel = yAccel;
			this.xAccel = xAccel;
		}
	}

}