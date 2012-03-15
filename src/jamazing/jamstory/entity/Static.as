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
	import flash.events.Event;
	import flash.geom.Point;
	import jamazing.jamstory.entity.BoxCollidable;
	
	//	Class: Platform
	public class Static extends Sprite
	{
		public var bitmap:Bitmap;
		public var hitbox:Collidable;
		
		public var trueWidth:Number;
		public var trueHeight:Number;
		
		//	Constructor: default
		public function Static(x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0, bitmapData:Bitmap = null) 
		{
			this.trueWidth = width;
			this.trueHeight = height;
			this.x = x;
			this.y = y;
			
			this.bitmap = bitmapData;
	
			super();
			
		}
		
		//	Function: isHit
		//	Returns true if it's colliding with the given Collidable
		public function isHit(c:Collidable):int
		{
			if (hitbox) {
				return hitbox.isHit(c);
			}else {
				return Collidable.SIDE_NONE;
			}
		}
		
		/* Figured I should add this so all classes that extend wouldn't have to have their bitmap variable
		 * Will post a poll about this after commit
		 * -Ivan
		 */
		//	Function: changeAppearance
		//	Changes the appearance.
		protected function changeAppearance(bitmapData:Bitmap):void
		{
			bitmap = bitmapData;
		}
	}

}