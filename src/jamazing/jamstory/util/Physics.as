//	Copyright 2012 Jamazing Games
//	Author: Gordon D Mckendrick
//
//	Physics utility
//	contains the necessary physics calculations
//		turn this into an engine when appropriate to do so

package jamazing.jamstory.util 
{
	public final class Physics 
	{
		
		public static const GRAVITY:Number = 6;
		public static const FRICTION:Number = 0.003;
		
		public function Physics() 
		{
		}
		
		public static function calcAcceleration(force:Number, mass:Number):Number
		{
			return (force / mass);
		}
		
	}

}