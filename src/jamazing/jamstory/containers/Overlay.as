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
	
	
		
	public class Overlay extends Sprite
	{
		[Embed(source="../../../../resources/jamjar.png")]
		private var foreImage:Class;
		
		private var jamjar:Bitmap;
		private var text:TextField;
		
		public function Overlay() 
		{
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(e:Event = null):void
		{
			//	Memory Allocation
			jamjar = new foreImage();
			text = new TextField();
			
			//	Variable Initialisation
			//		JamJar initialisation
			jamjar.width = 250;
			jamjar.height = 250;
			jamjar.rotation = 45;
			jamjar.x = 50;
			jamjar.y = stage.stageHeight - 200;
			
			//		Overlay Text "JamStory"
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
			addChild(jamjar);
			addChild(text);
			
			//	Event Listeners
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
	}

}