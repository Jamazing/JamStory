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
		public function Static(inputX:Number = 0, inputY:Number = 0, inputWidth:Number = 0, inputHeight:Number = 0, inputBitmapData:Bitmap = null)
		{
			trueWidth = inputWidth;
			trueHeight = inputHeight;
			x = inputX;
			y = inputY;
						
			bitmap = inputBitmapData;
			
			super();
			super.x = inputX;
			super.y = inputY;
			
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