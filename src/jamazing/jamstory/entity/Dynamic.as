//	Copyright 2012 Jamazing Games©
//	Author: Gordon D Mckendrick
//
//	Dynamic
//		A collidable object, with basic movement functionality, and visual parts

package jamazing.jamstory.entity 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import jamazing.jamstory.entity.Collidable.Collidable;
	
	//	Class: Dynamic
	public class Dynamic extends Sprite
	{
		public var collision:Collidable;	//	Collision box
		private var bitmap:Bitmap;			//	The bitmap display for this object
		
		private var xSpeed:Number;			//	Current movement speed in the x direction
		private var ySpeed:Number;
		private var xAccel:Number;			//	Amount that the xSpeed changes each frame
		private var yAccel:Number;
		
		//	Constructor: default
		public function Dynamic(xSpeed:Number = 0, ySpeed:Number = 0, xAccel:Number = 0, yAccel:number = 0 ) 
		{
			xSpeed = 0;
			ySpeed = 0;
			xAccel = 0;
			yAccel = 0;
			
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	Function: onInit
		//	Initialisation once added to the stage
		private function onInit(e:Event = null):void
		{

		}
		
		//	Set: x:Number
		public function set x(x:Number):void
		{
			this.x = x;
		}
		
		//	Set: y:Number
		public function set y(y:Number):void
		{
			this.y = y;
		}
	}

}