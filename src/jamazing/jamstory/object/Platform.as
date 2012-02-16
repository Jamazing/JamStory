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
		public var colour:int;	//	colour of the platform
		
		public function Platform(x:int, y:int, width:int, height:int, colour:int = 0x0033FF  ) 
		{
			super();
			this.colour = colour;
			
			//	Main graphics for the body
			graphics.beginFill(this.colour);
			graphics.drawRect( -width / 2, (-height / 2), width, height);
			graphics.endFill();
			
			//	Extra graphics for the top of the platform
			graphics.beginFill((this.colour)*0.8);
			graphics.drawRect( (-5*width / 8), (-2*height / 6)-(height/2), (5*width/4), (2*height/3));
			graphics.endFill();
			
			this.width = width;
			this.height = height;
			this.x = x;
			this.y = y;
		}
		
	}

}