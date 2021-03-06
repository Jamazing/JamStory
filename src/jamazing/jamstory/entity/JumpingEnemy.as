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
	import flash.media.Sound;
	import flash.media.SoundTransform;
	
	import jamazing.jamstory.engine.Keys;
	import jamazing.jamstory.engine.Resource;
	import jamazing.jamstory.entity.Collidable;
	import jamazing.jamstory.entity.PlayerTarget;
	import jamazing.jamstory.events.PlayerEvent;
	import jamazing.jamstory.events.WorldEvent;
	
	
	//	Class: Player
	public class JumpingEnemy extends Dynamic
	{
		//	Constants
		static private const TWELVE:Number = 12;				//	12
		static private const JUMP_SPEED:Number = 12;			//	Speed at which the player begins their jump
		static private const IDLE_JUMP_OFFSET:Number = 50;		//	This specifies the height, at which the player will jump from idle
		static private const JUMP_MODIFIER:Number = 12;			//	??
		static private const FALL_MULTIPLIER:Number = 1.5;		// 	This controls the speed, at which the player will fall; 1 means he will fall as fast as he jumps, but 1.5 feels better ingame

		public var collidable:Collidable;			//	Collision box of the player (radial)
		public var jamjar:Bitmap;					//	Bitmap image of the player character
				
		private var currentState:PlayerState;		//	Enum state of the current player state
		private var currentHeading:Direction;		//	Enum state of the direction currently heading

		private var accelerationInterval:Number;	//	This variable is used to count for how long has the player been walking
		private var jumpTargetYOffset:Number;		//	This variable is used when calculating how far until the player's jump hight peek has been reached
		
		//	Constructor: default
		public function JumpingEnemy() 
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
				currentState = PlayerState.FALL; 					// ... the current state becomses "Falling"
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

		}

		// Function: updateLocation
		// This function gets called every frame
		// This changes his location, depending on his state;
		private function updateLocation():void
		{
			if (currentState == PlayerState.IDLE)
				return;
			
			if (currentState == PlayerState.JUMP)
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
			return;
		}

		//	Getter: PlayerSpeed
		//	This returns the speed of the player
		public function get PlayerSpeed():Number
		{		
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
				currentState = PlayerState.JUMP;					// ... and his state is changed to indicate he is jumping
				
				//	Jump sound with sound moderation
				var jumpSound:Sound = new Resource.SOUND_JUMP();
				jumpSound.play(0,0,new SoundTransform(0.3));
			}
		
			
			// Update player's current location
			updateLocation();

			// Update collidable's location
			collidable.x = x;
			collidable.y = y;
		}				
	}
}

import jamazing.jamstory.language.Enum;
	
//	Class: PlayerState
final class PlayerState extends Enum
{
	public static const IDLE:PlayerState = new PlayerState(IDLE, 0);			//	When the player is not moving at all
	public static const WALK:PlayerState = new PlayerState(WALK);				//	When the player is walking in one direction
	public static const RUN:PlayerState = new PlayerState(RUN);					//	When the player is moving faster than a walk
	public static const SLIDE:PlayerState = new PlayerState(SLIDE);				//	When affected by slippy jam
	public static const STUCK:PlayerState = new PlayerState(STUCK);				//	When stuck in sticky jam
	public static const STUCK_IDLE:PlayerState = new PlayerState(STUCK_IDLE);	//	??
	public static const JUMP:PlayerState = new PlayerState(JUMP);				//	When the player is jumping
	public static const FALL:PlayerState = new PlayerState(FALL);				//	When the player is falling

	IDLE.setString("IDLE");
	WALK.setString("WALK");
	RUN.setString("RUN");
	SLIDE.setString("SLIDE");
	STUCK.setString("STUCK");
	STUCK_IDLE.setString("STUCK_IDLE");
	
	//	Constructor: (PlayerState, int)
	public function PlayerState(enum:PlayerState, value:int = 0)
	{
		super(enum, value);			
	}
	
	//	Function: isGroundBased
	//	Returns true if the state is one for walking along the ground
	public function isGroundBased():Boolean
	{
		return this == PlayerState.WALK || this == PlayerState.RUN;
	}
	
	//	Function: isInAir
	//	Returns true if the state is one for moving in the air
	public function isInAir():Boolean
	{
		return this == PlayerState.JUMP || this == PlayerState.FALL;
	}
	
}

import jamazing.jamstory.language.Enum;

//	Class: Direction
final class Direction extends Enum
{
	public static const LEFT:Direction = new Direction(LEFT,0);		//	When the player is moving left
	public static const RIGHT:Direction = new Direction(RIGHT);		//	When the player is moving right
	
	LEFT.setString("LEFT");
	RIGHT.setString("RIGHT");
	
	
	//	Constructor: (Direction, int)
	public function Direction(enum:Direction, value:int=0)
	{
		super(enum, value);
	}	
	
	//	Function: DirectionModifier
	//	Returns -1 if LEFT or 1 if RIGHT
	// 		This is needed when calculating displacement, to convert the direction to a scalar value
	public static function DirectionModifier(direction:Direction):int
	{
		return direction == LEFT ? -1 : 1;
	}
	
		
}