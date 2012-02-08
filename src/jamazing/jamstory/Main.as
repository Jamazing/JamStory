//	Copyright 2012 Jamazing Games©
//	Author: Gordon Mckendrick
//
//	Main class for the JamStory game

package jamazing.jamstory
{
	import flash.display.Sprite;
	import flash.events.Event;
	import jamazing.jamstory.util.KeyHandler;
	import jamazing.jamstory.world.World;
	import jamazing.jamstory.object.BaseObject;
	import jamazing.jamstory.object.LevelTransition;
	
	
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			//var world:World = new World();
			var keyhandler:KeyHandler = new KeyHandler(stage);
			var baseObject:BaseObject = new BaseObject();
			var levelTransition:LevelTransition = new LevelTransition();
		}
		
	}
	
}