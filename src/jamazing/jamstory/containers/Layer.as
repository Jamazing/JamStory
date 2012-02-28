//	Copyright 2012 Jamazing Games©
//	Author: Gordon D Mckendrick
//	
//	Layer
//		A layer of display objects
//		Allows movement of the entire layer at once

package jamazing.jamstory.containers 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import jamazing.jamstory.events.JamStoryEvent;

	//	Class: Layer
	public class Layer extends Sprite
	{
		public var parallaxFactor:Number;	//	Speed at which this moves with the rest of the game (1 moves constantly, 0 does not move)
		public var layers:Array;			//	Sub layers contained within this layer
		public var art:Array;				//	Art with no collision box attached
		public var staticObjects:Array;		//	Static collidable objects
		public var dynamicObjects:Array;	//	Dynamic collidable objects
		
		//	Constructor: default
		public function Layer() 
		{
			super();
			
			parallaxFactor = 1;
			
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	Function: onInit
		//	Initialises the layer once in the stage
		private function onInit(e:Event = null):void
		{
			layers = new Array();
			art = new Array();
			staticObjects = new Array();
			dynamicObjects = new Array();
			
			stage.addEventListener(JamStoryEvent.CAMERA_POSITION, onCamera);
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	Function: onCamera
		//	Updates the viewing position to where the camera tells it to be
		private function onCamera(e:JamStoryEvent):void
		{
			this.x = e.x * parallaxFactor;
			this.y = e.y * parallaxFactor;
		}
		
	}

}