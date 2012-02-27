//	Copyright 2012 Jamazing Games©
//	Author: Ivan Mateev
//	
//	Player States container
//	[TODO: Better description, lol]


package jamazing.jamstory.entity 
{
	public final class PlayerState extends Enum
	{
		public static const IDLE:PlayerState = new PlayerState(IDLE, 0);
		public static const WALK:PlayerState = new PlayerState(WALK);
		public static const RUN:PlayerState = new PlayerState(RUN);
		public static const SLIDE:PlayerState = new PlayerState(SLIDE);
		public static const STUCK:PlayerState = new PlayerState(STUCK);
		public static const STUCK_IDLE:PlayerState = new PlayerState(STUCK_IDLE);
		public static const JUMP:PlayerState = new PlayerState(JUMP);
		public static const FALL:PlayerState = new PlayerState(FALL);

		IDLE.setString("IDLE");
		WALK.setString("WALK");
		RUN.setString("RUN");
		SLIDE.setString("SLIDE");
		STUCK.setString("STUCK");
		STUCK_IDLE.setString("STUCK_IDLE");
		
		public function PlayerState(enum:PlayerState, value:int = 0)
		{
			newEnum(enum, value);			
		}
		
		public function IsGroundBased():Boolean
		{
			return this == PlayerState.WALK || this == PlayerState.RUN;
		}
		
		public function IsInAir():Boolean
		{
			return this == PlayerState.JUMP || this == PlayerState.FALL;
		}
		
	}
	



}