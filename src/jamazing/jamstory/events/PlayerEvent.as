//	Copyright 2012 Jamazing games©
//	Author: Gordon D Mckendrick
//	Contrib: Ivan Mateev
//
//	PlayerEvent
//		Fired when the player is involved in actions such as collisions etc


package jamazing.jamstory.events 
{
	import flash.events.Event;
	
	
	//	Class: PlayerEvent
	public class PlayerEvent extends Event
	{
		public static const THROWABLE_COLLISION:String = "THROWABLE_COLLISION";	//	When a throwable object collides with something (likely the ground)
		public static const COLLIDE:String = "COLLISION";						//	When a player collides with something
		public static const NOCOLLIDE:String = "NO_COLLISION";					//	When a player falls off a ledge
		public static const JAM:String = "JAM";									//	When a player is touching jam;
		public static const THROW:String = "THROW";								//	When a player throws a new jam
			
		public var x:Number;			//	x position this occured at
		public var y:Number;			//	y position this occured at
		public var angle:Number;		//	Direction of the action
		public var magnitude:Number;	//	Magnitude of the event (such as throwing strength, or collision strength)
		
		
		//	Constructor: (String, Number, Number, Number, Number, Boolean, Boolean)
		public function PlayerEvent(type:String,x:Number, y:Number, angle:Number = 0, magnitude:Number = 0, bubbles:Boolean = true, cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			
			this.x = x;
			this.y = y;
			this.angle = angle;
			this.magnitude = magnitude;
		}
		
		//	Getter: HasNoMagnitude
		//	Returns true if an event has no magnitude; eg: has been initiated from idle
		public function get HasNoMagnitude():Boolean
		{
			return magnitude == 0;
		}
		
		//	Function: clone (OVERRIDE)
		//	Returns a reference to itself, once for each listener
		//		Makes for unsafe behaviour - it is important not to change the event in the listener.
		override public function clone():Event 
		{
			return this;
		}
		
		//	Function: toString (OVERRIDE)
		//	Returns the string representation of this event
		override public function toString():String 
		{
			return type + " at " + x.toString() + ";" + y.toString() + "| phi=" + angle.toString() + "| magnitude=" + magnitude.toString();
		}
	}

}