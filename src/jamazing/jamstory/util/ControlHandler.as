package jamazing.jamstory.util 
{
	import flash.display.Stage;
	import flash.events.Event;
	import jamazing.util.Keys;
	import jamazing.events.ControlEvent;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ControlHandler 
	{
		private static var MoveLeft:uint= Keys.A;
		private static var MoveRight:uint= Keys.D;
		private static var Jump:uint= Keys.W;
		private static var Pause:uint= Keys.P;
		private static var Throw:uint= Keys.R;
		private static var Restart:uint= Keys.Q; 
		
		
		private static var StageRef:Stage;

		private function onTick(e:Event) 
		{
			if (Keys.isDown(MoveLeft))  StageRef.dispatchEvent(new ControlEvent(ControlEvent.MOVELEFT)); 
			if (Keys.isDown(MoveRight)) StageRef.dispatchEvent(new ControlEvent(ControlEvent.MOVERIGHT));
			if (Keys.isDown(Jump))StageRef.dispatchEvent(new ControlEvent(ControlEvent.JUMP));
			if (Keys.isDown(Pause)) StageRef.dispatchEvent(new ControlEvent(ControlEvent.PAUSE));
			if (Keys.isDown(Throw)) StageRef.dispatchEvent(new ControlEvent(ControlEvent.THROW));
		if (Keys.isDown(Restart)) StageRef.dispatchEvent(new ControlEvent(ControlEvent.RESTART));
			
			
			
			
		}
		
		public function ControlHandler(stage:Stage) 
		{
			StageRef = stage;
			stage.addEventListener(Event.ENTER_FRAME, onTick);
			
		}
		
	}

}