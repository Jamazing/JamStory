//	Copyright 2012 Jamazing Games
//	Author: Gordon D Mckendrick
//
//	BoxCollidable
//		A collidable box shaped object

package jamazing.jamstory.entity 
{
	import jamazing.jamstory.entity.Collidable;
	
	//	Class: BoxCollidable
	public class BoxCollidable extends Collidable
	{
		internal var width:Number;		//	Width of the box
		internal var height:Number;		//	Height of the box
		internal var angle:Number;		//	Currently angle with the positive x-direction of the box
		
		private var isMain:Boolean;	//	True if it's the main box and not a side
		private var sides:Array;
		
		//	Constructor: (int, int, int, int)
		public function BoxCollidable(x:int, y:int, width:int, height:int, isMain:Boolean = true)
		{
			super(x, y, width);
			
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
			this.isMain = isMain;
			
			//	A box collidable for each side to test proper collisions
			//	indexes are: NONE, TOP, LEFT, BOTTOM, RIGHT
			if (isMain){
			sides = new Array(
					null,
					new BoxCollidable(x, (y - height / 2), width, 1, false),
					new BoxCollidable((x-width/2), y, 1, height, false),
					new BoxCollidable(x, (y+height/2), width, 1, false),
					new BoxCollidable((x+width/2), y, 1, height, false)
					);
			}
		}
		
		//	Function: isHit	(OVERRIDE)
		//	Returns true if the collidable c, is touching this BoxCollidable
		override public function isHit(c:Collidable):int
		{
			//	if it is a box -> box collision
			if (c is BoxCollidable) {
				var b:BoxCollidable = c as BoxCollidable;
				return SIDE_NONE;
				
			}else {
				if (isSideHit(c, SIDE_TOP)) return SIDE_TOP;
				if (isSideHit(c, SIDE_LEFT)) return SIDE_LEFT;
				if (isSideHit(c, SIDE_BOTTOM)) return SIDE_BOTTOM;
				if (isSideHit(c, SIDE_RIGHT)) return SIDE_RIGHT;
				else return SIDE_NONE;
			}
		}
		
		private function isSideHit(c:Collidable, side:int):Boolean
		{
			var b:BoxCollidable = sides[side];
			
			//	if it is a box -> box collision
			if (c is BoxCollidable) {
				return false;
				
			}else {
				//	If it is a box->circle collision
				var xDistance:Number = Math.abs( (c.x - b.x) );	//	Absolute distance between this and 'c' in the x direction
				var yDistance:Number = Math.abs( (c.y - b.y) );
				
				//	Check the basic cases that eliminate easy hits
				if (xDistance > (b.width / 2 + c.radius)) return false;	//	If the circle (c) is fully outside the box (this) return false
				if (yDistance > (b.height / 2 + c.radius)) return false;
				
				if (xDistance <= (b.width / 2)) return true;				//	If the circle (c) is fully inside the box (this) return true
				if (yDistance <= (b.height / 2)) return true;

				//	Check if (distance^2 <= radius^2); hit if true
				if (((xDistance - b.width / 2) * (xDistance - b.width / 2) + 
					(yDistance - b.height / 2) * (yDistance - b.height / 2)) 
					<= 
					(c.radius * c.radius)) {
						return true;
					}else {
						return false;
					}
			}
		}
		
		//	Moves this collidable and updates it's sides
		public function set xPos(x:Number):void
		{
			this.x = x;
			
			//	Update Sides
			//	Top
			var b:BoxCollidable = sides[SIDE_TOP];
			b.x = x;
			
			//	Left
			b = sides[SIDE_LEFT]
			b.x = x - width / 2;
			
			//	Bottom
			b = sides[SIDE_BOTTOM]
			b.x = x;
			
			//	Right
			b = sides[SIDE_RIGHT]
			b.x = x + width / 2;
		}
		
		//	Moves this collidable and updates it's sides
		public function set yPos(y:Number):void
		{
			this.y = y;
			
			//	Update Sides
			//	Top
			var b:BoxCollidable = sides[SIDE_TOP];
			b.y = y;
			
			//	Left
			b = sides[SIDE_LEFT]
			b.y = y - height/2;
			
			//	Bottom
			b = sides[SIDE_BOTTOM]
			b.y = y + height / 2;
			
			//	Right
			b = sides[SIDE_RIGHT]
			b.y = y;
		}
		

	}

}