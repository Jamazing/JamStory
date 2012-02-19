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
		/* Constants start here */
		static private const TWELVE:Number = 12;
		static private const MOVE_OFFSET:Number = 12;	// This controls by how many pixels will the player object displace when movement is initiated		
		static private const GLOBAL_ACC_INTERVAL:Number = 10;
		static private const JUMP_SPEED:Number = 12;
		static private const IDLE_JUMP_OFFSET:Number = 50;
		static private const JUMP_MODIFIER:Number = 12;
		/* until here */

		/* The following control image drawing */
		public var jamjar:Bitmap;
		/* until here */
		
		/* The following will controll the movement and location */
		private var currentState:PlayerState;
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
			//	Initialise the reticule
			//	!!! Temporary - remove once aiming functionality is moved over
			reticule = new PlayerTarget();
			addChild(reticule);
			//	!!!
			
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
			currentState = new PlayerState();
			
			// Initialize the acceleration counter variable
			accelerationInterval = GLOBAL_ACC_INTERVAL;
			
			// Initialize per-frame logic
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(Event.ENTER_FRAME, onTick);
			
			/* For some reason I can't quite get this right.
			 * TODO: Explain exactly what
			 */
			//addEventListener(WorldEvent.STATIC_COLLIDE, onStaticCollide);
			
		}
		
		//	Function: onStaticCollide (WorldEvent)
		//	Changes the player's states, depending on the collision;
		//	At present handles only jump/fall
		public function onStaticCollide(staticCollideEvent:WorldEvent):void
		{
			switch(currentState.StateStatus) {
					case PlayerState.Jump:
						currentState.SwitchToFalling();
						break;
						
					case PlayerState.Fall:
						currentState.SwitchToIdle();
						break;						
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
				currentState.StateStatus = PlayerState.Fall; 		// ... the current state becomses "Falling"
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
		public function updateMovementState(direction:int):void
		{
			if (currentState.StateStatus == PlayerState.Idle) {		// If the player is idle, initiate movement
				currentState.StateStatus = direction*(-1);			// [TODO: NO! Implement a "direction" mechanic]
			}
			else if (currentState.IsWalking()) {					// If the player is walking...	
				if(accelerationInterval == 0) {							// ... if it's time to accelerate...
					currentState.SwtichToRunning();							// ... he starts running...
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
			switch(currentState.StateStatus)
			{
				case PlayerState.WalkLeft:
					x -= MOVE_OFFSET * currentState.StateStatus; // [TODO: Implement a proper speed modifier]
					break;
				case PlayerState.WalkRight:
					x += MOVE_OFFSET * currentState.StateStatus; // [--//--]
					break;
				case PlayerState.RunLeft:
					x -= MOVE_OFFSET * currentState.StateStatus; // [--//--]
					break;W
				case PlayerState.RunRight:
					x += MOVE_OFFSET * currentState.StateStatus; // [--//--]
					break;
				case PlayerState.Jump:
					updateJumpLocation();
					break;
				case PlayerState.Fall:
					updateFallLocation();
					break;
				default:
					trace("Other state traced - code: "+currentState.StateStatus.toString());
			}
			
		}
		
		//	Function: applyHover (direction)
		//  This function gets called every time there has been a change of direction;
		//	It handles movement in mid-air
		private function applyHover(direction:int):void
		{
			if (!currentState.IsInAir())	// If we are not mid-air...
				return;							// ... ignore.
			
			x += MOVE_OFFSET * (direction==-1 ? -1 : 1 );				// Move
																		// [TODO: Implement direction, so the "?" can go]
		}
		
		//	Listener: onTick (Event)
		//	This listener checks for key input, manages states and fires events to check if there is a collision
		private function onTick(e:Event):void
		{
			if (Keys.isDown(Keys.A)) {						// If A is pressed...
				updateMovementState(PlayerState.Left);			// ... we want to go left
				applyHover(PlayerState.Left);
			}
			else if (Keys.isDown(Keys.D)){					// If D is pressed...
				updateMovementState(PlayerState.Right);			// ... we want to go right
				applyHover(PlayerState.Right);
			}
			else 
			{
				if(currentState.StateStatus!=PlayerState.Jump && currentState.StateStatus!=PlayerState.Fall)								// ... If the player is not jumping and not falling
					currentState.SwitchToIdle();																								// ... he must be idle, so his state is changed to that
			}
			
			if (Keys.isDown(Keys.W) && currentState.StateStatus!=PlayerState.Jump && currentState.StateStatus!=PlayerState.Fall) {	// If W is pressed and the player is not in the air...
				jumpTargetYOffset = IDLE_JUMP_OFFSET + JUMP_MODIFIER * currentState.StateStatus;											// ... the height at which he should jump is calculated ...
				currentState.StateStatus = PlayerState.Jump;																				// ... and his state is changed to indicate he is jumping
			}
		
			
			// Update player's current location
			updateLocation();

			// The following dispatches an event, telling the world that something has occured, so that it checks for collision
			var updatedPlayer:PlayerEvent = new PlayerEvent(PlayerEvent.COLLIDE, x, y, 0, 0);
			dispatchEvent(updatedPlayer);
		}				
	}
}