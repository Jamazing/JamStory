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
		public static const COLLIDES:String = "JAM";				//	When a player is touching jam
		
		public var x:Number;		//	X position this occured at
		public var y:Number;		//	Y position this occured at
		public var direction:int;	//	Direction of the collision
		
		//	Constructor: default
		public function PlayerEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false) 
		{
			//	!!!!Please Remove
			//		Only needed to allow compiling, not functionally correct
			x = 0;
			y = 0;
			direction = 0;
			//	!!!!Please Remove
			
			super(type, bubbles, cancelable);
		}
		
	}

}