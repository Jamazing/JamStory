//	Copyright 2012 Jamazing Games©
//	Author: Gordon D McKendrick
//
//	Collidable Interface
//		Base for the collidable objects
//		Has methods for checking hit detection

package jamazing.jamstory.object.Collidable 
{
	import flash.events.Event;
	import flash.geom.Point;

	public class Collidable
	{
		public var x:Number;
		public var y:Number;
		internal var radius:Number;
		internal var members:Array; //array of collidables
		
		//	Constructor: default
		public function Collidable(x:int, y:int, radius:int)
		{
			this.x = x;
			this.y = y;
			this.radius = radius;
			members = new Array();
		}
		
		//	Function: isHit
		//	Returns true if the collidable is hitting it
		public function isHit(c:Collidable):Boolean
		{
			//	If it's a box collidable, process it as such
			//	Otherwise, treat it as a standard, radial collidable
			if (c is BoxCollidable) {
				var b:BoxCollidable = c as BoxCollidable;
				
			}else {
				var distance:Number = (x - c.x) * (x - c.x) + (y - c.y) * (y - c.y);
				var difference:Number = distance - ((radius + c.radius)*(radius + c.radius));
				//	If hits, check every sub object
				//	If there are no sub object - return
				//	If any sub object (and their children) registers a hit - return true
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