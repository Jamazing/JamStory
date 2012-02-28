//	Copyright 2012 Jamazing Games©
//	Author: Gordon D Mckendrick
//
//	Resource
//		Static utility for easy access to all the embedded resources
//		Avoids problems with embedded code being hidden through other classes

package jamazing.jamstory.engine 
{

	
	//	Class: Resource
	public final class Resource 
	{
		
		//	Constructor: default
		public function Resource() 
		{
		}
		
		//	The player's character image.
		[Embed(source = "../../../../resources/jamjar.png")]
		public static var CHARACTER_IMAGE:Class;
		
		//	The main static background image.
		[Embed(source = "../../../../resources/kitchen.jpg")]
		public static var BACKGROUND_IMAGE:Class;
		
		//	The level data as an XML
		//		Note: The mimeType fakes an octet stream as flash will try to compile the embedded XML file otherwise.
		[Embed(source="../../../../resources/level.xml" , mimeType="application/octet-stream")]
		public static var LEVEL:Class
	}

}