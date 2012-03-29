package jamazing.jamstory.events 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import jamazing.jamstory.entity.Dynamic;
	
	/**
	 * ...
	 * @author Gordon Mckendrick
	 */
	public class SoundEvent extends Event 
	{
		public static const PLAY:String = "PLAY";
		
		public var obj:Dynamic;
		public var sound:Sound;
		public var falloff:Number;
		public var volume:Number;
		
		public function SoundEvent(type:String, sound:Sound, obj:Dynamic, falloff:Number = 1, volume:Number = 1, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			this.volume = volume;
			this.obj = obj;
			this.sound = sound;
			this.falloff = falloff;
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new SoundEvent(type, sound, obj, falloff, volume, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("SoundEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}