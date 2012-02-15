package jamazing.jamstory.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author John A Robb
	 */
	public class ControlEvent extends Event 
	{
		public static const MOVELEFT:String= "MOVELEFT";
		public static const MOVERIGHT:String= "MOVERIGHT";
		public static const JUMP:String= "JUMP";
		public static const PAUSE:String= "PAUSE";
		public static const RESTART:String= "RESTART";
		public static const THROW:String= "THROW";
		
		
		public function ControlEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
			
			
		} 
	}
	
}