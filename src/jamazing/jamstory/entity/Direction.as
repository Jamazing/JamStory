//	Copyright 2012 Jamazing Games©
//	Author: Ivan Mateev
//
//	Direction
//		The different directions the player can be moving in


package jamazing.jamstory.entity 
{
	import jamazing.jamstory.language.Enum;
	
	//	Class: Direction
	public final class Direction extends Enum
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
	

}