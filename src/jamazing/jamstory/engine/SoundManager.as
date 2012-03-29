package jamazing.jamstory.engine 
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.media.SoundChannel;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import jamazing.jamstory.entity.Dynamic;
	import jamazing.jamstory.events.JamStoryEvent;
	import jamazing.jamstory.events.PlayerEvent;
	import jamazing.jamstory.events.SoundEvent;
	
	//	Plays sounds on demand of events - that is all
	public class SoundManager 
	{
		private static var stage:Stage;
		private static var x:Number;
		private static var y:Number;
		private static var sounds:Array;
		
		public function SoundManager(stageRef:Stage) 
		{
			x = 0;
			y = 0;
			sounds = new Array();
			stage = stageRef;
			stage.addEventListener(JamStoryEvent.CAMERA_POSITION, onCamera);
			stage.addEventListener(JamStoryEvent.TICK, onTick);
			stage.addEventListener(SoundEvent.PLAY, onSound);
		}
		
		public function onTick(e:JamStoryEvent):void
		{
			for each (var s:DynamicSound in sounds) {
				if (!s.isAlive) continue;
				s.update(x, y);
			}
		}
		
		public function onSound(e:SoundEvent):void
		{
			var dynSound:DynamicSound = new DynamicSound(stage, e.obj, e.sound, e.falloff, e.volume);
			sounds.push(dynSound);
		}
		
		private function onCamera(e:JamStoryEvent):void
		{
			x = e.x;
			y = e.y;
		}
		
		private function onJump():void
		{
			var sChan:SoundChannel = new SoundChannel();
		}
	}

}