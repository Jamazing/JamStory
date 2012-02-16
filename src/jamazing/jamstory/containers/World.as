//	Copyright 2012 Jamazing Games
//	Author: Ivan Mateev
//	Contrib: Gordon D Mckendrick
//	The World object that holds all level data

package jamazing.jamstory.containers
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import jamazing.jamstory.object.Platform;
	
	import jamazing.jamstory.entity.Player;
	
	public class World extends Sprite
	{
		private var levelContainer:Array;	// This will contain the level objects
		public var player:Player;			//	The player object
		public var length:Number;			//	x value for the end of the level
		public var ceiling:Number;			//	y value for the ceiling of the level
		
		// Constructor
		public function World() 
		{
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}

		
		//	Function: onInit
		//	Initialises this, once the stage reference has been formed
		public function onInit(e:Event = null):void
		{
			
			//	HACKY CODE
			//	Graphics for setting the registration point artificially
			//	Allows 0,0 to be the bottom left, and then height to be a height from ground
			graphics.beginFill(0xFF0000, 0.8);
			graphics.drawCircle(0, 0, 50);
			graphics.endFill();
			//	END OF HACKY CODE
			
			
			trace("world loaded");
			//	Memory Allocations
			levelContainer = new Array();
			player = new Player();
			loadLevel();
			

			
			//	Child Objects
			
			//	Event Listeners
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(Event.ENTER_FRAME, onTick);
		}
		
		
		//	Listener: onTick
		//	Listens for the new frame, and sets the x and y to keep the player in the center of the stage
		public function onTick(e:Event):void
		{
			//	Update the world x and y so the player is always centered
			//		Check the player is in bounds on the x-direction
			if ((player.x < (length - stage.stageWidth / 2))
				&& (player.x > stage.stageWidth/2)){
				this.x = (stage.stageWidth / 2) - player.x;
			}
			
			//		Check the player is in bounds on the y-direction
			if (player.y > (ceiling - stage.stageHeight / 2)) {
				this.y = (stage.stageHeight / 2) - player.y;
			}
			
			//	Ensure the player stays in bounds
			if (player.x < 0) {
				player.x = 0;
			}else if (player.x > length-100) {
				player.x = length-100;
			}
			
			
			
		}
		
		
		//	Function: loadLevel()
		//	Loads the level data into objects
		public function loadLevel():void
		{
			var loader:URLLoader = new URLLoader();
			loader.load(new URLRequest("./extern/level.xml"));
			 
			loader.addEventListener(Event.COMPLETE, onLoadXML);
		}
		
		
		//	Listener: onLoadXML
		//	Fires when the level XML has finished loading
		public function onLoadXML(e:Event):void
		{
			var xml:XML = new XML(e.target.data);
			
			//	loading the main data
			var info:XMLList = xml.level.info;
			for each (var i:XML in info) {
				length = i.width;
				ceiling = i.height;
			}
			
			//	loading the platforms
			var statics:XMLList = xml.level.statics.obj;
			for each (var p:XML in statics) {
				var platform:Platform = new Platform(p.x, -p.y, p.width, p.height);
				levelContainer.push(platform);
				addChild(platform);
			}
			
			x = 0;
			y = stage.stageHeight;
			
			//	Add the player
			addChild(player);
			
			player.x = 50;
			player.y = -135;
			
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