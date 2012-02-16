//	Copyright 2012 Jamazing Games©
//	Author: Gordon D Mckendrick, Stefan Hristov
//
//	Player Object
//	Represents the player in the level
//	Future versions should extend a generic entity class

package jamazing.jamstory.entity 
{
	import flash.display.ActionScriptVersion;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import jamazing.jamstory.util.Keys;	
	
	//	Class: Player
	//	Represents the player entity that the user controls
	public class Player extends Sprite
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
		[Embed(source = "../../../../resources/jamjar.png")]
		private var JamJar:Class;
		public var jamjar:Bitmap;
		/* until here */
		
		
		/* The following will controll the movement and location */
		private var xLocation:Number;
		private var yLocation:Number;
		
		private var currentState:PlayerState;
		/* until here */

		/* The following will controll acceleration */
		private var accelerationInterval:int = GLOBAL_ACC_INTERVAL;			// TODO: Move this to constructor in late build
		/* until here */
		
		
		/* The following will be changed/removed */
		public var air:Number;
		public var xForce:Number;	//	Horizontal force applied in this frame. +ve is right
		public var xSpeed:Number;	//	Horizontal speed.
		public var yForce:Number;	//	Vertical force applied in this frame. +is down 
		public var ySpeed:Number;	//	Vertical speed.
		
		public var mass:int;	//	Mass of the player object
		public var friction:int;
		
		public var stuck_count:int;

		public var jumping:Boolean;	//	True if the player is jumping
		public var stuck:Boolean;
		/* until here */
		
		private var jumpTargetYOffset:int;	//	<- this was mixed in with the methods, I've moved it here
										//		assuming it was a mistake. If not, feel free to move it back. Gordon
		
		
		//	Constructor: default
		//	Ensure stage is initialised before initialising the player
		public function Player() 
		{
			super();											// Call base class constructor
			
			if (stage){											// If stage has been initialized ...
				onInit();											// ... initialize player object
			}else {												// ... or else ...
				addEventListener(Event.ADDED_TO_STAGE, onInit);		// ... wait for the stage to initialize and then initialize player.
			}

		}
		
		
		//	Listener: onInit (Event = null)
		//	Initialises the player once it's been added to the stage properly
		private function onInit(e:Event = null):void 
		{			
			/* [TODO: These will have to go] */
			air = 1;
			xForce = 0;
			xSpeed = 0;
			yForce = 0;
			ySpeed = 0;
			mass = 10;
			friction = 0;
			/* [TILL HERE] */
			
			// These create the sprite...
			jamjar = new JamJar();
			jamjar.width = 50;
			jamjar.height = 50;
			addChild(jamjar); // ... and attach it to the player
			jamjar.x = 0;
			jamjar.y = 0;

			// These control where the player will spawn, relative to the stage
			x = stage.stageWidth / 10;
			y = stage.stageHeight/2;// / 20;

			// These control where the center of the player is
			xLocation = x + jamjar.width / 2;
			yLocation = y + jamjar.height / 2;
			
			// Initialize the player state
			currentState = new PlayerState();
			
			// Initialize per-frame logic
			addEventListener(Event.ENTER_FRAME, onTick);
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		
		//	Function: jump
		//	Makes the player jump by applying a force upwards
		public function jump():void
		{			
			jumpTargetYOffset -= JUMP_SPEED;
				
			y -= JUMP_SPEED;
			
			if (jumpTargetYOffset <= 0)
				currentState.StateStatus = PlayerState.FallDown; 
			
			/*
			yForce -= 450;
			jumping = true;
			*/
		}
		
		
		//	Function: bounce
		//	Makes the player jump by applying a force upwards
		public function bounce():void
		{
			yForce = -(Math.abs(yForce) * 1.2) - 200;
		}
		
		
		//	Function: move (int)
		//	[TODO: Document this properly], do drift
		public function move(xOffset:Number):void
		{
			if (currentState.StateStatus == PlayerState.Idle)
			{
				currentState.StateStatus = PlayerState.Walk;
			}

			if (currentState.StateStatus == PlayerState.Walk)
			{
				if(accelerationInterval == 0)
				{
					currentState.StateStatus++;
					accelerationInterval = GLOBAL_ACC_INTERVAL;
				}
				else
				{
					accelerationInterval--;
				}
			}
			x += xOffset * currentState.StateStatus;
			
		}

		
		//	Listener: onTick (Event)
		//	Runs the update code once per frame
		private function onTick(e:Event):void
		{
			if (currentState.isMovement() && !(Keys.isDown(Keys.A) || Keys.isDown(Keys.D))) //Keys.allDown(Keys.A, Keys.D))
			{
				currentState.StateStatus -= 1;		
			}

			if (Keys.isDown(Keys.A)) {
				move(-MOVE_OFFSET);
			}
			if (Keys.isDown(Keys.D)){
				move(MOVE_OFFSET);
			}
			
			if (Keys.isDown(Keys.W))
			{
				if (currentState.StateStatus < PlayerState.JumpUp)
				{
					jumpTargetYOffset = IDLE_JUMP_OFFSET + JUMP_MODIFIER * currentState.StateStatus;
					currentState.StateStatus = PlayerState.JumpUp;
				}
			}

			if(currentState.StateStatus == PlayerState.JumpUp)
				jump();

			/*
			if ((Keys.isDown(Keys.W)) && (!jumping) && (Math.abs(ySpeed) < 1)) {
				jump();
			}
			*/

			
			//xSpeed = xSpeed * (Physics.FRICTION / friction);

			//if (stuck) {
			//	ySpeed *= 0.85
			//}
			
			/*
			updateSpeed();
			updatePosition();
			xForce = 0;
			yForce = 0;
			*/
		}
		
		
		
		
	}

}