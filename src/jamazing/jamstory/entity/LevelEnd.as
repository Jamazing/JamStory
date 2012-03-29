package jamazing.jamstory.entity 
{
	import flash.events.Event;
	import jamazing.jamstory.events.JamStoryEvent;

	//	Ends the level when it is hit
	public class LevelEnd extends Collectable
	{
		
		public function LevelEnd(x:Number, y:Number ) 
		{
			super(x, y);
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(e:Event = null):void
		{
		}
		
		public function onCollide():void
		{
			stage.dispatchEvent(new JamStoryEvent(JamStoryEvent.LEVEL_END, 0));
		}
	}

}