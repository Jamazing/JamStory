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
		private var headings:Queue = null;
		
		// Constructor 
		public function MovingPlatform(inputX:Number, inputY:Number, inputWidth:Number, inputHeight:Number, inputSpeed:Number = 1) 
		{
			// Dynamic doesn't know how to handle MovingPlatform constructor arguments, but static does. Do i modify dynamic?
			super();		
			
			headings = new Queue();									// Initialize queue
			headings.Enque(new Point(inputX, inputY));				// Add initial point to headings
			
			
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
				
			headings.Enque(currentHeading);				//	Add the current heading to the back of the queue
			
			currentHeading = headings.Deque();			//	Take the new heading from the front of the queue
		}
		
		private function onTick(e:JamStoryEvent):void
		{	
			if (currentLocation == currentHeading)		// If currentHeading has been reached...
			{
				changeDirection();							// ... change direction
				// Note: try adding a return here - may induce one frame delay if needed?
			}
				
			return;
		}
		
		private function get currentLocation():Point
		{
			return new Point(x, y);
		}
		
		private function get currentHeading():Point
		{
			if (headings == null || headings.isEmpty())
				return null;
				
			return headings.Front;
		}
		
	}

}