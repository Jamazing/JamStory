//	Copyright 2012 Jamazing Games©
//	Author: John A Robb
//	
//	KeyHandler Utility
//		Abstracts key pressing events for easy access

package jamazing.jamstory.util 
{	
	import flash.display.Stage;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.events.KeyboardEvent;

	
	//	Class: Keys
	public final class Keys 
	{
		//	Const uint's for character keyCodes.
		public static const A:uint = 65;	
		public static const B:uint = 66;
		public static const C:uint = 67;
		public static const D:uint = 68;
		public static const E:uint = 69;
		public static const F:uint = 70;
		public static const G:uint = 71;
		public static const H:uint = 72;
		public static const I:uint = 73;
		public static const J:uint = 74;
		public static const K:uint = 75;
		public static const L:uint = 76;
		public static const M:uint = 77;
		public static const N:uint = 78;
		public static const O:uint = 79;
		public static const P:uint = 80;
		public static const Q:uint = 81;
		public static const R:uint = 82;
		public static const S:uint = 83;
		public static const T:uint = 84;
		public static const U:uint = 85;
		public static const V:uint = 86;
		public static const W:uint = 87;
		public static const X:uint = 88; 
		public static const Y:uint = 89;
		public static const Z:uint = 90;
		
		private static var keys:Array = new Array(); //	Boolean Array
		private var stageRef:Stage; 				 //	Stage Reference
		
		
		//	Constructor: (Stage)
		public function Keys(stage:Stage) 
		{
			this.stageRef = stage;
			stageRef.addEventListener(KeyboardEvent.KEY_DOWN, onDown);
			stageRef.addEventListener(KeyboardEvent.KEY_UP, onUp);
		}
		
		//	Listener: onDown
		//	Returns true when keys are pressed.
		private function onDown(e:KeyboardEvent):void
		{
			keys[e.keyCode] = true;
		}
		
		//	Listener: onUp
		//	Returns false when keys are not pressed.
		private function onUp(e:KeyboardEvent):void
		{
			keys[e.keyCode] = false;
		}
		
		//	Function: isDown
		//	Returns if the specific key is pressed
		public static function isDown(keyCode:uint):Boolean
		{
			return (keys[keyCode]);
		}
		
		//	Function: allDown
		//	Returns true if all keys specified are pressed.
		public static function allDown(...keyCodes):Boolean
		{
			for (var i:int = 0; i < keyCodes.length; ++i){
				if (! (keys[keyCodes[i]]) ){
					return false;
				}
			}
			return true;
		}
		
		//	Function: anyDown
		//	Returns true if any keys specified are pressed
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