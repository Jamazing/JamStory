//	Copyright 2012 Jamazing games©
//	Author: Ivan Mateev
//	Contrib: Gordon D Mckendrick
//
//	WorldEvent
//		Fired when there has been a colision etc


package jamazing.jamstory.events 
{
	import flash.events.Event;
	
	
	//	Class: WorldEvent
	public class WorldEvent extends Event 
	{
		
		public static const STATIC_COLLIDE:String = "STATIC_OBJECT_COLLIDE";	//	Collision between an object and a static object such as a platform.
		
		public var x:Number;			//	x position the event occurered at
		public var y:Number;			
		public var angle:Number;		//	Angle the event occured at (from the positive x direction)
		public var magnitude:Number;	//	Magnitude of the event, such as the velocity it occured at
		
		
		//	Constructor: (String, Number, Number, Number, Number, Boolean, Boolean)
		public function WorldEvent(type:String, x:Number, y:Number, magnitude:Number, angle:Number, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);

			this.x = inputXLocation;
			this.y = inputYLocation;
			this.angle = inputAngle;
			this.magnitude = inputMagnitude;
		} 
		
		//	Function: clone (OVERRIDE)
		//	Optimised for memory/CPU efficiency, at the cost of protection.
		//		Default is to return a new Event clone, this opimisation returns a reference to itself; saving memory and CPU time
		//		This leads to protection issues, as destroying the event at all, destroys it for all listeners
		public override function clone():Event 
		{ 
			return this;
		} 
		
		//	Function: toString (OVERRIDE)
		//	Returns the string representation of this event
		public override function toString():String 
		{ 
			return formatToString("WorldEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}