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
	import flash.events.TextEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import jamazing.jamstory.events.PlayerEvent;

	//	Class: PlayerTarget
	public class PlayerTarget extends Sprite
	{
		
		private static const radius = 150;	//	radius from player to the reticule
		
		private var power:int;
		private var charging:Boolean;
		private var reticule:Shape;
		private var thrown:Boolean;
		
		private var jam:Shape;
		private var outPower:TextField;
		private var jamSpeed:Number;
		
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
			jam = new Shape();
			reticule = new Shape();
			outPower = new TextField();
			
			//	Variable Initialisation
			charging = false;
			power = 0;
			thrown = false;
			outPower.y = -100;
			outPower.text = power.toString();
			
			//	Graphics Initialisation
			reticule.graphics.beginFill(0xFF0000);
			reticule.graphics.drawCircle(radius, 0, 5);
			reticule.graphics.endFill();
			
			jam.graphics.beginFill(0x0066FF);
			jam.graphics.drawCircle(0, 0, 5);
			jam.graphics.endFill();
			jam.visible = false;
			
			//	Child Objects
			addChild(reticule);
			addChild(outPower);
			addChild(jam);
			
			//	Event Listeners
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(Event.ENTER_FRAME, onTick);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		//	Function: onTick
		//	Runs once per frame to update the positions
		private function onTick(e:Event):void
		{
			//	Set visual reticule to the radius around the player
			//		pointing to your cursor
			var point:Point = localToGlobal(new Point(x, y));
			var dx:Number = stage.mouseX - point.x;
			var dy:Number = stage.mouseY - point.y;
			var angle:Number = (180 / Math.PI) * Math.atan(dy / dx);
			if (dx < 0) {
				angle += 180;
			}
			rotation = angle;
			
			//	Charge the shot if charging
			if (charging) {
				power++;
				outPower.text = power.toString();
			}
			if (power > 99) {
				throwJam();
			}
			jam.x += jamSpeed;
			
		}
		
		//	Listener: onMouseDown
		//	Begins charging the shot when the mouse is held
		private function onMouseDown(e:MouseEvent):void
		{
			power = 0;
			charging = true;
		}
		
		//	Listener: onMouseUp
		//	Throws the 'jam' when the mouse button is released
		private function  onMouseUp(e:MouseEvent):void
		{
			if (charging){
				throwJam();
			}
		}
		
		//	Function: throwJam
		//	!!!! Evolve this to the player class when it's finished
		//	Throws a "jam" at the current power, in the direction
		private function throwJam():void
		{
			thrown = true;
			jam.visible = true;
			jam.x = 0;
			jam.y = 0;
			jamSpeed = power / 3;
			dispatchEvent(new PlayerEvent("THROW", x, y, rotation, jamSpeed));
			
			power = 0;
			charging = false;
		}
		
	}

}