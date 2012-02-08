package vanchizzle 
{
	/**
	 * This class describes level start and end locations
	 * @author Ivan
	 */
	internal class LevelTransitionObject extends GenericWorldObject 
	{
		private var isExit:Boolean;
		
		public function LevelTransitionObject(var isExitInput:Boolean = false) 
		{
			super();
			isExit = isExitInput;
			createNonAbstractObject();
		}
		
	}

}