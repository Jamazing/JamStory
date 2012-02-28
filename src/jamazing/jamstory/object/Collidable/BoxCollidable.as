//	Copyright 2012 Jamazing Games
//	Author: Gordon D Mckendrick
//
//	BoxCollidable
//		A collidable box shaped object

package jamazing.jamstory.object.Collidable 
{

	
	//	Class: BoxCollidable
	public class BoxCollidable extends Collidable
	{
		internal var width:Number;		//	Width of the box
		internal var height:Number;		//	Height of the box
		internal var angle:Number;		//	Currently angle with the positive x-direction of the box
		
		
		//	Constructor: (int, int, int, int)
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
			//	if it is a box -> box collision
			if (c is BoxCollidable) {
				var b:BoxCollidable = c as BoxCollidable;
				return false;
				
			}else {
				//	If it is a box->circle collision
				var xDistance:Number = Math.abs( (c.x - x) );	//	Absolute distance between this and 'c' in the x direction
				var yDistance:Number = Math.abs( (c.y - y) );
				
				//	Check the basic cases that eliminate easy hits
				if (xDistance > (width / 2 + c.radius)) return false;	//	If the circle (c) is fully outside the box (this) return false
				if (yDistance > (height / 2 + c.radius)) return false;
				
				if (xDistance <= (width / 2)) return true;				//	If the circle (c) is fully inside the box (this) return true
				if (yDistance <= (height / 2)) return true;

				//	Check if (distance^2 <= radius^2); hit if true
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