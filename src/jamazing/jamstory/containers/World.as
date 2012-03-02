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
	import jamazing.jamstory.entity.Collectable;
	import jamazing.jamstory.entity.Dynamic;
	import jamazing.jamstory.entity.Jam;
	import jamazing.jamstory.entity.JumpingEnemy;
	import jamazing.jamstory.events.JamStoryEvent;
	
	import jamazing.jamstory.engine.Keys;
	import jamazing.jamstory.engine.Resource;
	import jamazing.jamstory.entity.Static;
	import jamazing.jamstory.entity.Throwable;
	import jamazing.jamstory.events.WorldEvent;
	import jamazing.jamstory.events.PlayerEvent;
	import jamazing.jamstory.entity.Player;
	import jamazing.jamstory.engine.Camera;
	import jamazing.jamstory.entity.Platform;
	
	//	Class: World
	public class World extends Sprite
	{
		private const MAX_JAM:int = 5;			//	Determines the jam limit
		
		private	var lastPlayerHitAnnouncement:PlayerEvent = null;	//	Holds the last PlayerEvent thrown	

		private var jamCount:int;				//	Counts how much jam do we have in the world
		
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
			jamCount = 0;
			
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
			stage.addEventListener(JamStoryEvent.CAMERA_POSITION, onCamera);
		}
		
		
		//	Listener: onTick
		//	Listens for the new frame, and sets the x and y to keep the player in the center of the stage
		public function onTick(e:Event):void
		{
			//	Ensure the player stays in bounds
			if (player.x < 0) {
				player.x = 0;
			}else if (player.x > length-100) {
				player.x = length-100;
			}
			
			//	Test collisions
			testCollisions();
			
			//	Test jam limits
			testJam();
			
			Camera.setFocus(player);
		}
		
		//	Function: testJam
		//	Removes jam if necesary (and possible)
		private function testJam():void
		{
				for (var index:int = 0; index != dynamicObjects.length; index++)	// Traverse over all jam
				{
					if (jamCount <= MAX_JAM)	// If in jam limits ...
						return;						// ... no need to fix up, so return
							
					if (dynamicObjects[index] as Jam != null)			// If the seclected object is a jam...
					{
						if ((dynamicObjects[index] as Jam).isSplatted)		// ... and is splatted
						{
							removeChild(dynamicObjects[index]);					// ... remove it from the world
							dynamicObjects.splice(index, 1);					// ... remove it from the array
							
							index = 0;					// ... reset the indexer
							
							jamCount--;
							
							continue;											// ... start over
						}
					}
				}
		}
		
		
		//	Function: onCamera
		//	Updates the viewing position to where the camera tells it to be
		private function onCamera(e:JamStoryEvent):void
		{
				this.x = (stage.stageWidth/2) - e.x * 1;
				this.y = (stage.stageHeight/2 + 80) - e.y * 1;
		}

		//	Function: testCollisions
		//	Checks through possible collisions in the world and dispatches the events for thems
		private function testCollisions():void
		{	
			var hasPlayerEventOccured:Boolean = false;
			
			//	Check collisions between the player and staticObjects
			for each (var staticObject:Static in staticObjects) {
				if (staticObject as Platform != null)	// If the static object is a platform
				{
					if (staticObject.isHit(player.collidable)) {
						lastPlayerHitAnnouncement = new PlayerEvent(PlayerEvent.COLLIDE, staticObject.x, staticObject.y - staticObject.height / 2, 0, player.PlayerSpeed);

						stage.dispatchEvent(lastPlayerHitAnnouncement);
						
						hasPlayerEventOccured = true;
					}
				}
				else if (staticObject as Collectable != null)	// Or if the static object is a collectable
				{
					if (staticObject.isHit(player.collidable))
					{
						staticObject.visible = false;
					}
				}
			}

			if (!hasPlayerEventOccured)
				if (lastPlayerHitAnnouncement!=null && !lastPlayerHitAnnouncement.HasNoMagnitude)
					stage.dispatchEvent(new PlayerEvent(PlayerEvent.NOCOLLIDE, lastPlayerHitAnnouncement.x, lastPlayerHitAnnouncement.y, 0, player.PlayerSpeed));
			
			//	Check collisions between each dynamic object (non-player) and each static object
			for each (var staticObject:Static in staticObjects) {
				if (staticObject as Platform != null)
				{
					/*
					 * This gets transformed slightly
					 * -Ivan
					
					 for each (var throwable:Throwable in dynamicObjects) {
						if (staticObject.isHit(throwable.hitbox)) {
							throwable.dispatchEvent(new PlayerEvent(PlayerEvent.THROWABLE_COLLISION, staticObject.x, staticObject.y - staticObject.height/2));
						}
					}
					*/
					for each (var dynamicObject:Dynamic in dynamicObjects)
					{
						if (dynamicObject as Throwable != null)
						{
							if (staticObject.isHit(dynamicObject.hitbox)) {
								dynamicObject.dispatchEvent(new PlayerEvent(PlayerEvent.THROWABLE_COLLISION, staticObject.x, staticObject.y - staticObject.height/2));
							}		
						}
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
			Camera.setLimits(stage.stageWidth/2, length-stage.stageWidth/2, -ceiling,0);
			
			//	loading the platforms
			var statics:XMLList = xml.level.statics.obj;
			for each (var p:XML in statics) {
				var platform:Platform = new Platform();// Static = new Static();
				platform.trueWidth = p.width;
				platform.trueHeight = p.height;
				staticObjects.push(platform);
				platform.x = p.x;
				platform.y = -p.y;
				addChild(platform);
			}
			
			//	Add the player
			addChild(player);
			
			player.x = 50;
			player.y = -90;
			
			/* NOTE: This is only for test purposes! */
			// Create a jumper:
			
			var enemy:JumpingEnemy = new JumpingEnemy();
			dynamicObjects.push(enemy);
			enemy.y = -90;
			enemy.x = player.x+10;
			addChild(enemy);
			
			
			// Create a powerup:
			var CollectableTest:Collectable = new Collectable();
			staticObjects.push(CollectableTest);
			CollectableTest.x = 50
			CollectableTest.y = -130;
			addChild(CollectableTest);

			var platformCounter:int = 3;	// This is because of the commented code below; uncommend and remove the counter to see issues
			
			for each(var pl:Static in staticObjects)
			{
				if (platformCounter < 0)
					break;
				
				var newCollectable:Collectable = null;
				
				if (pl as Platform != null)
				{
					platformCounter--;
					
					newCollectable = new Collectable();
					newCollectable.trueWidth = pl.width;
					newCollectable.trueHeight = pl.height;
					staticObjects.push(newCollectable);
					newCollectable.x = (pl as Platform).hitbox.x;
					newCollectable.y = (pl as Platform).hitbox.y-40;
					addChild(newCollectable);
				}
				
			}
		}
		
		//	Listener: onThrow
		//	Listens for the player throwing a new object
		private function onThrow(e:PlayerEvent):void
		{
			var jam:Jam = new Jam();
			
			//calculate position for the new shape
			jam.x = e.x;
			jam.y = e.y;
			
			//	Add to the display list
			addChild(jam);
			dynamicObjects.push(jam);
			jam.throwPolar(e.magnitude, e.angle);
			
			//	Update count
			jamCount++;
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