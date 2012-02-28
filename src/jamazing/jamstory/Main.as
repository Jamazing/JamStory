//	Copyright 2012 Jamazing Games©
//	Author: Gordon Mckendrick
//
//	Main
//		Controls the initialisation and game timing
//		Throws events for each stage of the game

package jamazing.jamstory
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import jamazing.jamstory.engine.Keys;
	import jamazing.jamstory.containers.World;
	import jamazing.jamstory.containers.Background;
	import jamazing.jamstory.containers.Overlay;
	import jamazing.jamstory.entity.PlayerTarget;
	
	
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
			background = new Background();
			world = new World();
			overlay = new Overlay();
			
			var keys:Keys = new Keys(stage);	//	Initialise the static Keys Utility
			
			addChild(background);
			addChild(world);
			addChild(overlay);
			
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(Event.ENTER_FRAME, onTick);
		}
		
		//	Function: onTick
		//	Throws the relevant type of tick event
		private function onTick(e:Event):void
		{
			
		}
		
	}
	
}