package jamazing.jamstory.engine 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import jamazing.jamstory.entity.Dynamic;
	import jamazing.jamstory.events.JamStoryEvent;

	public class DynamicSound 
	{
		public var x:Number;
		public var y:Number;
		public var transform:SoundTransform;
		public var channel:SoundChannel;
		public var isAlive:Boolean;
		public var falloff:Number;
		public var volume:Number;
		
		private var obj:Dynamic;
		private var stage:Stage;
		
		public function DynamicSound(stage:Stage, obj:Dynamic, sound:Sound, falloff:Number, volume:Number) 
		{
			transform = new SoundTransform();
			
			this.volume = volume;
			this.stage = stage;
			isAlive = true;
			x = obj.x;
			y = obj.y;
			this.falloff = falloff;
			this.obj = obj;
			
			channel = sound.play();
			update(0,0);
			channel.soundTransform = transform;
			
			stage.addEventListener(JamStoryEvent.TICK, onTick);
		}
		
		public function onTick(e:JamStoryEvent):void
		{
			if (obj.isAlive){
				x = obj.x;
				y = obj.y;
			}else {
				channel.stop();
			}
		}
		
		public function update(sx:Number, sy:Number):void
		{
			const norm:Number = 250  * falloff;
			var dx:Number = (x - sx) / norm;
			var dy:Number = (y - sy) / norm;
			
			var distance:Number = Math.pow(dx, 2) + Math.pow(dy, 2);
			if (distance < 0.5) distance = 0.5;
			
			if (dx < 0) {
				if (Math.abs(dx) < 1) dx = 1;
				transform.pan = (1 / dx) - 1;
			}else {
				if (Math.abs(dx) < 1) dx = -1;
				transform.pan = (1/dx) + 1;
			}
			
			transform.volume = ((1 / distance)*volume);
			
			channel.soundTransform = transform;
		}
		
		//	Words on a falloff of 1/d^2 similar to light.
		//	Distances are normalised, to make sound more realistic e.g. 1/2 sound at stage edge
		private function getDistance(sx:Number, sy:Number):Number
		{
			const normalisation:Number = 250;
			var dx:Number = (x - sx) / normalisation;
			var dy:Number = (y - sy) / normalisation;
			var distanceSquare:Number = Math.pow(dx, 2)  + Math.pow(dy, 2);
			return (distanceSquare);
		}
		
	}

}