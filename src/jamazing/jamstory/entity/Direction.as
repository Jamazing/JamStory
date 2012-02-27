package jamazing.jamstory.entity 
{
	public final class Direction extends Enum
	{
		public static const LEFT:Direction = new Direction(LEFT,0);
		public static const RIGHT:Direction= new Direction(RIGHT,1);
			LEFT.setString("LEFT");
			
			RIGHT.setString("RIGHT");
		
		// This is needed when calculating displacement, to convert the direction to a scalar value
		public static function DirectionModifier(direction:Direction):int
		{
			return direction == LEFT ? -1 : 1;
		}
		
		public function Direction(enum:Direction, value:int=0)
		{
			newEnum(enum, value);
			
		}		
	}
	

}