//	Copyright 2012 Jamazing Games©
//	Author: John Robb
//	Contrib: Gordon D Mckendrick
//	
//	Jam
//	Base Jam class that can be collided with by the player etc

package jamazing.jamstory.entity 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import jamazing.jamstory.entity.Throwable;
	import jamazing.jamstory.engine.Resource;
	
	//	Class: Jam
	public class Jam extends Throwable
	{
		public static const STICKY:int = 0;
		public static const SLIPPY:int = 1;
		public static const BOUNCEY:int = 2;
		
		private var JamEnum:JamTypes;
		private var splatted:Boolean;
		public var colour:ColorTransform;
		public var type:int;
		
		//	Constructor: default
		public function Jam(type:int = 0, colour:ColorTransform = null) 
		{
			this.colour = colour;
			this.type = type;
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
			bitmap.bitmapData.colorTransform(bitmap.bitmapData.rect, colour);
			addChild(bitmap);
			
			trueWidth = 30;
			trueHeight = 30;
			hitbox = new Collidable(x, y, trueWidth);
			
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
				bitmapData.bitmapData.colorTransform(bitmapData.bitmapData.rect, colour);
				splatted = true;
				bitmap.bitmapData = bitmapData.bitmapData;
				bitmap.width = 50;
				bitmap.height = 75;
			
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