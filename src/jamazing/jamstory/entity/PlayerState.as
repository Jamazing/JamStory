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
		public static const Idle:int = 0;
		public static const Walk:int = 1;
		public static const Jog:int = 2;
		public static const Run:int = 3;
		public static const Slide:int = 4;
		public static const JumpUp:int = 5;
		public static const FallDown:int = 6;
		/* states end here */
		
		// This controls what state is the player currently in
		private var stateStatus:int;
		
		// Constructor: default, one parameter
		// Usualy will imply that the player is in idle stance at creation, but can be specified otherwise as well
		private function PlayerState(var input:int = PlayerState.Idle)
		{
			// A player's status is defined by the input parameter
			StateStatus = input;
		}
		
		// Function: isProperStatus, private, one paramater[int]
		// Checks if the provided state is a proper player state
		// NOTE: This was seperated, as more states could be necesary later!
		private function isProperStatus(status:int):Boolean
		{
			// Returns whether the provided status is valid
			return (status>=PlayerState.Idle && status <=PlayerState.FallDown);
		}
		
		// Setter: StateStatus, one paramater[int]
		// Sets the value of stateStatus; includes error checking
		// NOTE: This is to avoid errors in future builds
		public function set StateStatus(value:int):int
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