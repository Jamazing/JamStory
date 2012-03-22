//	Copyright 2012 Jamazing Games©
//	Author: Gordon D Mckendrick
//
//	Dynamic
//		A collidable object, with basic movement functionality, and visual parts

package jamazing.jamstory.entity 
{
	import flash.display.Bitmap;
	import flash.events.Event;
	import jamazing.jamstory.entity.Collidable;
	
	//	Class: Dynamic
	public class Dynamic extends Static
	{
		public var xSpeed:Number;			//	Current movement speed in the x direction
		public var ySpeed:Number;
		public var xAccel:Number;			//	Amount that the xSpeed changes each frame
		public var yAccel:Number;
		public var isMoving:Boolean = true;		//	True if the object is currently in motion
		
		//	Constructor: default
//		public function Dynamic()
		public function Dynamic(inputX:Number = 0, inputY:Number = 0, inputWidth:Number = 0, inputHeight:Number = 0, inputBitmapData:Bitmap = null) /* Constructor didn't have parameters */
		{	
			super(inputX,inputY,inputWidth,inputHeight,inputBitmapData);
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	Function: onInit
		//	Initialisation once added to the stage
		private function onInit(e:Event = null):void
		{		
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(Event.ENTER_FRAME, onTick);
		}
		
		//	Listener: onTick
		//	Updates the position each frame
		private function onTick(e:Event):void
		{
			//	Update Movement
			if (isMoving) {
				x += xSpeed;
				y += ySpeed;
				ySpeed += yAccel;
				xSpeed += xAccel;
			}
			
			//	Update the collision box position
			if(hitbox){
				hitbox.x = x;
				hitbox.y = y;
			}
		}
		
	}

}