//	Copyright 2012 Jamazing games©
//	Author: Ivan Mateev
//	WorldEvent
//		Fired when there has been a colision etc

package jamazing.jamstory.events 
{
	import flash.events.Event;
	
	public class WorldEvent extends Event 
	{
		public static const STATIC_COLLIDE:String = "STATIC_OBJECT_COLLIDE";	// Eg. with a platform
		
		/* Location of event */
		private var xLocation:Number;
		private var yLocation:Number;
		/* end here */
		
		/* Variables that contain information about the response from the world */
		private var angle:Number;		// Eg. for bouncing?
		private var magnitude:Number;
		/* end here */
		
		
		public function WorldEvent(type:String, inputXLocation:Number, inputYLocation:Number, inputMagnitude:Number, inputAngle:Number, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);

			/* Initialize variables */
			xLocation = inputXLocation;
			yLocation = inputYLocation;
			angle = inputAngle;
			magnitude = inputMagnitude;
		} 
		
		public override function clone():Event 
		{ 
			return new WorldEvent(type, xLocation, yLocation,magnitude,angle, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("WorldEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}