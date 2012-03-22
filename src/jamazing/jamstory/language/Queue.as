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
		
		//	Getter: Front
		//	Looks at what the first element is
		public function get Front():*
		{
			if (size == 0)		// If there are no elements to return ...
				return null;		// ... return null
			
			return container[0];	// return the last element
		}
		
		//	Setter: Back
		//	Same as Enque
		/* Not sure if usefull or just syntactic sugar; Since there is a getter of front, made sense to have a setter of back... */
		public function set Back(value:*):void
		{
			if (value == null)	// If value is null ...
				return;				// ... cant push nulls
			
			Enque(value);
		}
		
		//	Function: Deque
		//	Removes an element from the front of the queue and returns it; returns null if there are no elements to return
		public function Deque():*
		{
			var returnValue:* = Front;				// Get the front of the queue
			
			if (returnValue == null)					// If nothing was at the front ...
			{
				return null;								// ... queue must be empty, so return null :-]
			}
			
			container.splice(0,1);				// Remove the last element; contrary to slice, this works in-place
			
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
		
		//	Function: toString
		//	Returns a string representation of the queue
		public function toString()
		{
			if (isEmpty())				// If queue is empty ...
				return "[Empty Queue]";		// ... return empty queue message.
			
			var returnValue:String = new String();								// This variable will hold the entire representation					
			
			var elementRepresentation:String = null;							// This variable will hold the string representations of seperate contents
						
			for (var containerIterator:int = 0; containerIterator != container.length; containerIterator++)	// Go over every element in the queue
			{
				try																							// Try to get it's string representation
				{
					elementRepresentation = new String(container[containerIterator].toString());				// ... attempt to get it
				}
				catch (Exception)																			// Catch if the element doesn't have one
				{
					elementRepresentation = "[Element " + containerIterator.toString() + "]";					// ... and indicate that it's an element
				}
				
				returnValue += elementRepresentation + (containerIterator == container.length-1 ? '' : ',');// Update the return value
			}			
			
			return returnValue;
		}
		
	}

}