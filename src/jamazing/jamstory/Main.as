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
	
	//	Class: Main
	public class Main extends Sprite 
	{
		
		private var world:World;	//	World container
		
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
			world = new World()
			var keys:Keys = new Keys(stage);
			
			//	Children
			addChild(world);
			
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