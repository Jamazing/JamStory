//	Copyright 2012 Jamazing Games©
//	Author: Gordon D Mckendrick
//	test_scalar
//		Testing of image scaling GUI for level editing
//		Functionality may be useful for other applications also

package jamazing.test_scaler 
{
	import flash.accessibility.Accessibility;
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	//	Class: test_scalar (as Main)
	public class test_scaler extends Sprite
	{
		
		public var img:image;
		public var start_mouseX:Number;
		public var start_mouseY:Number;
		
		
		//	Constructor: default
		public function test_scaler() 
		{
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(e:Event = null):void
		{
			img = new image();
			addChild(img);
			
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
		}
	}

}