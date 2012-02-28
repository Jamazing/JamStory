//	Copyright 2012 Jamazing Games©
//	Author: Gordon D Mckendrick
//	
//	Camera
//		Has a focus on a specific object, and outputs it's position each frame
//		Allows for replays, focusing on different parts of the screen etc.
//		Future plans to implement different camera effects
//		All positions are world-relative

package jamazing.jamstory.engine 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import jamazing.jamstory.events.JamStoryEvent;

	//	Class: Camera
	public class Camera
	{
		public static var focus:DisplayObject;
		public static var stageRef:Stage;
		
		//	Constructor: default
		public function Camera(stage:Stage, focusObject:DisplayObject = null) 
		{
			super();
			
			focus = new Sprite();
			focus.x = stage.stageWidth / 2;
			focus.y = stage.stageHeight / 2;
			
			stageRef = stage;
			stageRef.addEventListener(JamStoryEvent.TICK, onTick);
		}
		
		//	Function: onTick
		//	Updates all listeners with the new positions
		private function onTick(e:JamStoryEvent):void
		{
			if (focus){
				var jsEvent:JamStoryEvent = new JamStoryEvent(JamStoryEvent.CAMERA_POSITION,0);
				jsEvent.x = focus.x;
				jsEvent.y = focus.y;
				stageRef.dispatchEvent( jsEvent );
			}
		}
		
		//	Function: setFocus
		//	Sets the new object to focus on
		public static function setFocus(focusObject:DisplayObject):void
		{
			focus = focusObject;
		}
		
	}

}