//	Copyright 2012 Jamazing games©
//	Author: Gordon D Mckendrick
//	PlayerEvent
//		Fired when the player is involved in actions such as collisions etc


package jamazing.jamstory.events 
{
	import flash.events.Event;
	
	//	Class: PlayerEvent
	public class PlayerEvent extends Event
	{
		
		public static const COLLIDES:String = "STATIC_COLLISION";	//	When a player collides with a static object
		public static const JAM:String = "JAM";				//	When a player is touching jam
		public static const THROW:String = "THROW";
		
		public var x:Number;		//	X position this occured at
		public var y:Number;		//	Y position this occured at
		public var angle:Number;	//	Direction of the action
		public var magnitude:Number;
		
		//	Constructor: default
		public function PlayerEvent(type:String,x:Number, y:Number, angle:Number, magnitude:Number bubbles:Boolean = true, cancelable:Boolean = false) 
		{
			this.x = x;
			this.y = y;
			this.angle = angle;
			this.magnitude = magnitude;
			
			super(type, bubbles, cancelable);
		}
		
	}

}