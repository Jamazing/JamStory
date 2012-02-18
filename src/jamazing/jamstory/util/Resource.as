//	Copyright 2012 Jamazing Games©
//	Author: Gordon D Mckendrick
//	Resource
//		Static utility for easy access to all the embedded resources
//		Avoids problems with embedded code being hidden through other classes

package jamazing.jamstory.util 
{

	public class Resource 
	{
		
		public function Resource() 
		{
		}
		
		[Embed(source = "../../../../resources/jamjar.png")]
		public static var CHARACTER_IMAGE:Class;
		
		[Embed(source = "../../../../resources/kitchen.jpg")]
		public static var BACKGROUND_IMAGE:Class;
		
	}

}