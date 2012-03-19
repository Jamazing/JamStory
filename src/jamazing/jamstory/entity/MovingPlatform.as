//	Copyright 2012 Jamazing Games©
//	Author: Ivan Mateev
//
//	MovingPlatform
//		Represents a moving platform

/*
 * At present is just a placeholder
 */


package jamazing.jamstory.entity 
{
	import flash.events.Event;
	import flash.geom.Point;
	import jamazing.jamstory.language.Queue;
	
	public class MovingPlatform extends Dynamic 
	{
		private var headings:Queue;
		private var distanceToNextHeading:Number;
		
		// Constructor 
		public function MovingPlatform(inputX:Number, inputY:Number, inputWidth:Number, inputHeight:Number, inputSpeed:Number = 1) 
		{
			// Dynamic doesn't know how to handle MovingPlatform constructor arguments, but static does. Do i modify dynamic?
			super();		
			
			headings = new Queue();									// Initialize queue
			headings.Enque(new Point(inputX, inputY));				// Add initial point to headings
			
			distanceToNextHeading = 0;								// Initialize distance
			
			if (stage)	onInit();
			else	addEventListener(Event.ADDED_TO_STAGE, onInit);
		}

		//	Function: onInit
		//	Initialisation once added to the stage
		private function onInit(e:Event = null):void
		{				
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(Event.ENTER_FRAME, onTick);
		}

		//	Function: changeDirection
		//	Changes heading
		private function changeDirection():void
		{
			if (headings == null || currentHeading == null || headings.isEmpty())	// If something is not right
				return;										// just return				
				
			headings.Enque(headings.Deque());				//	Add the current heading to the back of the queue
						
			distanceToNextHeading = Point.distance(currentLocation, currentHeading);	// Update the distance variable
		}
		
		private function onTick(e:JamStoryEvent):void
		{	
			if (currentLocation == currentHeading)		// If currentHeading has been reached...
			{
				changeDirection();							// ... change direction
				// Note: try adding a return here - may induce one frame delay if needed?
			}
		}

		//	Getter: currentLocation
		//	Returns the current location as a point
		private function get currentLocation():Point
		{
			return new Point(x, y);
		}

		//	Getter: currentHeading
		//	Returns the current heading as a point
		private function get currentHeading():Point
		{
			if (headings == null || headings.isEmpty())	// if something is wrong...
				return null;								// ... return null
				
			return headings.Front;						// return the front of the queue
		}
		
	}

}