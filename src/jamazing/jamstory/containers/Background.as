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
	import jamazing.jamstory.engine.Resource;
	
	//	Class: Background
	public class Background extends Sprite
	{
		private var staticBG:Bitmap;	//	Static background image of the game
		
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
			staticBG = new Resource.BACKGROUND_IMAGE();
			
			//staticBG.width = stage.stageWidth;
			//staticBG.height = stage.stageHeight;
			//staticBG.alpha = 0.5;
			
			addChild(staticBG);
			
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
	}

}