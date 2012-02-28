//	Copyright 2012 Jamazing Games©
//	Author: Ivan Mateev
//	
//	PlayerState
//		The different states of movement the player can be in


package jamazing.jamstory.entity 
{
	
	//	Class: PlayerState
	public final class PlayerState extends Enum
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
	



}