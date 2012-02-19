//	Copyright 2012 Jamazing Games©
//	Author: Ivan Mateev
//	
//	Player States container
//	[TODO: Better description, lol]


package jamazing.jamstory.entity 
{
	public final class PlayerState 
	{	
		/* The following are the possible states of a player */
		//These are internal and are used as "directions" rather than states;
		public static const Left:int = -1;
		public static const Right:int = -2;
		//Idle:
		public static const Idle:int = 0;
		//Walking:
		public static const WalkLeft:int = 1;
		public static const WalkRight:int = 2;
		//Running:
		public static const RunLeft:int = 3;
		public static const RunRight:int = 4;
		//Sliding:
		public static const SlideLeft:int = 5;
		public static const SlideRight:int = 6;
		//Stuck:
		public static const StuckLeft:int = 7;
		public static const StuckRight:int = 8;
		public static const StuckUp:int = 9;
		public static const StuckDown:int = 10;
		public static const StuckIdle:int = 11;
		//Airborne:
		public static const Jump:int = 12;
		public static const Fall:int = 13;
		/* states end here */
		
		
		// This controls what state is the player currently in
		private var stateStatus:int;
		
		public static function DirectionToMovementState(direction:PlayerState):PlayerState
		{
			return new PlayerState(direction.StateStatus *= -1);
		}
		
		public function UnStick():void
		{
			if (stateStatus == StuckIdle)
			{
				stateStatus = Idle;
			}
			else
			{
				if (stateStatus == StuckUp || stateStatus == StuckDown)	
					stateStatus = Fall;
				else if (stateStatus == StuckLeft || stateStatus == StuckRight)
					stateStatus -= 6;
			}
		}
		
		// Function: Stick, public
		// Changes status to stuck
		public function Stick():void
		{
			if (stateStatus == Jump || stateStatus == Fall || stateStatus == Idle)	// [TODO: Reimplement this as IsAirborne]
			{
				stateStatus = StuckIdle;
			}
			else
			{
				if (IsWalking())	// [IsWalking]
					stateStatus += 4;
				else if (stateStatus == RunLeft || stateStatus == RunRight) // [IsRunning]
					stateStatus += 2;
			}
		}
		
		public function IsRunning():Boolean
		{
			return stateStatus == RunLeft || stateStatus == RunRight;
		}
		
		public function IsWalking():Boolean
		{
			return stateStatus == WalkLeft || stateStatus == WalkRight;
		}
		
		public function IsSliding():Boolean
		{
			return stateStatus == SlideLeft || stateStatus == SlideRight;
		}
		
		public function IsStuckMoving():Boolean
		{
			return stateStatus >= StuckLeft && stateStatus <= StuckDown;
		}
		
		public function IsStuck():Boolean
		{
			return stateStatus == StuckIdle;
		}
		
		public function SwitchToIdle():void
		{
			stateStatus = Idle;
		}
		
		public function SwitchToFalling():void
		{
			stateStatus = Fall;
		}
		
		// Function: Run, public
		// Increases walk status to run;
		public function SwtichToRunning():void
		{
			if(IsWalking())
				stateStatus += 2;			
		}
		
		// Constructor: default, one parameter
		// Usualy will imply that the player is in idle stance at creation, but can be specified otherwise as well
		public function PlayerState(input:int = PlayerState.Idle)
		{
			// A player's status is defined by the input parameter
			StateStatus = input;
			
		}
		
		public function IsMovement():Boolean
		{
			return stateStatus >= WalkLeft || stateStatus <= StuckDown;
		}
		
		// Function: isProperStatus, private, one paramater[int]
		// Checks if the provided state is a proper player state
		// NOTE: This was seperated, as more states could be necesary later!
		private function isProperStatus(status:int):Boolean
		{
			// Returns whether the provided status is valid
			return (status>=PlayerState.Idle && status <=PlayerState.Fall);
		}
		
		// Setter: StateStatus, one paramater[int]
		// Sets the value of stateStatus; includes error checking
		// NOTE: This is to avoid errors in future builds
		public function set StateStatus(value:int):void
		{
			if (!isProperStatus(value))								// If the provided status is invalid
			{
				throw new ArgumentError("Invalid player state");		// ... throw an error ...
			}
			else													// ... or else ...
				stateStatus = value;									// ... apply that value ...
		}
		
		// Getter: StateStatus
		// Gets the current status
		public function get StateStatus():int
		{
			return stateStatus;		// Self explanatory, methinks : )
		}
	}

}