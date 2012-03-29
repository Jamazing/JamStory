//	Copyright 2012 Jamazing Games©
//	Author: Gordon Mckendrick
//
//	Main
//		Controls the initialisation and game timing
//		Throws events for each stage of the game

package jamazing.jamstory
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import jamazing.jamstory.engine.Camera;
	import jamazing.jamstory.engine.Resource;
	
	import jamazing.jamstory.containers.Layer;
	import jamazing.jamstory.events.JamStoryEvent;
	import jamazing.jamstory.engine.Keys;
	import jamazing.jamstory.containers.World;
	import jamazing.jamstory.containers.Background;
	import jamazing.jamstory.containers.Overlay;
	
	
	//	Class: Main
	public class Main extends Sprite 
	{
		private var background:Layer;	//	Background container
		//private var world:World;		//	World container
		private var game:Game;
		private var overlay:Overlay;	//	UI Overlay container
		
		private var tickCount:int;
		
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
			var focusCam:Camera = new Camera(stage);
			background = new Layer(-0.3);
			//world = new World(Resource.LEVELS[0]);	//	Load the specified array index level
			overlay = new Overlay();
			game = new Game(stage);
			
			var keys:Keys = new Keys(stage);	//	Initialise the static Keys Utility
			
	
			tickCount = 0;
			
			//	Main background to avoid white spots
			this.graphics.beginFill(0x0066FF);
			this.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			this.graphics.endFill();
			
			//	Setup the background layer
			addChild(background);
			var art:Bitmap = new Resource.BACKGROUND_IMAGE();
			art.alpha = 0.6;
			background.addArt(0, 0, stage.stageWidth*1.5, stage.stageHeight*1.2, art);
			
			//addChild(world);
			addChild(overlay);
			
			
			//	Add the music and play it to start (does not loop)
			var music:Sound = new Resource.SOUND_BGMUSIC();
			music.play();
			
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(Event.ENTER_FRAME, onTick);
		}
		
		//	Function: onTick
		//	Throws the relevant type of tick event
		private function onTick(e:Event):void
		{
			tickCount++;
			stage.dispatchEvent(new JamStoryEvent(JamStoryEvent.TICK, tickCount));
			stage.dispatchEvent(new JamStoryEvent(JamStoryEvent.TICK_MAIN, tickCount));
		}
		
	}
	
}