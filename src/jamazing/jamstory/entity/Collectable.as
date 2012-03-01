//	Copyright 2012 Jamazing Games©
//	Author: Ivan Mateev
//
//	Collectable
//		Represents a collectable in the game


package jamazing.jamstory.entity 
{
	import flash.display.Bitmap;
	import jamazing.jamstory.language.Enum;
	import flash.events.Event;
	import jamazing.jamstory.engine.Resource;
	
	/*
	 * I am thinking that different Collectables should extend Collectable as to avoid having a collectableType variable.
	 * Maybe we can do this later on?
	 * -Ivan
	 */
	public class Collectable extends Static 
	{
		private var collectableType:Collectables;			// This specifies the type of the collectable	
		
		public function Collectable(x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0, bitmapData:Bitmap = null) 
		{
			super(x, y, width, height, bitmapData);	
			
			if (stage) onInit();									
			else addEventListener(Event.ADDED_TO_STAGE, onInit);			

			collectableType = Collectables.GENERIC;
		}
		
		private function onInit(e:Event = null):void
		{
			// Initialize the sprite:
			bitmap = new Resource.GENERIC_POWERUP();
			bitmap.width /= 12;// ;-]
			bitmap.height /= 12;
			addChild(bitmap);
			bitmap.x = bitmap.width / 2;
			bitmap.y = bitmap.height / 2;
			bitmap.smoothing = true;
			
			// Initialize the hitbox
			hitbox = new BoxCollidable(x , y, trueWidth,trueHeight);
		}
	}
}
import jamazing.jamstory.language.Enum;

	internal class Collectables extends Enum
	{
		public static const GENERIC:Collectables = new Collectables(GENERIC, 0);
		
		GENERIC.setString("GENERIC");
		
		public function Collectables(enum:Collectables,value:int=0,string:String=null)
		{
			super(enum, value, string);
		}	
	}