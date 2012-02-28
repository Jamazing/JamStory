//	Copyright 2012 Jamazing Games©
//	Author: Gordon D Mckendrick
//	Overlay
//		The overlay container within which the UI elements can be held
//		This runs over the top of all gameplay, so foreground art can be added here as well
//		Similar to the background, positioning is static
//			Should be devolved into a single static-container class along with the background

package jamazing.jamstory.containers 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.text.AntiAliasType;
	import jamazing.jamstory.util.Resource;
	
	//	Class: Overlay
	public class Overlay extends Sprite
	{
		private var frontGraphic:Bitmap;	//	Big character image for the front of the screen
		private var text:TextField;			//	Basic text overlay
		
		//	Constructor: default
		public function Overlay() 
		{
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	Function: onInit
		//	Initialises the overlay once added to the stage
		private function onInit(e:Event = null):void
		{
			frontGraphic = new Resource.CHARACTER_IMAGE();
			text = new TextField();
			
			//	JamJar initialisation
			frontGraphic.width = 250;
			frontGraphic.height = 250;
			frontGraphic.rotation = 45;
			frontGraphic.x = 50;
			frontGraphic.y = stage.stageHeight - 200;
			
			//	Overlay Text "JamStory"
			text.text = "JamStory";
			var format:TextFormat = text.getTextFormat();
			format.font = "Showcard Gothic";
			format.size = 45;
			format.bold = false;
			format.color = 0xFFBB11;
			text.setTextFormat(format);
			text.autoSize = TextFieldAutoSize.LEFT;
			text.x = 125;
			text.y = stage.stageHeight - 60;
			
			//	Child objects
			addChild(frontGraphic);
			addChild(text);
			
			//	Event Listeners
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
	}

}