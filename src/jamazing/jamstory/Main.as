//	Copyright 2012 Jamazing Games©
//	Author: Gordon Mckendrick
//
//	Main class for the JamStory game

package jamazing.jamstory
{
	import flash.display.Sprite;
	import flash.events.Event;
	import jamazing.jamstory.containers.World;
	import jamazing.jamstory.util.Keys;
	import jamazing.jamstory.containers.Background;
	import jamazing.jamstory.containers.Overlay;
	
	//	Class: Main
	public class Main extends Sprite 
	{
		
		private var background:Background;	//	Background container
		private var world:World;			//	World container
		private var overlay:Overlay;		//	UI Overlay container
		
		
		//	Constructor: default
		public function Main():void 
		{
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	Function: onInit
		//	Initialises the game once the stage is initialised
		private function onInit(e:Event = null):void 
		{	
			//	Memory Allocation
			background = new Background();
			world = new World()
			overlay = new Overlay();
			
			
			var keys:Keys = new Keys(stage);
			
			//	Children
			addChild(background);
			addChild(world);
			addChild(overlay);
			
			//	Event Listeners
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(Event.ENTER_FRAME, onTick);
		}
		
		//	Function: onTick
		//	Crontrols the game each frame
		private function onTick(e:Event):void
		{
		}
		
	}
	
}