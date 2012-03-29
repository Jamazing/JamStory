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
		
		//	The main platform graphic - TEMPORARY
		[Embed(source = "../../../../resources/gfx/platform.png")]
		public static const IMAGE_PLATFORM:Class;
				
		
		//	The player's character image.
		[Embed(source = "../../../../resources/gfx/jamjar.png")]
		public static const CHARACTER_IMAGE:Class;
		
		//	The main static background image.
		[Embed(source = "../../../../resources/gfx/kitchen.jpg")]
		public static const BACKGROUND_IMAGE:Class;
		
		
		//	The level data as an XML
		//		Note: The mimeType fakes an octet stream as flash will try to compile the embedded XML file otherwise.
		[Embed(source="../../../../resources/levels/level0.xml" , mimeType="application/octet-stream")]
		private static const LEVEL0:Class
		
		[Embed(source="../../../../resources/levels/level1.xml" , mimeType="application/octet-stream")]
		private static const LEVEL1:Class
		
		[Embed(source="../../../../resources/levels/level2.xml" , mimeType="application/octet-stream")]
		private static const LEVEL2:Class
		
		public static const LEVELS:Array = new Array(
										Resource.LEVEL0,
										Resource.LEVEL1,
										Resource.LEVEL2
										);
		
		
		//	The main Background music
		[Embed(source = "../../../../resources/audio/bongo.mp3")]
		public static const SOUND_BGMUSIC:Class;
		
		//	The jumping noise
		[Embed(source = "../../../../resources/audio/jump.mp3")]
		public static const SOUND_JUMP:Class;
		
		[Embed(source = "../../../../resources/audio/death.mp3")]
		public static const SOUND_DEATH:Class;
		
		[Embed(source = "../../../../resources/audio/enemy_jammed.mp3")]
		public static const SOUND_JAMMED:Class;
		
		[Embed(source = "../../../../resources/audio/throw.mp3")]
		public static const SOUND_THROW:Class;
		
		[Embed(source = "../../../../resources/audio/water_splash.mp3")]
		public static const SOUND_SPLASH:Class;
		
		
		//Jam being thrown
		[Embed(source = "../../../../resources/gfx/JamThrowcopy.png")]
		public static const JAM_THROW:Class;
		
		//Jam Hitting the ground
		[Embed(source = "../../../../resources/gfx/JamHit.png")]
		public static const JAM_HIT:Class;
		
		//Jam splat
		[Embed(source="../../../../resources/gfx/JamSplat.png")]
		public static const JAM_SPLAT:Class;
		
		//Powerup
		[Embed(source = "../../../../resources/gfx/powerup.png")]
		public static const GENERIC_POWERUP:Class;
	}

}