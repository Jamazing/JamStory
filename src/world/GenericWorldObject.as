package vanchizzle 
{
	import flash.display.Sprite;
	
	/**
	 * This class represents an abstract class for world objects
	 * @author Ivan
	 */
	internal class GenericWorldObject extends Sprite 
	{
		private var xLocation:int;			// xLocation of object
		private var yLocation:int;			// yLocation of object
		private var isAbstract:Boolean;		// this controls if the class is abstract or not
		
		public function GenericWorldObject(var inputXLocation:int=0, var inputYLocation:int=0) 
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
	 */
	internal class PlayerPlaceHolderClass extends GenericWorldObject
	{
		public function PlayerPlaceHolderClass()
		{
			super();
		}
	}

}