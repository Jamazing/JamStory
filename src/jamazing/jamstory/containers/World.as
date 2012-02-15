//	Copyright 2012 Jamazing Games
//	Author: Ivan Mateev
//	Contrib: Gordon D Mckendrick
//	The World object that holds all level data

package jamazing.jamstory.containers
{
	import flash.net.URLRequest;
	import jamazing.jamstory.object.BaseObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class World extends Sprite
	{
		private var levelContainer:Array;	// This will contain the level objects
		public var player:Player;			//	The player object
		public var endX:Number;			//	x value for the end of the level
		public var endY:Number;			//	y value for the ceiling of the level
		
		
		// Constructor
		public function World() 
		{
			if (stage) onInit;
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}

		
		//	Function: onInit
		//	Initialises this, once the stage reference has been formed
		public function onInit(e:Event = null):void
		{
			//	Memory Allocations
			levelContainer = new Array();
			player = new Player();
			
			//	Variable Initialisations
			endX = -500;
			endY = 0;
			
			//	Child Objects
			addChild(player);
			
			//	Event Listeners
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(Event.ENTER_FRAME, onTick);
		}
		
		
		//	Listener: onTick
		//	Listens for the new frame, and sets the x and y to keep the player in the center of the stage
		public function onTick(e:Event)
		{
			//	Update the world x and y so the player is always centered
			//		Check the player is in bounds on the x-direction
			if (player.x < (endX-stage.stageWidth/2)){
				this.x = (stage.stageWidth / 2) + player.x;
			}
			//		Check the player is in bounds on the y-direction
			if (player.y > (endY - stage.stageHeight / 2)) {
				this.y = (stage.stageHeight / 2) + player.y;
			}
		}
		
		
		//	Function: loadLEvel()
		//	Loads the level data into objects
		public function loadLevel():void
		{
			var xml:XML = new XML(new URLRequest("./extern/level.xml"));
		}
		
		
		//	Function: toggleZoom (Boolean)
		//	Set true to zoom the world view or not
		public function toggleZoom(isZoomed:Boolean):void
		{
			if (isZoomed) {
				setZoom(0.8);
			}else {
				setZoom(1);
			}
		}

		//	Function: setZoom (Number)
		//	Sets the zoom level for this object
		private function setZoom(factor:Number):void
		{
			scaleX = factor;
			scaleY = factor;
		}
	}

}