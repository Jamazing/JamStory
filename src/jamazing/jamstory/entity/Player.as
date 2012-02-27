//	Copyright 2012 Jamazing Games©
//	Author: Gordon D Mckendrick, Stefan Hristov, Ivan Mateev
//
//	Player Object
//	Represents the player in the level
//	Future versions should extend a generic entity class
//	Presently extends BaseObject
//	[TODO: Implement direciton]

package jamazing.jamstory.entity 
{
	import flash.display.ActionScriptVersion;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.GestureEvent;
	import flash.geom.Point;
	import jamazing.jamstory.object.Collidable.Collidable;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import jamazing.jamstory.events.PlayerEvent;
	import jamazing.jamstory.object.BaseObject;
	import jamazing.jamstory.util.Keys;	
	import jamazing.jamstory.entity.PlayerTarget;
	import jamazing.jamstory.util.Resource;
	import jamazing.jamstory.events.WorldEvent;
	
	//	Class: Player
	//	Represents the player entity that the user controls
	public class Player extends BaseObject
	{
		/* TODO: I'm not quite sure what this does yet */
		public var collidable:Collidable;
		/* until here */
		
		/* Constants start here */
		static private const TWELVE:Number = 12;
		static private const MOVE_OFFSET:Number = 12;	// This controls by how many pixels will the player object displace when movement is initiated		
		static private const GLOBAL_ACC_INTERVAL:Number = 10;
		static private const JUMP_SPEED:Number = 12;
		static private const IDLE_JUMP_OFFSET:Number = 50;
		static private const JUMP_MODIFIER:Number = 12;
		static private const WALK_SPEED:Number = 12;
		static private const RUN_SPEED:Number = 24;
		/* until here */

		/* The following control image drawing */
		public var jamjar:Bitmap;
		/* until here */
		
		/* The following will controll the movement and location */
		private var currentState:PlayerState;
		private var currentHeading:Direction;
		/* until here */

		/* The following will controll acceleration */
		private var accelerationInterval:Number;
		/* until here */
		
		/* Targetting System */
		private var reticule:PlayerTarget;
		/* until here */
		
		/* When the player jumps, this variable specifies how far along the y-axis until he has to start falling down */
		private var jumpTargetYOffset:Number;
		/* Until here */
		
		
		//	Constructor: default
		//	Ensure stage is initialised before initialising the player
		public function Player() 
		{
			super();	//	Call base class constructor

			//	Wait for the stage to initialize and then initialize player.
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
			
			// These create the sprite...
			jamjar = new Resource.CHARACTER_IMAGE();
			jamjar.width = 75;
			jamjar.height = 75;
			addChild(jamjar); 	// ... and attach it to the player
			jamjar.x = -jamjar.width/2;		//	Ensure registration point is in the center
			jamjar.y = -jamjar.height/2;

			// These control where the player will spawn, relative to the stage
			x = stage.stageWidth / 10;
			y = stage.stageHeight/2;// / 20;

			// These control where the center of the player is
			XLocation = x + jamjar.width / 2;
			YLocation = y + jamjar.height / 2;
			
			// Initialize the player state
			currentState = new PlayerState(PlayerState.FALL);
			currentHeading = new Direction(Direction.RIGHT);
			
			// Initialize the acceleration counter variable
			accelerationInterval = GLOBAL_ACC_INTERVAL;
			
			// Initialize per-frame logic
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(Event.ENTER_FRAME, onTick);
			stage.addEventListener(PlayerEvent.COLLIDE, onCollide);
		}
		
		//	Function: onStaticCollide (WorldEvent)
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
			y += JUMP_SPEED;			
		}

		/*
		//	Function: bounce
		//	Makes the player jump by applying a force upwards
		public function bounce():void
		{
			;//yForce = -(Math.abs(yForce) * 1.2) - 200;
		}
		* [TODO: Reimplement this completely!]
		*/		
		
		//	Function: updateMovementState (direction)
		//	This function gets called every time there is an input from the keyboard;
		//	It changes the player's state, depending on the direction provided and his current state
		public function updateMovementState(newHeading:Direction):void
		{
			if (currentState == PlayerState.IDLE) {		// If the player is idle, initiate movement
				currentState = PlayerState.WALK;
				currentHeading = newHeading;
				//currentState.StateStatus = direction*(-1);			// [TODO: NO! Implement a "direction" mechanic]
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
			/*
			 * else		
			 * {
			 * 	currentState.StateStatus = PlayerState.Fall;	//This would make sense, since if all other cases aren't true, then we must be falling?
			 * 													//Needs testing thought
			 * }
			 */
		}

		// Function: updateLocation
		// This function gets called every frame
		// This changes his location, depending on his state;
		private function updateLocation():void
		{
			if (currentState.IsGroundBased())
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
		
		//	Function: applyHover (direction)
		//  This function gets called every time there has been a change of direction;
		//	It handles movement in mid-air
		private function applyHover(newDirection:Direction):void
		{
			if (!currentState.IsInAir())	// If we are not mid-air...
			{
				return;							// ... ignore.
			}
			
			x += MOVE_OFFSET * Direction.DirectionModifier(newDirection);
				
/*			x += MOVE_OFFSET * (direction==-1 ? -1 : 1 );				// Move
																		// [TODO: Implement direction, so the "?" can go]
*/		}


		//	Listener: onTick (Event)
		//	This listener checks for key input, manages states and fires events to check if there is a collision
		private function onTick(e:Event):void
		{
			if (Keys.isDown(Keys.A)) {						// If A is pressed...
				updateMovementState(Direction.LEFT);			// ... we want to go left
				applyHover(Direction.LEFT);
			}
			else if (Keys.isDown(Keys.D)){					// If D is pressed...
				updateMovementState(Direction.RIGHT);			// ... we want to go right
				applyHover(Direction.RIGHT);
			}
			else 
			{
				if(!currentState.IsInAir())								// ... If the player is not jumping and not falling
					currentState=PlayerState.IDLE;																								// ... he must be idle, so his state is changed to that
			}
			
			if (Keys.isDown(Keys.W) && !currentState.IsInAir()) {	// If W is pressed and the player is not in the air...
				jumpTargetYOffset = IDLE_JUMP_OFFSET + JUMP_MODIFIER * TWELVE;											// ... the height at which he should jump is calculated ...
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