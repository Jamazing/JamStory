//	Copyright 2012 Jamazing Games
//	Author: Gordon D Mckendrick
//
//	BoxCollidable
//		A collidable box shaped object

package jamazing.jamstory.object.Collidable 
{

	//	Class: BoxCollidable
	//	Represents a Box Shapes Collidable Object
	public class BoxCollidable extends Collidable
	{
		//internal var width:int;
		//internal var height:int;
		internal var angle:int;
		
		
		//	Constructor: default
		public function BoxCollidable(x:int, y:int, width:int, height:int)
		{
			super(x, y, width);
		}
		
		override public function isHit(c:Collidable):Boolean
		{
			return false;
		}
	}

}