//	Copyright 2012 Jamazing Games©
//	Author: Ivan Mateev
//
//	Queue
//		Queue implementation

package jamazing.jamstory.language 
{

	public class Queue 
	{
		private var container:Array;					// Actually an array
		private var maxSize:int;						// Maximum size
		
		// Constructor
		// Takes one optional variable
		public function Queue(inputMaxSize:int=-1) 
		{
			container = new Array();					// Initialize the array
			maxSize = inputMaxSize;			
		}
		
		// Function: Enque
		// Adds an alement to the back of the queue; if maxSize is defined, the last first element will be dequed
		public function Enque(inputElement:*):void
		{				
			container.push(inputElement);	// Simple push will do

			if (size == maxSize)
				Deque();	
		}
		
		//	Function: Deque
		//	Removes an element from the front of the queue and returns it; returns null if there are no elements to return
		public function Deque():*
		{
			if (size == 0)		// If there are no elements to return ...
				return null;		// ... return null
			
			var returnValue:* = container[size-1];	// This variable will contain the 

			container.splice(size-1);				// Remove the last element; contrary to slice, this works in-place
			
			return returnValue;						// And return the value of the last element
		}
		
		//	Getter: Size
		//	Returns the size of the queue
		public function get size():int
		{
			return container.length;	// Simply return the length of the array
		}

		//	Getter: MaxSize
		//	Returns the maximum possible size of the queue. If such isn't specified, returns Not-a-number.
		public function get MaxSize():Number
		{
			return maxSize >= 0 ? maxSize : Number.NaN;
		}
		
		//	Function: isEmpty
		//	Returns if the queue is empty
		public function isEmpty():Boolean
		{
			return size == 0;
		}
		
	}

}