//	Copyright 2012 Jamazing Games©
//	Author: Gordon D Mckendrick
//
//	Platform
//		Temporary Class
//		Represents a platform you can jump on and run around

package jamazing.jamstory.object 
{
	import flash.display.Sprite;
	
	
	public class Platform extends Sprite
	{
		
		public function Platform(x:int, y:int, width:int, height:int, colour:int = 0xFF6600  ) 
		{
			super();
			
			graphics.beginFill(colour);
			graphics.drawRect( -width / 2, -height / 2, width, height);
			graphics.endFill();
			
			this.width = width;
			this.height = height;
			this.x = x;
			this.y = y;
		}
		
	}

}