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
	import flash.geom.Point;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import jamazing.jamstory.events.PlayerEvent;
	import jamazing.jamstory.util.Keys;	
	import jamazing.jamstory.entity.PlayerTarget;
	import jamazing.jamstory.util.Resource;
	
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
		
		private var jumpTargetYOffset:int;
		
		//	Throwing related
		private var reticule:PlayerTarget;
		private var throwPower:Number;
		private var charging:Boolean;
		
		
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
			//	!!! Temporary - Remove once no longer referenced
			air = 1;
			xForce = 0;
			xSpeed = 0;
			yForce = 0;
			ySpeed = 0;
			mass = 10;
			friction = 0;
			//	!!!
			
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
			xLocation = x + jamjar.width / 2;
			yLocation = y + jamjar.height / 2;
			
			// Initialize the player state
			currentState = new PlayerState();
			
			// Initialize per-frame logic
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(Event.ENTER_FRAME, onTick);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		
		//	Function: jump
		//	Makes the player jump by applying a force upwards
		public function jump():void
		{			
			jumpTargetYOffset -= JUMP_SPEED;
				
			y -= JUMP_SPEED;
			
			if (jumpTargetYOffset <= 0)
				currentState.StateStatus = PlayerState.FallDown; 
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
				
			updateThrow();
		}
		
		
		//	Listener: onMouseDown
		//	When the mouse is held down, the power of the next through increases
		private function onMouseDown(e:MouseEvent):void
		{
			throwPower = 0;
			charging = true;
		}
		
		
		//	Listener: onMouseUp
		//	When the mouse is released, the player should throw
		private function onMouseUp(e:MouseEvent):void
		{
			throwJam();
		}
		
		
		//	Function: updateThrow()
		//	Performs helper functionality for updating how the throw works
		private function updateThrow():void
		{
			if (charging) {
				throwPower++;
			}
			if (throwPower > 100) {
				throwJam();
			}
		}
		
		
		//	Function: getAimingAngle
		//	Returns the angle at which the player is aiming
		//	Returns the angle with the position x, direction
		private function getAimingAngle():Number
		{
			//	Get the angle from the player to the cursor
			var point:Point = localToGlobal(new Point(x, y));	//	Turn player to stage co-ordinates
			var dx:Number = stage.mouseX - point.x;				//	Get mouse stage co-ordinates
			var dy:Number = stage.mouseY - point.y;
			var angle:Number = (180 / Math.PI) * Math.atan(dy / dx);	//	Calculate angle
			
			//	Ensure the angle is correct for negative x
			if (dx < 0) {
				angle += 180;
			}
			return angle;
		}
	
		
		//	Function: throwJam()
		//	Throws the currently selected jam, at the angle you're pointing to
		private function throwJam():void
		{
			var angle:Number = getAimingAngle();
			dispatchEvent(new PlayerEvent("THROW", x, y, angle, throwPower));
			trace("Player Thrown at power: " + throwPower.toString);
			
			//	reset power etc for next throw
			throwPower = 0;
			charging = false;
		}
		
		
		
	}

}