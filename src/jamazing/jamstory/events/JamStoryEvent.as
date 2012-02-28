//	Copyright 2012 Jamazing Games©
//	Author: Gordon D Mckendrick
//	
//	JamStoryEvent
//		Basic event type for handling system calls such as onTick efficiently


package jamazing.jamstory.events 
{
	import flash.events.Event;
	
	public class JamStoryEvent extends Event 
	{
		public static const TICK:String = "TICK";						//	Things that want to react every frame (but save memory from the flash standard event)
		public static const TICK_INTRO:String = "TICK_INTRO";			//	Intro menus listeners that want to react when the main game is not functional
		public static const TICK_MAIN:String = "TICK_MAIN";				//	Main game lisenters that move objects etc during the game
		public static const TICK_PAUSE:String = "TICK_PAUSE";			//	Things that work during pause menus
		public static const CAMERA_POSITION:String = "CAMERA_POSITION";	//	Update of the camera positon
		
		public var tickCount:int;	//	Tick from the start of the program, that the event was called on
		public var x:Number;
		public var y:Number;
		
		//	Constructor: (String, Boolean, Boolean)
		public function JamStoryEvent(type:String, tickCount:int, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			this.tickCount = tickCount;
			
			super(type, bubbles, cancelable);
		} 
		
		//	Function: clone (OVERRIDE)
		//	Returns a reference to itself, for each event listener.
		//		This is unsafe, but saves very large amounts of memory.
		public override function clone():Event 
		{ 
			return this;
		} 
		
		//	Function: toString (OVERRIDE)
		//	Returns the string representation of the event
		public override function toString():String 
		{ 
			return formatToString("JamStoryEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}