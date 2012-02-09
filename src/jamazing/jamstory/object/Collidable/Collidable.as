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
		
		public function Collidable(x:int, y:int, radius:int)
		{
			this.x = x;
			this.y = y;
			this.radius = radius;
		}
		
		public function isHit(c:Collidable):Boolean
		{
			if (typeof(c) == BoxCollidable) {
				var b:BoxCollidable = c as BoxCollidable;
				//a/cos(x) = h
				
			}else{
				var distance = Math.sqrt((x + c.x) * (x + c.x) + (y + c.y) * (y + c.y));
				var difference = distance - (radius + c.radius);
				return (difference <= 0);
			}
		}
		
	}

}