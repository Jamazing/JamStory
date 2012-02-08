package jamazing.jamstory.util 
{	
	import flash.display.Stage;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	/**
	 * ...
	 * @author John A Robb
	 * Utility for handling user input.
	 */
	
	 public class KeyHandler 
	{
		//Const ints for characters.
		const A:int = 65;	
		const B:int = 66;
		const C:int = 67;
		const D:int = 68;
		const E:int = 69;
		const F:int = 70;
		const G:int = 71;
		const H:int = 72;
		const I:int = 73;
		const J:int = 74;
		const K:int = 75;
		const L:int = 76;
		const M:int = 77;
		const N:int = 78;
		const O:int = 79;
		const P:int = 80;
		const Q:int = 81;
		const R:int = 82;
		const S:int = 83;
		const T:int = 84;
		const U:int = 85;
		const V:int = 86;
		const W:int = 87;
		const X:int = 88; 
		const Y:int = 89;
		const Z:int = 90;
		
		private static var keys:Array; // Boolean Array
		private static var stageRef:Stage; // Stage Reference
		
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
		private function onDown(e:KeyboardEvent)
		{
			keys[e.keyCode] = true;
			keys[e.keyCodeA] = true;
			keys[e.keyCodeB] = true;
		}
		
		//Function: onUp(e: KeyboardEvent)
		//Returns false when keys are not pressed.
		private function onUp(e:KeyboardEvent)
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
		
		//Function: isDown(...keyCodes:uint)
		//Returns a true value for any number of keys
		//pressed simlultaneously.
		//Returns true if all keys are pressed.
		public function isDown(...keyCodes:uint):Boolean
		{
			
			for (var i:int; i < keyCodes.length; ++i)
			
			{
				
				if (!(keys[keyCodes[i]]))
				{
					return false;
					
				}
				
			}
			
			return true;
		}
		
		//Function: anyDown(...keyCodes:uint)
		//Returns a true value if any keys are pressed.
		//Returns false if no keys are pressed.
		public function anyDown(...keyCodes:uint):Boolean
		{
			
			for (var i:int; i < keyCodes.length; ++i)
			
			{
				
				if ((keys[keyCodes[i]]))
				{
					return false;
					
				}
				
			}
			
			return false;
		}
		
	}	

}