//	Copyright 2012 Jamazing Games
//	Author: Gordon D Mckendrick
//
//	BoxCollidable
//		A collidable box shaped object

package jamazing.jamstory.object.Collidable 
{

	//	Class: BoxCollidable
	//	Represents a Box Shapes Collidable Object
	public class BoxCollidable extends Collidable
	{
		internal var width:Number;
		internal var height:Number;
		internal var angle:Number;
		
		
		//	Constructor: default
		public function BoxCollidable(x:int, y:int, width:int, height:int)
		{
			super(x, y, width);
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
		}
		
		//	Function: isHit	(OVERRIDE)
		//	Returns true if the collidable c, is touching this BoxCollidable
		override public function isHit(c:Collidable):Boolean
		{
			if (c is BoxCollidable) {
				var b:BoxCollidable = c as BoxCollidable;
				return false;
				
			}else {
				var xDistance:Number = Math.abs( (c.x - x) );
				var yDistance:Number = Math.abs( (c.y - y) );
				
				if (xDistance > (width / 2 + c.radius)) return false;
				if (yDistance > (height / 2 + c.radius)) return false;
				
				if (xDistance <= (width / 2)) return true;
				if (yDistance <= (height / 2)) return true;

				//	Check if distance^2 <= radius^2; hit if true
				if (((xDistance - width / 2) * (xDistance - width / 2) + 
					(yDistance - height / 2) * (yDistance - height / 2)) 
					<= 
					(c.radius * c.radius)) {
						return true;
					}else {
						return false;
					}
			}
		}
	}

}