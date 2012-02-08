package vanchizzle 
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * This holds all level objects
	 * @author Ivan
	 */
	public class WorldObject extends Sprite
	{
		private var levelContainer:Array;											// This will contain the level objects
		
		private var PlayeObjectPlaceHolderVariable:PlayerPlaceHolderClass;			// This will be of type player object later on

		// Constructor
		public function WorldObject(var PlayerObjectReference:PlayerPlaceHolderClass=null) 
		{
			levelContainer = new Array();				// Construct an array
			
			AddPlayerObject(PlayerObjectReference);		// Add the player object to the world
			
			this.addEventListener(Event.ENTER_FRAME, onFrame);
		}

		// This adds the player to the world
		public function AddPlayerObject(var PlayerObjectReference:PlayerPlaceHolderClass):void
		{
			if (PlayerObjectReference != null)							// If a player object has been passed ...
			{
				PlayeObjectPlaceHolderVariable=PlayerObjectReference;		// ... add it to the world ...
			}			
		}

		// This loads a level, based on a list of objects
		public function LoadLevelObjects(... args:GenericWorldObject):void
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