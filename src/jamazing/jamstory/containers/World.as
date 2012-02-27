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
	import flash.utils.ByteArray;
	import jamazing.jamstory.entity.TestPlayer;
	import jamazing.jamstory.events.WorldEvent;
	import jamazing.jamstory.object.Platform;
	import jamazing.jamstory.object.Throwable;
	import jamazing.jamstory.util.Keys;
	import jamazing.jamstory.events.PlayerEvent;
	import jamazing.jamstory.util.Resource;
	
	import jamazing.jamstory.entity.Player;
	
	public class World extends Sprite
	{
		private var staticObjects:Array;	//	This will contain the level objects
		private var dynamicObjects:Array;	//	Objects for which collision detection is necessary
		private var entities:Array;			//	Living Entities, such as enemies

		static private const TWELVE:Number = 12;	// This is to remind me that there is something todo
														// -Ivan
		
		public var player:Player;// TestPlayer;		//	The player object
		public var length:Number;			//	x value for the end of the level
		public var ceiling:Number;			//	y value for the ceiling of the level
		
		// Constructor: default
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
			staticObjects = new Array();
			dynamicObjects = new Array();
			entities = new Array();
			
			player = new Player;// TestPlayer();
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
			
			//	Check the player is in bounds on the y-direction
			if (player.y > (ceiling - stage.stageHeight / 2)) {
				this.y = (stage.stageHeight / 2) - player.y;
			}
			
			//	Ensure the player stays in bounds
			if (player.x < 0) {
				player.x = 0;
			}else if (player.x > length-100) {
				player.x = length-100;
			}
			
			testCollisions();
		}

		
		private	var playerHitAnnouncement:PlayerEvent = null;
		private function testCollisions():void
		{
			var test:Boolean = false;
			
			for each (var platform:Platform in staticObjects) {
				if (platform.isHit(player.collidable)) {
					playerHitAnnouncement = new PlayerEvent(PlayerEvent.COLLIDE, platform.x, platform.y - platform.height / 2, player.PlayerSpeed , 0);
					stage.dispatchEvent(playerHitAnnouncement);// used to be (, player.xSpeed, 0));
					trace("hit");
					test = true;
				}
			}
			
			trace(test);
			
			if (!test)
				if (playerHitAnnouncement!=null)
				{
					stage.dispatchEvent(new PlayerEvent(PlayerEvent.NOCOLLIDE, playerHitAnnouncement.x, playerHitAnnouncement.y, player.PlayerSpeed, 0));
				}
			
			for each (var platform:Platform in staticObjects) {
				for each (var throwable:Throwable in dynamicObjects) {
					if (platform.isHit(throwable.collidable)) {
						throwable.dispatchEvent(new PlayerEvent(PlayerEvent.THROWABLE_COLLISION, platform.x, platform.y - platform.height/2));
					}
				}
			}
		}
		
		//	Function: loadLevel()
		//	Loads the level data into objects
		public function loadLevel():void
		{
			var bytes:ByteArray = (new Resource.LEVEL()) as ByteArray;
			var s:String = bytes.readUTFBytes( bytes.length);
			var xml:XML = new XML(s);
			
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
				staticObjects.push(platform);
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
			var throwable:Throwable = new Throwable();
			
			//	Draw the thrown object for easy testing
			throwable.graphics.beginFill(0x0066FF);
			throwable.graphics.drawCircle(0, 0, 10);
			throwable.graphics.endFill();
			
			//calculate position for the new shape
			throwable.x = e.x;
			throwable.y = e.y;
			
			//	Add to the display list
			addChild(throwable);
			dynamicObjects.push(throwable);
			throwable.throwPolar(e.magnitude, e.angle);
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