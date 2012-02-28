//	Copyright 2012 Jamazing Games©
//	Author: Gordon D Mckendrick
//	
//	Living
//		The base class for living enties such as players and enemies
//		Has basic functionality for moving, health etc

package jamazing.jamstory.entity 
{

	//	Class: Living
	public class Living extends Dynamic
	{
		public var isJumping:Boolean;	//	True if it is currently mid-jump
		public var timesJumped:int;		//	The number of times jumped in a row
		public var maxJumps:int;		//	The maximum number of times it can jump before landing
		
		public var canWalk:Boolean;		//	True if it is able to use the move functionality
		public var canFly:Boolean;		//	True if it is able to use the fly functionality
		public var canJump:Boolean;		//	True if it is able to use the jump functionality
		
		//	Constructor: default
		public function Living() 
		{
			super();
		}
		
		//	Function: kill
		//	Kills this living entity, and ensures all behaviour is stopped
		public function kill():void
		{
			
		}
		
		//	Function: spawn
		//	Spawns the living entity back at it's original spawn location
		public function spawn():void
		{
			
		}
		
		//	Function: jump
		//	Makes it jump into the air
		public function jump():void
		{
			
		}
		
		//	Function: move
		//	Moves left or right along the ground
		public function move():void
		{
			
		}
		
		//	Function: fly
		//	Moves up or down in the air
		public function fly():void
		{
			
		}
	}

}