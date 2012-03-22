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
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.geom.Point;
	import jamazing.jamstory.language.Queue;
	import jamazing.jamstory.events.JamStoryEvent;
	public class MovingPlatform extends Dynamic 
	{
		private var headings:Queue;
		private var distanceToNextHeading:Number;
		private var platformSpeed:Number;
		
		// Constructor 
		public function MovingPlatform(inputX:Number, inputY:Number, inputWidth:Number, inputHeight:Number, inputSpeed:Number = 0.2, inputBitmapData:Bitmap=null) 
		{
			super(inputX, inputY, inputWidth, inputHeight, inputBitmapData);
			
			headings = new Queue();									// Initialize queue
			headings.Enque(new Point(inputX, inputY));				// Add initial point to headings
			
			distanceToNextHeading = 0;								// Initialize distance
			
			platformSpeed = inputSpeed;
			
			visible = false;
			
			if (stage)	onInit();
			else	addEventListener(Event.ADDED_TO_STAGE, onInit);
		}

		//	Function: onInit
		//	Initialisation once added to the stage
		private function onInit(e:Event = null):void
		{	
			visible = true;
			
			hitbox = new BoxCollidable(x, y, trueWidth, trueHeight);
			
			graphics.beginFill(0xFF6600);
			graphics.drawRect( -trueWidth / 2, -trueHeight / 2, trueWidth, trueHeight);
			graphics.endFill();
			
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(Event.ENTER_FRAME, onTick);
		}

		//	Function: changeDirection
		//	Changes heading
		private function changeDirection():void
		{
			if (headings == null || currentHeading == null || headings.isEmpty())	// If something is not right
				return;																	// just return				
				
			var prevHeading:* = headings.Deque();
			
			headings.Enque(prevHeading);					//	Add the current heading to the back of the queue
			
			distanceToNextHeading = remDistanceToNextHeading	// Update the distance variable
		}
		
		private function onTick(e:Event):void
		{	
			if (remDistanceToNextHeading<=1)					// If currentHeading has been reached...
			{
				changeDirection();							// ... change direction
				// Note: try adding a return here - may induce one frame delay if needed?
			}
			
			/* Using a vector equation:
				* 	v = a + t*b, where:
				* - a is the current location
				* - b is the current heading (given by the vector between the current heading and the current location)
				* - t is the platform speed
			*/
			
			xSpeed = platformSpeed * (currentHeading.x - currentLocation.x)/2;
			ySpeed = platformSpeed * (currentHeading.y - currentLocation.y)/2;
		}

		//  Getter: remDistanceToNextHeading
		//	Returns the remaining distance to next heading
		private function get remDistanceToNextHeading():Number
		{
			return Point.distance(currentLocation, currentHeading);	// Return the distance
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
		
		//	This should go in the constructor		
		public function addHeading(headingX:Number, headingY:Number)
		{
			headings.Enque(new Point(headingX, headingY));
		}
	}

}