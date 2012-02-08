//	Copyright 2012 Jamazing Games©
//	Author: Ivan Mateev
//	Contrib:
//	

package jamazing.jamstory.object 
{
	public class LevelTransition extends BaseObject 
	{
		private var isExit:Boolean;
		
		public function LevelTransition(isExitInput:Boolean = false) 
		{
			super();
			isExit = isExitInput;
			createNonAbstractObject();
		}
		
	}

}