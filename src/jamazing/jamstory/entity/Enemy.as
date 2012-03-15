package jamazing.jamstory.entity 
{
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import jamazing.jamstory.engine.Resource;
	import jamazing.jamstory.events.JamStoryEvent;
	import jamazing.jamstory.events.PlayerEvent;
	
	public class Enemy extends Living 
	{
		private const JUMP_HEIGHT:Number = -12;	// Maximum jump height in pixels
		private const MOVE_SPEED:Number = 12;	// Speed
		
		private var jumpHeightOffset:Number = 0;	/* [Note] This wasn't in the design, but i couldn't really figure out how we are doing this */
		
		/* These hold the current heading and the future heading of the character */
		private var currentHeadingX:Number;
		private var futureHeadingX:Number;
		/* Future NOTE: There was an idea for this to actualy be a queue for more complex situations */
		
		//	This is used when checking if is stuck
		private var collisionCount:int;

		/* Probably should be reimplemented in a different way; Wasn't in the original design! This goes along with extra kill() */
		private var isDead:Boolean;

		/*	I couldn't remember how were we supposed to implement the frame counting-related features, so I added this as a temporary solution
		 * -Ivan
		 */
		private var frameCounter:int = 0;
		
		//	Constructor;
		public function Enemy() 
		{
			super();
			
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	onInit
		private function onInit(e:Event = null):void
		{
			/* NOTE: This should go to living? */
			isJumping = false;
			
			/* Only temporary */
			isAlive = true;
			
			/* TODO: This should be refined to go to Dynamic? */
			bitmap = new Resource.CHARACTER_IMAGE();
			bitmap.bitmapData.colorTransform(bitmap.bitmapData.rect, new ColorTransform(0.3, 0.3, 0.3));
			bitmap.width = 75;
			bitmap.height = 75;
			addChild(bitmap);
			bitmap.x = -bitmap.width / 2;		//	Ensure registration point is in the center
			bitmap.y = -bitmap.height / 2;
			/* Till here */
			trueWidth = 60;
			trueHeight = 60;
			hitbox = new Collidable(x, y, trueWidth/2);			
			
			yAccel = 1;
			xAccel = 0;
			ySpeed = 0;
			xSpeed = 1;
			isMoving = true;
			
			moveSpeed = 2;
			
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			stage.addEventListener(JamStoryEvent.TICK_MAIN, onTick);
			addEventListener(PlayerEvent.COLLIDE, onCollide);
		}
		
		//	onTick
		//	Updates object on every frame
		private function onTick(e:JamStoryEvent):void
		{
			if (!isAlive) return;
			xSpeed = moveSpeed;
			if (!isSlippy)
			{
				var test:int = this.x - currentHeadingX;
				if (Math.abs(test) < 5)// if we are at the destination
				{
					/* Swap the headings */
					var temporaryVariable:* = currentHeadingX;
					currentHeadingX = futureHeadingX;
					futureHeadingX = temporaryVariable;
					
					//Set new xSpeed
					moveSpeed *= -1;
				}
			}else {
				if (Math.random() > 0.5) stickyEscape++;
			}
			
			// if (5th frame && colCount>0: colCount--)
			
		}
		
		public function onCollide(e:PlayerEvent):void
		{
			var c:BoxCollidable = e.collidable as BoxCollidable;
			if (e.side == Collidable.SIDE_TOP) {
				ySpeed = 0;
				y = (c.y - c.height / 2) - trueHeight/2;
				isJumping = false;
				
			}else if (e.side == Collidable.SIDE_LEFT) {
				xSpeed = 0;
				x = (c.x - c.width / 2) - trueWidth / 2;
				isSlippy = false;
				
			}else if (e.side == Collidable.SIDE_BOTTOM) {
				ySpeed *= -1;
				y = (c.y + c.height / 2) + trueHeight/2;
				
			}else if (e.side == Collidable.SIDE_RIGHT) {
				xSpeed = 0;
				x = (c.x + c.width / 2) + trueWidth / 2;
				isSlippy = false;
			}
			
			
		}	
		
		private function get newYSpeed():Number
		{
			return Math.sqrt(2 * 1 * jumpHeightOffset);
		}
		
		// This returns the direction, based on current location and future destination
		private function get direction():int 
		{
			// If current heading is to the left of current location, return -1, else return 1
			return currentHeadingX < x ? -1 : 1;
		}		
		
		/* This wasn't in the design, but is here until we implement a proper die logic */
		override public function kill():void 
		{
			bitmap.visible = false;
			isDead = true;

			super.kill();
		}

		/*	This wasn't in the design, but again - until we implement proper die logic */
		// 	This is a getter, instead of making isDead public to preserve encapsulation!
		public function get IsDead():Boolean
		{
			return isDead;
		}
				
		public function setDirections(x1:Number, x2:Number):void
		{
			futureHeadingX = x2;
			currentHeadingX = x1;
		}
	}

}