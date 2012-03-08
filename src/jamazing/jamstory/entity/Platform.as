//	Copyright 2012 Jamazing Games©
//	Author: Gordon D Mckendrick, Ivan Mateev
//
//	Platform
//		Represents a platform



package jamazing.jamstory.entity 
{
	import flash.display.Bitmap;
	import flash.events.Event;
	import jamazing.jamstory.engine.Resource;
	
	public class Platform extends Static
	{		
		public function Platform(x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0, bitmapData:Bitmap = null)  
		{
			super(x, y, width, height, bitmapData);
			
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	Function: onInit
		//	Initialisation once added to the stage
		private function onInit(e:Event = null):void
		{
			hitbox = new BoxCollidable(x, y, trueWidth, trueHeight);
			
			graphics.beginFill(0xFF6600);
			graphics.drawRect( -trueWidth / 2, -trueHeight / 2, trueWidth, trueHeight);
			graphics.endFill();
			
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
	}

}