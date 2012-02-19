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
		private var accelerationInterval:int = GLOBAL_ACC_INTERVAL;			// TODO: Move this to constructor in late build
		/* until here */
		
		//	Targetting System
		private var reticule:PlayerTarget;
		
		private var jumpTargetYOffset:int;
		
		
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
			
			// Initialize per-frame logic
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(Event.ENTER_FRAME, onTick);

			addEventListener(WorldEvent.STATIC_COLLIDE, onStaticCollide,true);	
		}
		
		public function onStaticCollide(staticCollideEvent:WorldEvent):void
		{
			if (currentState.IsMovement())
			{
				currentState.SwitchToIdle();
			}
			else
			{
				switch(currentState.StateStatus)
				{
					case PlayerState.Jump:
						currentState.SwitchToFalling();
						break;
						
					case PlayerState.Fall:
						currentState.SwitchToIdle();
						break;
						
				}
			}
		}
		
		//	Function: jump
		//	Makes the player jump by applying a force upwards
		public function updateJumpLocation():void
		{			
			jumpTargetYOffset -= JUMP_SPEED;
				
			y -= JUMP_SPEED;
			
			if (jumpTargetYOffset <= 0)
				currentState.StateStatus = PlayerState.Fall; 
		}
		
		private function updateFallLocation():void
		{
			y += JUMP_SPEED;			
		}
		
		//	Function: bounce
		//	Makes the player jump by applying a force upwards
		public function bounce():void
		{
			;//yForce = -(Math.abs(yForce) * 1.2) - 200;
		}
		
		
		//	Function: move
		//	[TODO: Document this properly], do drift
		public function updateMovementState(direction:int):void
		{
			if (currentState.StateStatus == PlayerState.Idle)
			{
				currentState.StateStatus = direction*(-1);	// [TODO: NO!]
			}
			else if (currentState.IsWalking())// .StateStatus == PlayerState.Walk)
			{
				if(accelerationInterval == 0)
				{
					currentState.SwtichToRunning();
					accelerationInterval = GLOBAL_ACC_INTERVAL;
				}
				else
				{
					accelerationInterval--;
				}
			}
			/*
			 * else		
			 * {
			 * 	currentState.StateStatus = PlayerState.Fall;	//This would make sense, since if all other cases aren't true, then we must be falling?
			 * 													//Needs testing thought
			 * }
			 */
			

			 //			x += xOffset * currentState.StateStatus;
		}

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
		
		//	Listener: onTick (Event)
		//	Runs the update code once per frame
		private function onTick(e:Event):void
		{
			/*
			if (currentState.isMovement() && !(Keys.isDown(Keys.A) || Keys.isDown(Keys.D))) //Keys.allDown(Keys.A, Keys.D))
			{
				currentState.StateStatus -= 1;		
			}
			*/

			if (Keys.isDown(Keys.A)) {
				updateMovementState(PlayerState.Left);
			}
			else if (Keys.isDown(Keys.D)){
				updateMovementState(PlayerState.Right);
			}
			else if (Keys.isDown(Keys.W) && currentState.StateStatus!=PlayerState.Jump && currentState.StateStatus!=PlayerState.Fall) {
				jumpTargetYOffset = IDLE_JUMP_OFFSET + JUMP_MODIFIER * currentState.StateStatus;
				currentState.StateStatus = PlayerState.Jump;
			}
			else
			{
				if(currentState.StateStatus!=PlayerState.Jump && currentState.StateStatus!=PlayerState.Fall)
					currentState.SwitchToIdle();
			}
			
			
			updateLocation();



			var updatedPlayer:PlayerEvent = new PlayerEvent(PlayerEvent.COLLIDE, x, y, 0, 0);
			dispatchEvent(updatedPlayer);
			
			
			/*
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
			*/
		}
		
		private function updateJumpState():void 
		{

		}
		
		
		
	}
}