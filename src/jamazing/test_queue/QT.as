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
			var qTest:Queue = new Queue(5);
			
			for (var index:int = 0; index < 10; index++)
				qTest.Enque(index);
			
			while(qTest.size!=0)
				trace(qTest.Deque());
			
			
		}
		
	}

}