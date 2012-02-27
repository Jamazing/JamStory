//	Copyright 2012 Jamazing games©
//	Author: Gordon D Mckendrick
//	Contrib: Ivan Mateev
//	PlayerEvent
//		Fired when the player is involved in actions such as collisions etc


package jamazing.jamstory.events 
{
	import flash.events.Event;
	
	//	Class: PlayerEvent
	public class PlayerEvent extends Event
	{
		public static const THROWABLE_COLLISION:String = "THROWABLE_COLLISION";	
		public static const COLLIDE:String = "COLLISION";			//	When a player collides with something
		public static const NOCOLLIDE:String = "NO_COLLISION";		//	When a player falls off a ledge
		public static const JAM:String = "JAM";						//	When a player is touching jam;
		public static const THROW:String = "THROW";
			
		public var x:Number;			//	X position this occured at
		public var y:Number;			//	Y position this occured at
		public var angle:Number;		//	Direction of the action
		public var magnitude:Number;	//	Magnitude of the event (such as throwing strength, or collision strength)
		
		//	Constructor: default
		public function PlayerEvent(type:String,x:Number, y:Number, angle:Number = 0, magnitude:Number = 0, bubbles:Boolean = true, cancelable:Boolean = false) 
		{
			this.x = x;
			this.y = y;
			this.angle = angle;
			this.magnitude = magnitude;
			
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event 
		{
			return new PlayerEvent(type, x, y, angle, magnitude, bubbles, cancelable);
		}
		
		override public function toString():String 
		{
			return type + " at " + x.toString() + ";" + y.toString() + "| phi=" + angle.toString() + "| magnitude=" + magnitude.toString();
		}
	}

}