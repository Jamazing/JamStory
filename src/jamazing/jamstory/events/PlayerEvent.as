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
		/* I know this is a bit different, than originally talked about, but it was quite difficult
		 * to implement the original idea as I still don't quite get it;
		 * In this implementation, I've implemented the concept, that the player object will dispatch an
		 * "attempt collide" event, which will be caught by the world, which will dispatch an event, telling
		 * the player object about what has been hit, *if* something has been hit.
		 * This is to have something working. I am willing to approach the original idea if required, but I will need
		 * a more detailed explanation.
		 * -Ivan
		 */
		public static const COLLIDE:String = "COLLISION";			//	When a player collides with something
		public static const JAM:String = "JAM";						//	When a player is touching jam;

		public static const THROW:String = "THROW";
		
		public var x:Number;		//	X position this occured at
		public var y:Number;		//	Y position this occured at
		public var angle:Number;	//	Direction of the action
		public var magnitude:Number;
		
		//	Constructor: default
		public function PlayerEvent(type:String,x:Number, y:Number, angle:Number, magnitude:Number, bubbles:Boolean = true, cancelable:Boolean = false) 
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