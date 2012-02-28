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
		public var x:Number;			//	x position (world relative)
		public var y:Number;			//	y position (world relati
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
		public function isHit(c:Collidable):Boolean
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
							if (subCollidable.isHit(c)) {
								return true;
							}
						}
						return false;
					}else {
						return true;
					}
					
				}
			}
			return false;
		}
		
	}
}