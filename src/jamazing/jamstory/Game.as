//	Copyright 2012 Jamazing Games©
//	Author: Gordon D Mckendrick
//	
//	Game
//		Placeholder for the game class, which will represent the main game
//		Allow for loading of individual levels in order
//		Will simply allow a new level etc to be instantiated, and close the old one.
//		Takes over from the main.as functionality, but in a more flexible way.
//		This comment keeps on going for a long time.
//		I should stop writing it now.
//		Seriously this is a problem guys, I can't help myself.

package jamazing.jamstory 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	import jamazing.jamstory.containers.Level;
	import jamazing.jamstory.containers.World;
	import jamazing.jamstory.engine.Resource;
	import jamazing.jamstory.events.JamStoryEvent;
	
	public class Game
	{
	
		private var level:World;
		private var stage:Stage;
		private var levelNumber:int;
		
		//	Constructor that takes stage reference, and starting level number
		public function Game(stage:Stage, levelNumber:int = 0) 
		{
			this.stage = stage;
			this.levelNumber = levelNumber;
			
			//	Load the starting level
			level = new World(Resource.LEVELS[levelNumber]);
			stage.addChild(level);
			
			stage.addEventListener(JamStoryEvent.LEVEL_END, onLevelEnd);
		}
		
		
		//	Called when a level is complete, to move onto the next one
		private function  onLevelEnd(e:JamStoryEvent):void
		{
			level.kill();
			stage.removeChild(level);
			
			level = new World(Resource.LEVELS[++levelNumber]);
			stage.addChild(level);
		}
	}

}