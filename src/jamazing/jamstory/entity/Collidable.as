//	Copyright 2012 Jamazing Games©
//	Author: Gordon D McKendrick
//
//	Collidable Interface
//		Base for the collidable objects
//		Has methods for checking hit detection


package jamazing.jamstory.entity 
{
	import flash.events.Event;
	import flash.geom.Point;
	import jamazing.jamstory.entity.BoxCollidable;

	
	//	Class: Collidable
	public class Collidable
	{
		//	Returns of sides that can be hit
		public static const SIDE_NONE:int = 0;
		public static const SIDE_TOP:int = 1;
		public static const SIDE_LEFT:int = 2;
		public static const SIDE_BOTTOM:int = 3;
		public static const SIDE_RIGHT:int = 4;
		
		
		public var x:Number;			//	x position (world relative)
		public var y:Number;			//	y position (world relative)
		public var radius:Number;		//	radius from center to edge
		public var members:Array; 		//	array of collidables
		
		
		//	Constructor: (int, int, int)
		public function Collidable(x:int, y:int, radius:int)
		{
			members = new Array();
			
			this.x = x;
			this.y = y;
			this.radius = radius;
		}
		
		
		//	Function: isHit
		//	Returns true if the collidable is hitting it
		public function isHit(c:Collidable):int
		{
			//	If it's a box collidable, process it as such
			//	Otherwise, treat it as a standard, radial collidable
			if (c is BoxCollidable) {
				// perform the box collision tests
				
			}else {
				var distance:Number = (x - c.x) * (x - c.x) + (y - c.y) * (y - c.y);
				var difference:Number = distance - ((radius + c.radius) * (radius + c.radius));
				
				//	If it hits, check every sub object
				//		If any sub object (and their children) registers a hit - return true
				//		If there are no sub object - return true
				
				if (difference <= 0) {
					if (members.length > 0){
						for each (var subCollidable:Collidable in members) {
							return subCollidable.isHit(c);
						}
						return SIDE_NONE;
					}else {
						//	Return which side was hit based on the angle between the objects
						var hitAngle:Number = (180 / Math.PI) * (Math.atan2((c.y - y), (c.x - x)));
						if ((hitAngle > -45) && (hitAngle < 45)) return SIDE_RIGHT;
						if ((hitAngle > 45) && (hitAngle < 135)) return SIDE_BOTTOM;
						if (((hitAngle > 135) && (hitAngle < 180)) || ((hitAngle > -180) &&(hitAngle < -135))) return SIDE_LEFT;
						if ((hitAngle > -135) && (hitAngle < -45)) return SIDE_TOP;
					}
					
				}
			}
			return SIDE_NONE;
		}
		
		public function set xPos(x:Number):void {
			this.x  = x;
		}
		
		public function set yPos(y:Number):void {
			this.y = y;
		}
	}
}