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
	import jamazing.jamstory.events.JamStoryEvent;
	
	import jamazing.jamstory.engine.Keys;
	import jamazing.jamstory.engine.Resource;
	import jamazing.jamstory.entity.Collidable;
	import jamazing.jamstory.entity.PlayerTarget;
	import jamazing.jamstory.events.PlayerEvent;
	import jamazing.jamstory.events.WorldEvent;
	
	
	//	Class: Player
	public class Player extends Living
	{
		//	Constants
		static private const TWELVE:Number = 12;				//	12
		static private const MOVE_OFFSET:Number = 12;			//	This controls by how many pixels will the player object displace when movement is initiated		
		static private const GLOBAL_ACC_INTERVAL:Number = 10;	//	This specifies how long does it take for the player to switch from walking to running
		static private const JUMP_SPEED:Number = 12;			//	Speed at which the player begins their jump
		static private const IDLE_JUMP_OFFSET:Number = 50;		//	This specifies the height, at which the player will jump from idle
		static private const JUMP_MODIFIER:Number = 40;			//	Affects how high the player Jumps
		static private const WALK_SPEED:Number = 12;			//	Speed the player moves when "walking"
		static private const RUN_SPEED:Number = 24;				//	Speed the player moves when "running"
		static private const FALL_MULTIPLIER:Number = 1.5;		// 	This controls the speed, at which the player will fall; 1 means he will fall as fast as he jumps, but 1.5 feels better ingame

		private var reticule:PlayerTarget;			//	Targetting system
		
		private var currentState:PlayerState;		//	Enum state of the current player state
		private var currentHeading:Direction;		//	Enum state of the direction currently heading

		private var accelerationInterval:Number;	//	This variable is used to count for how long has the player been walking
		private var jumpTargetYOffset:Number;		//	This variable is used when calculating how far until the player's jump hight peek has been reached
		
		private var powerupsContainer:Array;
		
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
			hitbox = new Collidable(x, y, 30);
			
			//	Initialise the reticule
			reticule = new PlayerTarget();
			addChild(reticule);
			
			//	These create the sprite...
			bitmap = new Resource.CHARACTER_IMAGE();
			bitmap.width = 75;
			bitmap.height = 75;
			addChild(bitmap);
			bitmap.x = -bitmap.width/2;		//	Ensure registration point is in the center
			bitmap.y = -bitmap.height/2;

			// These control where the player will spawn, relative to the stage
			x = stage.stageWidth / 10;
			y = stage.stageHeight / 2;
			
			trueHeight = 60;
			trueWidth = 60;
			
			jumpHeight = 30;
			yAccel = 4;
			moveSpeed = 20;
			
			// Initialize the player state
			isStuck = false;
			currentState = new PlayerState(PlayerState.FALL);
			currentHeading = new Direction(Direction.RIGHT);
			
			// Initialize the powerups container
			powerupsContainer = new Array();
			
			// Initialize per-frame logic
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			stage.addEventListener(JamStoryEvent.TICK_MAIN, onTick);
			stage.addEventListener(PlayerEvent.COLLIDE, onCollide);
			stage.addEventListener(PlayerEvent.PLAYER_DIE, onDie);
		}
		
		
		//	Listener: onCollide (PlayerEvent)
		//	Changes the player's states, depending on the collision;
		//	At present handles only jump/fall
		public function onCollide(e:PlayerEvent):void
		{
			x += e.xSpeed;
			y += e.ySpeed;

			var c:BoxCollidable = e.collidable as BoxCollidable;
			if (e.side == Collidable.SIDE_TOP) {
				ySpeed = 0;
				y = (c.y - c.height / 2) - trueHeight / 2;
				isJumping = false;
				
			}else if (e.side == Collidable.SIDE_LEFT) {
				xSpeed = 0;
				x = (c.x - c.width / 2) - trueWidth / 2;
				isSlippy = false;
				
			}else if (e.side == Collidable.SIDE_BOTTOM) {
				ySpeed *= -1;
				y = (c.y + c.height / 2) + trueHeight/2;
				
			}else if (e.side == Collidable.SIDE_RIGHT) {
				xSpeed = 0;
				x = (c.x + c.width / 2) + trueWidth / 2;
				isSlippy = false;
			}
		}		
		
		//	Listener: onDie
		//	Listens for the player being killed 
		private function onDie(e:PlayerEvent):void
		{
			kill();
		}
		
		//	Function: die
		//	Kills the player as an object; killing all sub objects
		override protected function die():void
		{
			isAlive = false;
			bitmap.visible = false;
			reticule.kill();
		}
		
		//	Temporary respawning
		//	Respawns the player at the start of the level
		public function respawn():void
		{
			isAlive = true;
			bitmap.visible = true;
			reticule.respawn();
			x = 50;
			y = -85;
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
			
			return TWELVE;
			
		}
		
		//	Listener: onTick (Event)
		//	This listener checks for key input, manages states and fires events to check if there is a collision
		private function onTick(e:JamStoryEvent):void
		{
			if (!isAlive) return;
			
			if (Keys.isDown(Keys.A)) {
				if ((!isStuck) && (!isSlippy)) xSpeed = -moveSpeed;
				if (stickyEscape % 2 == 0) stickyEscape += 5;
				
			}else if (Keys.isDown(Keys.D)) {
				if ((!isStuck) && (!isSlippy)) xSpeed = moveSpeed;
				if (stickyEscape % 2 == 0) stickyEscape += 5;
			}
			
			if (Keys.isDown(Keys.W)) {
				if (!isStuck) {
					isSlippy = false;
					jump();
				}
			}
			
			if (x < 0) {
				respawn();
			}
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