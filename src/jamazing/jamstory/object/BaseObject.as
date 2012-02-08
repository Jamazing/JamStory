//	Copyright 2012 Jamazing Games
//	Author: Ivan Mateev
//
//	Base Object class
//	The base class for any objects in the world

package jamazing.jamstory.object 
{
	import flash.display.Sprite;
	

	public class BaseObject extends Sprite 
	{
		private var xLocation:int;			// xLocation of object
		private var yLocation:int;			// yLocation of object
		private var isAbstract:Boolean;		// this controls if the class is abstract or not
		
		public function BaseObject(inputXLocation:int=0, inputYLocation:int=0) 
		{
			super();
			xLocation = inputXLocation;
			yLocation = inputYLocation;
			isAbstract = true;
		}
		
		// This is used when creating objects, which are of a derived class; This indicates that a class is not abstract
		protected function createNonAbstractObject():void
		{
			this.isAbstract = false;
		}
		
		/* [TODO laster: Implement unplaceable logic] */
	}
	
	/*
	 * This is just a placeholder for until i can get the real thing in there
	 
	internal class PlayerPlaceHolderClass extends BaseObject
	{
		public function PlayerPlaceHolderClass()
		{
			super();
		}
	}
	*/

}