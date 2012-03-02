//	Copyright 2012 Jamazing Games©
//	Author: 
//
//	Jam
//	Base Jam class that can be collided with by the player etc

package jamazing.jamstory.entity 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import jamazing.jamstory.entity.Throwable;
	import jamazing.jamstory.engine.Resource;
	
	//	Class: Jam
	public class Jam extends Throwable
	{
		private var JamEnum:JamTypes;
		private var splatted:Boolean;
		
		//	Constructor: default
		public function Jam() 
		{
			super();
			super.bouncesMax = 0;
			if (stage) { onInit(); }
			else { addEventListener(Event.ADDED_TO_STAGE, onInit); }
		}
		
		private function onInit(e:Event = null):void
		{
			splatted = false;
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			bitmap = new Resource.JAM_THROW();
			bitmap.width = 40;
			bitmap.height = 60;
			addChild(bitmap);
			
			bitmap.x = -bitmap.width / 2;
			bitmap.y = -bitmap.height / 2;
			
			addEventListener(Event.ENTER_FRAME, onTick);
			
		}
		
		private function onTick(e:Event):void
		{
			if (isMoving)
			{
				rotation = (Math.atan2 (ySpeed, xSpeed)) * 180 / (Math.PI);
			}
			else if(!splatted)
			{
				var bitmapData:Bitmap = new Resource.JAM_SPLAT();
				splatted = true;
				bitmap.bitmapData = bitmapData.bitmapData;
				bitmap.width = 50;
				bitmap.height = 75;
				rotation = 0;
			
				bitmap.x = -bitmap.width / 2;
				bitmap.y = -bitmap.height / 2;
			}
		}
		
		public function get isSplatted():Boolean
		{
			return splatted;
		}
		
	}

}

import jamazing.jamstory.language.Enum;

internal class JamTypes extends Enum
{
	public static const STICKY_JAM:JamTypes = new JamTypes(JamTypes.STICKY_JAM);
	public static const SLIPPY_JAM:JamTypes = new JamTypes(JamTypes.SLIPPY_JAM);
	public static const BOUNCY_JAM:JamTypes = new JamTypes(JamTypes.BOUNCY_JAM);
	
	
	public function JamTypes(enum:JamTypes, value:int=0, string:String=null)	
	{
		super(enum, value, string);
	}
	
}