//	Copyright 2012 Jamazing Games©
//	Author: Gordon D Mckendrick
//
//	Platform
//		Temporary Class
//		Represents a platform you can jump on and run around

package jamazing.jamstory.entity 
{
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import jamazing.jamstory.entity.BoxCollidable;
	
	//	Class: Platform
	public class Static extends Sprite
	{
		public var bitmap:Bitmap;
		public var hitbox:Collidable;
		
		public var trueWidth:Number;
		public var trueHeight:Number;
		
		//	Constructor: (int, int, int, int, int)
		public function Static() 
		{
			super();
		}
		
		//	Function: isHit
		//	Returns true if it's colliding with the given Collidable
		public function isHit(c:Collidable):Boolean
		{
			return hitbox.isHit(c);
		}
	}

}