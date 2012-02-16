//	Copyright 2012 Jamazing Games
//	Author: Gordon D Mckendrick
//	Background
//		The background as a container of any animations and effects wanted within it.
//		This should be generalised in future, but for now - is much simpler as it's own object type

package jamazing.jamstory.containers 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	//	Class: Background
	public class Background extends Sprite
	{
		[Embed(source="../../../../resources/kitchen.jpg")]
		private var bgImage:Class;
		private var staticBG:Bitmap;
		
		//	Constructor: default
		public function Background() 
		{
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	Function: onInit
		//	Initialises the object once it has a stage reference
		public function onInit(e:Event = null):void
		{
			//	Memory Allocation
			staticBG = new bgImage();
			staticBG.width = stage.stageWidth;
			staticBG.height = stage.stageHeight;
			
			//	Children
			addChild(staticBG);
			
			
			//	Event Listeners
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
	}

}