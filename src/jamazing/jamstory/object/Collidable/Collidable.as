//	Copyright 2012 Jamazing Games©
//	Author: Gordon D McKendrick
//
//	Collidable Interface
//		Base for the collidable objects
//		Has methods for checking hit detection

package jamazing.jamstory.object.Collidable 
{
	import flash.display.Sprite;

	public class Collidable
	{
		internal var x:int;
		internal var y:int;
		internal var radius:int;
		internal var members:Array; //array of collidables
		
		//	Constructor: default
		public function Collidable(x:int, y:int, radius:int)
		{
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
			if (typeof(c) == BoxCollidable) {
				var b:BoxCollidable = c as BoxCollidable;
				
			}else{
				var distance = Math.sqrt((x + c.x) * (x + c.x) + (y + c.y) * (y + c.y));
				var difference = distance - (radius + c.radius);
				
				//	If hits, check every sub object
				//	If there are no sub objects - return
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
		}
		
	}

}