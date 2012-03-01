//	Copyright 2012 Jamazing Games©
//	Author: Gordon D Mckendrick
//	
//	Layer
//		A layer of display objects
//		Allows movement of the entire layer at once

package jamazing.jamstory.containers 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import jamazing.jamstory.events.JamStoryEvent;

	//	Class: Layer
	public class Layer extends Sprite
	{
		public var parallaxFactor:Number;	//	Speed at which this moves with the rest of the game (1 moves constantly, 0 does not move)
		public var staticArt:Array;			//	Art with no collision box attached
		
		//	Constructor: default
		public function Layer(parallaxFactor:Number = 0, xMin:Number = 0, yMin:Number = 0, xMax:Number = 0, yMax:Number = 0 ) 
		{
			super();
			
			this.parallaxFactor = parallaxFactor;
			
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	Function: onInit
		//	Initialises the layer once in the stage
		private function onInit(e:Event = null):void
		{
			staticArt = new Array();
			
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
		
		//	Function: addArt
		//	Adds a peice of art to this background
		public function addArt(x:Number, y:Number, width:Number, height:Number, art:Bitmap):void
		{
			//	ensure non-null
			if (!art) return;
			
			
			staticArt.push(art);
			addChild(art);
			art.width = width;
			art.height = height;
			art.x = x + 80;
			art.y = y - 120;
		}
	}

}