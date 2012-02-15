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

	
	 public final class Keys 
	{
		//	Const ints for characters.
		public static const A:int = 65;	
		public static const B:int = 66;
		public static const C:int = 67;
		public static const D:int = 68;
		public static const E:int = 69;
		public static const F:int = 70;
		public static const G:int = 71;
		public static const H:int = 72;
		public static const I:int = 73;
		public static const J:int = 74;
		public static const K:int = 75;
		public static const L:int = 76;
		public static const M:int = 77;
		public static const N:int = 78;
		public static const O:int = 79;
		public static const P:int = 80;
		public static const Q:int = 81;
		public static const R:int = 82;
		public static const S:int = 83;
		public static const T:int = 84;
		public static const U:int = 85;
		public static const V:int = 86;
		public static const W:int = 87;
		public static const X:int = 88; 
		public static const Y:int = 89;
		public static const Z:int = 90;
		
		private static var keys:Array = new Array(); //	Boolean Array
		private var stageRef:Stage; 				 //	Stage Reference
		
		//	Function: KeyHandler(stage:Stage)
		//	Adds event listeners for keypresses
		public function Keys(stage:Stage) 
		{
			this.stageRef = stage;
			stageRef.addEventListener(KeyboardEvent.KEY_DOWN, onDown);
			stageRef.addEventListener(KeyboardEvent.KEY_UP, onUp);
		}
		
		//	Function: onDown(e:KeyboardEvent)
		//	Returns true when keys are pressed.
		private function onDown(e:KeyboardEvent):void
		{
			keys[e.keyCode] = true;
		}
		
		//	Function: onUp(e: KeyboardEvent)
		//	Returns false when keys are not pressed.
		private function onUp(e:KeyboardEvent):void
		{
			keys[e.keyCode] = false;
		}
		
		//	Function: isDown(keycode:uint)
		//	Returns a true value for a particular keycode
		//	when the corresponding key is pressed.
		public static function isDown(keyCode:uint):Boolean
		{
			return (keys[keyCode]);
		}
		
		//	Function: allDown(...keyCodes:uint)
		//	Returns a true value for any number of keys
		//	pressed simlultaneously.
		//	Returns true if all keys are pressed.
		public static function allDown(...keyCodes):Boolean
		{
			for (var i:int = 0; i < keyCodes.length; ++i){
				if (! (keys[keyCodes[i]]) ){
					return false;
				}
			}
			return true;
		}
		
		//	Function: anyDown(...keyCodes:uint)
		//	Returns a true value if any keys are pressed.
		//	Returns false if no keys are pressed.
		public static function anyDown(...keyCodes):Boolean
		{
			for (var i:int = 0; i < keyCodes.length; ++i){
				if ((keys[keyCodes[i]])){
					return true;
				}
			}
			return false;
		}
		
	}	

}