package jamazing.jamstory.entity 
{
	import flash.events.Event;
	import jamazing.jamstory.engine.Resource;
	import jamazing.jamstory.events.PlayerEvent;
	
	public class Enemy extends Dynamic 
	{
		private const JUMP_HEIGHT:Number = 12;	// Maximum jump height in pixels
		private const MOVE_SPEED:Number = 12;	// Speed
		
		/* These hold the current heading and the future heading of the character */
		private var currentHeadingX:Number;
		private var futureHeadingX:Number;
		/* Future NOTE: There was an idea for this to actualy be a queue for more complex situations */
		
		//	This is used when checking if is stuck
		private var collisionCount:int;

		//	This controls whether the character is jumping
		private var isJumping:Boolean;
		
		//	Constructor;
		public function Enemy() 
		{
			super();
			if (stage)
			{
				onInit();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, onInit);
			}
		}
		
		//	onInit
		private function onInit(e:Event = null)
		{
			/* BUG: Creates two enemies for some reason - investigate why */
			trace("Enemy created");
			
			isJumping = false;
			
			/* TODO: This should be refined to go to dynamic? */
			bitmap = new Resource.CHARACTER_IMAGE();
			bitmap.width = 75;
			bitmap.height = 75;
			addChild(bitmap);
			bitmap.x = -bitmap.width/2;		//	Ensure registration point is in the center
			bitmap.y = -bitmap.height / 2;
			/* Till here */


			
			addEventListener(Event.ENTER_FRAME, onTick);
			addEventListener(PlayerEvent.COLLIDE, onCollide);
		}
		
		//	onTick
		//	Updates object on every frame
		private function onTick(e:Event)
		{
			// if it's the n-th tick - jump
			
			if (!isJumping)
			{
				if (this.x - currentHeadingX < 1)// if we are close to the destination
				{
					/* Swap the headings */
					var temporaryVariable = currentHeadingX;
					currentHeadingX = futureHeadingX;
					futureHeadingX = temporaryVariable;
					/* Till here */
					
					//Set new xSpeed
					xSpeed = Math.abs(xSpeed) * direction;
				}
			}

			// if (5th frame && colCount>0: colCount--)
			
		}
		
		// Controls collisions
		private function onCollide(e:PlayerEvent)
		{
			/* Design:
				 * Check which side it colides with:
					 * Top <-> ySpeed := 0
					 * Bottom <-> ySpeed *= -1
					 * Sides: swapDestinations
			*/
			
			trace("Collide - "+e.toString());
		}
		
		// This returns the direction, based on current location and future destination
		private function get direction():int 
		{
			// If current heading is to the left of current location, return -1, else return 1
			return currentHeadingX < x ? -1 : 1;
		}

		
	}

}