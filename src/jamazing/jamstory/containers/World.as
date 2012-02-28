//	Copyright 2012 Jamazing Games
//	Author: Ivan Mateev
//	Contrib: Gordon D Mckendrick
//	The World
//		Holds all level data

package jamazing.jamstory.containers
{
	import flash.display.Shape;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	
	import jamazing.jamstory.engine.Keys;
	import jamazing.jamstory.engine.Resource;
	import jamazing.jamstory.entity.Static;
	import jamazing.jamstory.entity.Throwable;
	import jamazing.jamstory.events.WorldEvent;
	import jamazing.jamstory.events.PlayerEvent;
	import jamazing.jamstory.entity.Player;
	
	//	Class: World
	public class World extends Sprite
	{

		private	var lastPlayerHitAnnouncement:PlayerEvent = null;	//	Holds the last PlayerEvent thrown

		private var staticObjects:Array;	//	Array of Static level objects such as platforms
		private var dynamicObjects:Array;	//	Array of Dynamic objects such as throwables
		private var entities:Array;			//	Array of Living Entities, such as enemies
		
		public var player:Player;			//	The player object
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
			staticObjects = new Array();
			dynamicObjects = new Array();
			entities = new Array();
			player = new Player;
			
			loadLevel();
			
			x = 0;
			y = stage.stageHeight;
			
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

		//	Function: testCollisions
		//	Checks through possible collisions in the world and dispatches the events for thems
		private function testCollisions():void
		{
			var hasPlayerEventOccured:Boolean = false;
			
			//	Check collisions between the player and staticObjects
			for each (var platform:Platform in staticObjects) {
				if (platform.isHit(player.collidable)) {
					lastPlayerHitAnnouncement = new PlayerEvent(PlayerEvent.COLLIDE, platform.x, platform.y - platform.height / 2, 0, player.PlayerSpeed);

					stage.dispatchEvent(lastPlayerHitAnnouncement);// used to be (, player.xSpeed, 0));
					
					hasPlayerEventOccured = true;
				}
			}

			if (!hasPlayerEventOccured)
				if (lastPlayerHitAnnouncement!=null && !lastPlayerHitAnnouncement.HasNoMagnitude)
					stage.dispatchEvent(new PlayerEvent(PlayerEvent.NOCOLLIDE, lastPlayerHitAnnouncement.x, lastPlayerHitAnnouncement.y, 0, player.PlayerSpeed));
			
			//	Check collisions between each dynamic object (non-player) and each static object
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
			//	Load the XML as a byte array; to pass it through flash
			//		XML data -> ByteArray -> String -> XML Object
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