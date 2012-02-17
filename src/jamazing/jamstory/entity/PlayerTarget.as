//	Copyright 2012 Jamazing Games©
//	Author: Gordon D Mckendrick
//	PlayerTarget
//		The targetting system for the player, as a graphical display
//		handles throwing and display of the reticule

package jamazing.jamstory.entity 
{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	//	Class: PlayerTarget
	public class PlayerTarget extends Sprite
	{
		
		private static const radius = 150;	//	radius from player to the reticule
		private var reticule:Shape;
		
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
			//	Memory Allocation
			reticule = new Shape();
			
			//	Variable Initialisation
			reticule.graphics.beginFill(0xFF0000);
			reticule.graphics.drawCircle(0, 0, 10);
			reticule.graphics.drawCircle(radius, 0, 5);
			reticule.graphics.endFill();
			
			//	Child Objects
			addChild(reticule);
			
			//	Event Listeners
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(Event.ENTER_FRAME, onTick);
		}
		
		//	Function: onTick
		//	Runs once per frame to update the positions
		private function onTick(e:Event):void
		{
			
			var point:Point = localToGlobal(new Point(x, y));
			var dx:Number = stage.mouseX - point.x;
			var dy:Number = stage.mouseY - point.y;
			var angle:Number = (180 / Math.PI) * Math.atan(dy / dx);
			if (dx < 0) {
				angle += 180;
			}
			rotation = angle;
		}
		
		private function onMove(e:MouseEvent):void
		{
			
		}
		
	}

}