//	Copyright 2012 Jamazing Games
//	Author: Ivan Mateev
//	
//	The World object that holds all level data

package jamazing.jamstory.world 
{
	import jamazing.jamstory.object.BaseObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class World extends Sprite
	{
		private var levelContainer:Array;											// This will contain the level objects
		
		private var PlayeObjectPlaceHolderVariable:*;			// This will be of type player object later on

		// Constructor
		public function World(PlayerObjectReference:*=null) 
		{
			levelContainer = new Array();				// Construct an array
			
			AddPlayerObject(PlayerObjectReference);		// Add the player object to the world
			
			this.addEventListener(Event.ENTER_FRAME, onFrame);
		}

		// This adds the player to the world
		public function AddPlayerObject(PlayerObjectReference:*):void
		{
			if (PlayerObjectReference != null)							// If a player object has been passed ...
			{
				PlayeObjectPlaceHolderVariable=PlayerObjectReference;		// ... add it to the world ...
			}			
		}

		// This loads a level, based on a list of objects
		public function LoadLevelObjects(... args):void
		{
			for (var i:int = 0; i < args.lenght; i++)
			{
				levelContainer.push(args[i]);
				this.addChild(args[i]);
			}
		}

		// This handles the player movement
		public function onFrame(e:Event)
		{
			this.x = (stage.stageWidth / 2) + PlayeObjectPlaceHolderVariable.x;
			this.y = (stage.stageHeight / 2) + PlayeObjectPlaceHolderVariable.y;
		}					
	}

}