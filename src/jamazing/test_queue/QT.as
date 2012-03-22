package jamazing.test_queue 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author ivan
	 */
	public final class QT extends Sprite
	{
		import jamazing.jamstory.language.Queue;
		
		public function QT() 
		{
			var q:Queue = new Queue();
			
			q.Enque(1);
			q.Enque(2);
			q.Enque(3);
			
			trace(q);
			
			q.Deque();
			q.Enque(1);
			
			trace(q);	
			
			q.Deque();
			trace(q);
			
		}
		
	}

}