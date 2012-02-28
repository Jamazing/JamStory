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
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(e:Event = null):void
		{
			hitbox = new BoxCollidable(x, y, trueWidth, trueHeight);
			
			graphics.beginFill(0xFF6600);
			graphics.drawRect( -trueWidth / 2, -trueHeight / 2, trueWidth, trueHeight);
			graphics.endFill();
			
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	Function: isHit
		//	Returns true if it's colliding with the given Collidable
		public function isHit(c:Collidable):Boolean
		{
			return hitbox.isHit(c);
		}
	}

}