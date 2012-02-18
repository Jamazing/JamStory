//	Copyright 2012 Jamazing Games
//	Author: Ivan Mateev
//	Contrib: Gordon D Mckendrick
//	The World object that holds all level data

package jamazing.jamstory.containers
{
	import flash.display.Shape;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import jamazing.jamstory.object.Platform;
	import jamazing.jamstory.util.Keys;
	import jamazing.jamstory.events.PlayerEvent;
	
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
			//	Memory Allocations
			levelContainer = new Array();
			player = new Player();
			loadLevel();
			
			//	Variable Initialisation
			x = 0;
			y = stage.stageHeight;
			
			//	Event Listeners
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(Event.ENTER_FRAME, onTick);
			addEventListener(PlayerEvent.THROW, onThrow);
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
			
			if (Keys.isDown(Keys.Z)) {
				toggleZoom(true);
			}
			if (Keys.isDown(Keys.X)) {
				toggleZoom(false);
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
				var platform:Platform = new Platform(p.x, -p.y, p.width, p.height, p.colour);
				levelContainer.push(platform);
				addChild(platform);
			}
			
			//	Add the player
			addChild(player);
			
			player.x = 50;
			player.y = -90;
			
		}
		
		//	Listener: onThrow
		//	Listens for the player throwing a new object
		private function onThrow(e:PlayerEvent):void
		{
			trace("Player Event Caught: THROW");
			var throwable:Shape = new Shape();
			
			//	Draw the thrown object for easy testing
			throwable.graphics.beginFill(0x0066FF);
			throwable.graphics.drawCircle(0, 0, 10);
			throwable.graphics.endFill();
			
			//calculate position for the new shape
			throwable.x = e.x;
			throwable.y = e.y;
			throwable.y += e.magnitude * Math.sin(e.angle * (Math.PI / 180));
			throwable.x -= e.magnitude * Math.cos(e.angle * (Math.PI / 180));
			
			//	Add to the display list
			addChild(throwable);
		}
		
		//	Function: toggleZoom (Boolean)
		//	Set true to zoom the world view or not
		public function toggleZoom(isZoomed:Boolean):void
		{
			if (isZoomed) {
				setZoom(0.6);
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