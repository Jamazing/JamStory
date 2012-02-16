//	Copyright 2012 Jamazing Games ©
//	Author: Gordon D Mckendrick
//	WorldTest
//		Test Class to check the World class is functioning correctly


package src.jamazing.jamstorytesting.containers
{
	import flash.display.Sprite;
	import flash.events.Event;

	//	Class: WorldTest
	public class WorldTest extends Sprite
	{
		private var world:World;	//	World object needing tested
		
		//	Constructor: default
		public function TestMain() 
		{
			if (stage) onInit;
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		
		//	Function: onInit
		//	Initialises this test class
		private function onInit(e:Event = null):void
		{
			//	Memory allocation
			world = new World();
			
			//	Child objects
			addChild(world);
			
			//	Event listeners
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onTick(e:Event):void
		{
		}
	
		
	}

}