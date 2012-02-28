//	Copyright 2012 Jamazing Games©
//	Author: Gordon D Mckendrick
//	PlayerTarget
//		The targetting system for the player, as a graphical display
//		handles throwing and display of the reticule


package jamazing.jamstory.living 
{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import jamazing.jamstory.events.PlayerEvent;

	
	//	Class: PlayerTarget
	public class PlayerTarget extends Sprite
	{
		private static const radius:int = 150;	//	radius from player to the visible crosshair marker
		
		private var reticule:Shape;				//	Visual object for the crosshair

		private var throwPower:Number;			//	Current level of power that has been built up
		private var charging:Boolean;			//	True if the player is holding the mouse to charge the shot
		
		
		//	Constructor: default
		public function PlayerTarget() 
		{
				if (stage) onInit();
				else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		
		//	Function: onInit
		//	Initialises the reticule once the player and stage are created
		private function onInit(e:Event = null):void
		{
			reticule = new Shape();
			
			charging = false;
			throwPower = 0;
			
			reticule.graphics.beginFill(0xFF0000);
			reticule.graphics.drawCircle(radius, 0, 5);
			reticule.graphics.endFill();
			
			addChild(reticule);
			
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(Event.ENTER_FRAME, onTick);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		//	Function: onTick
		//	Runs once per frame to update the positions
		private function onTick(e:Event):void
		{
			rotation = getAimingAngle();	//	Match the visual crosshair position to the position your mouse aims at
			updateThrow();
		}
		
				
		
		//	Listener: onMouseDown
		//	When the mouse is held down, the power of the next through increases
		private function onMouseDown(e:MouseEvent):void
		{
			throwPower = 0;
			charging = true;
		}
		
		
		//	Listener: onMouseUp
		//	When the mouse is released, the player should throw
		private function onMouseUp(e:MouseEvent):void
		{
			if(charging){
				throwJam();
			}
		}
		
		
		//	Function: updateThrow()
		//	Performs helper functionality for updating how the throw works
		private function updateThrow():void
		{
			if (charging) {
				throwPower++;
			}
			if (throwPower > 100) {
				throwJam();
			}
		}
		
		
		//	Function: getAimingAngle
		//	Returns the angle at which the player is aiming
		//	Returns the angle with the position x, direction
		private function getAimingAngle():Number
		{
			//	Get the angle from the player to the cursor
			var point:Point = localToGlobal(new Point(x, y));			//	Turn player to stage co-ordinates
			var dx:Number = stage.mouseX - point.x;						//	Get mouse stage co-ordinates
			var dy:Number = stage.mouseY - point.y;
			var angle:Number = (180 / Math.PI) * Math.atan(dy / dx);	//	Calculate angle between the player and the mouse position
			
			//	Ensure the angle is correct for negative x
			if (dx < 0) {
				angle += 180;
			}
			return angle;
		}
	
		
		//	Function: throwJam()
		//	Throws the currently selected jam, at the angle you're pointing to
		private function throwJam():void
		{
			var angle:Number = getAimingAngle();
			dispatchEvent(new PlayerEvent("THROW", parent.x, parent.y, angle, throwPower+10));
			
			//	reset power etc for next throw
			throwPower = 0;
			charging = false;
		}
		
	}

}