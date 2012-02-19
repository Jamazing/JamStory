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
		/* The following will controll location */
		private var xLocation:int;			// xLocation of object
		private var yLocation:int;			// yLocation of object
		// private var isAbstract:Boolean;		Abstract class logic was phased out
		
		public function BaseObject(inputXLocation:int=0, inputYLocation:int=0) 
		{
			super();
			xLocation = inputXLocation;
			yLocation = inputYLocation;
		}
		
		public function get XLocation()
		{
			return xLocation;
		}
		
		public function set XLocation(value:Number)
		{
			xLocation = value;
		}		
		
		public function get YLocation()
		{
			return yLocation;
		}
		
		public function set YLocation(value:Number)
		{
			yLocation = value;
		}
		
	}
	
	/*
	 removed PlayerPlaceHolderClass
	 -Ivan
	*/

}