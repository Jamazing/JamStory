//	Copyright 2012 Jamazing Games©
//	Author: John A Robb
//	
//	KeyHandler Utility
//	Abstracts key pressing events for easy access

package jamazing.jamstory.util 
{	
	import flash.display.Stage;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.events.KeyboardEvent;

	
	 public class KeyHandler 
	{
		//Const ints for characters.
		public const A:int = 65;	
		public const B:int = 66;
		public const C:int = 67;
		public const D:int = 68;
		public const E:int = 69;
		public const F:int = 70;
		public const G:int = 71;
		public const H:int = 72;
		public const I:int = 73;
		public const J:int = 74;
		public const K:int = 75;
		public const L:int = 76;
		public const M:int = 77;
		public const N:int = 78;
		public const O:int = 79;
		public const P:int = 80;
		public const Q:int = 81;
		public const R:int = 82;
		public const S:int = 83;
		public const T:int = 84;
		public const U:int = 85;
		public const V:int = 86;
		public const W:int = 87;
		public const X:int = 88; 
		public const Y:int = 89;
		public const Z:int = 90;
		
		private static var keys:Array = new Array(); // Boolean Array
		private var stageRef:Stage; // Stage Reference
		
		//Function: KeyHandler(stage:Stage)
		//Adds event listeners for keypresses
		public function KeyHandler(stage:Stage) 
		{
			this.stageRef = stage;
			stageRef.addEventListener(KeyboardEvent.KEY_DOWN, onDown);
			stageRef.addEventListener(KeyboardEvent.KEY_UP, onUp);
		}
		
		//Function: onDown(e:KeyboardEvent)
		//Returns true when keys are pressed.
		private function onDown(e:KeyboardEvent):void
		{
			keys[e.keyCode] = true;
		}
		
		//Function: onUp(e: KeyboardEvent)
		//Returns false when keys are not pressed.
		private function onUp(e:KeyboardEvent):void
		{
			keys[e.keyCode] = false;
		}
		
		//Function: isDown(keycode:uint)
		//Returns a true value for a particular keycode
		//when the corresponding key is pressed.
		public function isDown(keyCode:uint):Boolean
		{
			return (keys[keyCode]);
		}
		
		//Function: allDown(...keyCodes:uint)
		//Returns a true value for any number of keys
		//pressed simlultaneously.
		//Returns true if all keys are pressed.
		public function allDown(...keyCodes):Boolean
		{
			for (var i:int; i < keyCodes.length; ++i){
				if (! (keys[keyCodes[i]]) ){
					return false;
				}
			}
			return true;
		}
		
		//Function: anyDown(...keyCodes:uint)
		//Returns a true value if any keys are pressed.
		//Returns false if no keys are pressed.
		public function anyDown(...keyCodes):Boolean
		{
			for (var i:int; i < keyCodes.length; ++i){
				if ((keys[keyCodes[i]])){
					return false;
				}
			}
			return true;
		}
		
	}	

}