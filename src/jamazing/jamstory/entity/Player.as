//	Copyright 2012 Jamazing Games©
//	Author: Gordon D Mckendrick, Stefan Hristov, Ivan Mateev
//
//	Player Object
//		Represents the player in the level


package jamazing.jamstory.entity 
{
	import flash.display.ActionScriptVersion;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import jamazing.jamstory.engine.Keys;
	import jamazing.jamstory.engine.Resource;
	import jamazing.jamstory.object.Collidable.Collidable;
	import jamazing.jamstory.entity.PlayerTarget;
	import jamazing.jamstory.events.PlayerEvent;
	import jamazing.jamstory.events.WorldEvent;
	
	
	//	Class: Player
	public class Player extends Sprite
	{
		//	Constants
		static private const TWELVE:Number = 12;				//	??
		static private const MOVE_OFFSET:Number = 12;			//	This controls by how many pixels will the player object displace when movement is initiated		
		static private const GLOBAL_ACC_INTERVAL:Number = 10;	//	??
		static private const JUMP_SPEED:Number = 12;			//	Speed at which the player begins their jump
		static private const IDLE_JUMP_OFFSET:Number = 50;		//	??
		static private const JUMP_MODIFIER:Number = 12;			//	??
		static private const WALK_SPEED:Number = 12;			//	Speed the player moves when "walking"
		static private const RUN_SPEED:Number = 24;				//	Speed the player moves when "running"
		static private const FALL_MULTIPLIER:Number = 1.5;		// 	??	(1.5 feels better for some reason)

		public var collidable:Collidable;			//	Collision box of the player (radial)
		public var jamjar:Bitmap;					//	Bitmap image of the player character
		
		private var reticule:PlayerTarget;			//	Targetting system
		
		private var currentState:PlayerState;		//	Enum state of the current player state
		private var currentHeading:Direction;		//	Enum state of the direction currently heading

		private var accelerationInterval:Number;	//	??
		private var jumpTargetYOffset:Number;		//	??
		
		
		//	Constructor: default
		public function Player() 
		{
			super();
			if (stage) onInit();									
			else addEventListener(Event.ADDED_TO_STAGE, onInit);	
		}
		
		
		//	Listener: onInit (Event = null)
		//	Initialises the player once it's been added to the stage properly
		private function onInit(e:Event = null):void 
		{						
			//	Initialize the collidable
			collidable = new Collidable(x, y, 30);
			
			//	Initialise the reticule
			reticule = new PlayerTarget();
			addChild(reticule);
			
			//	These create the sprite...
			jamjar = new Resource.CHARACTER_IMAGE();
			jamjar.width = 75;
			jamjar.height = 75;
			addChild(jamjar);
			jamjar.x = -jamjar.width/2;		//	Ensure registration point is in the center
			jamjar.y = -jamjar.height/2;

			// These control where the player will spawn, relative to the stage
			x = stage.stageWidth / 10;
			y = stage.stageHeight / 2;
			
			// Initialize the player state
			currentState = new PlayerState(PlayerState.FALL);
			currentHeading = new Direction(Direction.RIGHT);
			
			// Initialize the acceleration counter variable
			accelerationInterval = GLOBAL_ACC_INTERVAL;
			
			// Initialize per-frame logic
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(Event.ENTER_FRAME, onTick);
			stage.addEventListener(PlayerEvent.COLLIDE, onCollide);
			stage.addEventListener(PlayerEvent.NOCOLLIDE, onNoCollide);
		}

		
		//	Function: onNoCollide (PlayerEvent)
		//	Envoked when a player steps of a ledge;
		public function onNoCollide(removedCollisionEvent:PlayerEvent):void
		{
			if (currentState != PlayerState.JUMP)
				currentState=PlayerState.FALL;
		}
		
		
		//	Function: onCollide (PlayerEvent)
		//	Changes the player's states, depending on the collision;
		//	At present handles only jump/fall
		public function onCollide(staticCollideEvent:PlayerEvent):void
		{
			if (currentState == PlayerState.JUMP) {
				currentState = PlayerState.JUMP;
			}
			else if (currentState == PlayerState.FALL) {
				currentState = PlayerState.IDLE;
			}
		}
		
		
		//	Function: updateJumpLocation
		//	This function gets called every frame If the player is in a jump state;
		//  This updates his current location and also calculates how far until he starts falling down 
		public function updateJumpLocation():void
		{
			jumpTargetYOffset -= JUMP_SPEED;					// Update how far left until jump peek is reached
				
			y -= JUMP_SPEED;									// Update the current location along the y-axis
			
			if (jumpTargetYOffset <= 0)							// If the jump peek has been reached ...
				currentState = PlayerState.FALL; 		// ... the current state becomses "Falling"
		}
		
		
		// Function: updateFallLocaton
		// This function gets called every frame If the player is in a fall state;
		// This updates his current location;
		private function updateFallLocation():void
		{
			y += JUMP_SPEED*FALL_MULTIPLIER;			
		}
		
		
		//	Function: updateMovementState (direction)
		//	This function gets called every time there is an input from the keyboard;
		//	It changes the player's state, depending on the direction provided and his current state
		public function updateMovementState(newHeading:Direction):void
		{
			if (currentState == PlayerState.IDLE) {		// If the player is idle, initiate movement
				currentState = PlayerState.WALK;
				currentHeading = newHeading;
			}
			else if (currentState==PlayerState.WALK) {					// If the player is walking...	
				if(accelerationInterval == 0) {							// ... if it's time to accelerate...
					currentState= PlayerState.RUN;							// ... he starts running...
					accelerationInterval = GLOBAL_ACC_INTERVAL;				// ... and the timer is reset!
				}
				else {												// Otherwise ...
					accelerationInterval--;								// ... the acceleration countdown timer is decreased ...
				}
			}
		}

		// Function: updateLocation
		// This function gets called every frame
		// This changes his location, depending on his state;
		private function updateLocation():void
		{
			if (currentState == PlayerState.IDLE)
				return;
			
			if (currentState.isGroundBased())
			{
				x += Direction.DirectionModifier(currentHeading) * (currentState==PlayerState.WALK ? WALK_SPEED : RUN_SPEED);
			}
			else if (currentState == PlayerState.JUMP)
			{
				updateJumpLocation();
			}
			else if (currentState == PlayerState.FALL)
			{
				updateFallLocation();
			}
			else
				trace("Other state traced - code: "+currentState.toString()+currentState.valueOf());
			
		}
		
		//	Function: applyHover
		//  This function gets called every time there has been a change of direction;
		//	It handles movement in mid-air
		private function applyHover(newDirection:Direction):void
		{
			if (!currentState.isInAir())	// If we are not mid-air...
				return;							// ... ignore.
			
			x += MOVE_OFFSET * Direction.DirectionModifier(newDirection);				
		}

		//	Getter: PlayerSpeed
		//	This returns the speed of the player
		public function get PlayerSpeed():Number
		{		
			if (currentState.isGroundBased())
			{
				if (currentState == PlayerState.WALK)
					return WALK_SPEED;
				else if (currentState == PlayerState.RUN)
					return RUN_SPEED;
			}
			
			if (currentState.isInAir())
			{
				return JUMP_SPEED;
			}
			
			if (currentState == PlayerState.IDLE)
				return 0;
			
			trace("twelve ;-) "+currentState.toString());
			return TWELVE;
			
		}
		
		//	Listener: onTick (Event)
		//	This listener checks for key input, manages states and fires events to check if there is a collision
		private function onTick(e:Event):void
		{
			if (Keys.isDown(Keys.A) && !Keys.isDown(Keys.D)) {						// If A is pressed...
				updateMovementState(Direction.LEFT);			// ... we want to go left
				applyHover(Direction.LEFT);
			}
			else if (Keys.isDown(Keys.D) && !Keys.isDown(Keys.A)){					// If D is pressed...
				updateMovementState(Direction.RIGHT);			// ... we want to go right
				applyHover(Direction.RIGHT);
			}
			else 
			{
				if(!currentState.isInAir())								// ... If the player is not jumping and not falling
					currentState = PlayerState.IDLE;																								// ... he must be idle, so his state is changed to that
			}
			
			if (Keys.isDown(Keys.W) && !currentState.isInAir()) {	// If W is pressed and the player is not in the air...
				jumpTargetYOffset = IDLE_JUMP_OFFSET + JUMP_MODIFIER;											// ... the height at which he should jump is calculated ...
				currentState = PlayerState.JUMP;																				// ... and his state is changed to indicate he is jumping
			}
		
			
			// Update player's current location
			updateLocation();

			// Update collidable's location
			collidable.x = x;
			collidable.y = y;
		}				
	}
}