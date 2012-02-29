//	Copyright 2012 Jamazing Games©
//	Author: Ivan Mateev
//
//	Collectable
//		Represents a collectable in the game



package jamazing.jamstory.entity 
{
	public class Collectable extends Static 
	{
		private var collectableType:Collectables;
		
		public function Collectable(type:Collectables, x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0, bitmapData:Bitmap = null) 
		{
			super(x, y, width, height, bitmapData);	
			collectableType = type;
		}
		
		
		
	}

}
import jamazing.jamstory.language.Enum;

internal class Collectables extends Enum
{
	public static const COIN:Collectables = new Collectables(COIN, 0);
	
	COIN.setString("COIN");
	
	public function Collectables(enum:Collectables,value:int=0,string:String=null)
	{
		super(enum, value, string);
	}	
}