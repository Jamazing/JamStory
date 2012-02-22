package jamazing.jamstory.entity 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import jamazing.jamstory.object.Collidable.Collidable;
	import jamazing.jamstory.util.Keys;
	import jamazing.jamstory.events.WorldEvent;
	
	public class TestPlayer extends Sprite
	{
		public var xSpeed:Number;
		public var ySpeed:Number;
		public var xAccel:Number;
		public var yAccel:Number;
		public var moving:Boolean;
		public var jumping:Boolean;
		
		public var collidable:Collidable;
		
		//	Constructor: default
		public function TestPlayer() 
		{
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	Function: onInit
		//	Initialises the object once added to the stage
		private function onInit(e:Event = null):void
		{
			x = 0;
			y = 220;
			//	Memory Allocation
			collidable = new Collidable(x, y, 30);

			//	Variable Initialisation
			xSpeed = 0;
			ySpeed = 0;
			xAccel = 0;
			yAccel = 0;
			moving = false;
			jumping = false;
			
			//	Graphics initialisation
			graphics.beginFill(0xFF6600);
			graphics.drawCircle(0, 0, 30);
			graphics.endFill();
			
			//	Event listeners
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(Event.ENTER_FRAME, onTick);
			stage.addEventListener(WorldEvent.STATIC_COLLIDE, onCollide);
		}
		
		private function onCollide(e:WorldEvent):void
		{
			trace("Collision");
		}
		
		//	Function: onTick
		//	Updates the movement each frame
		private function onTick(e:Event):void
		{
			if (Keys.isDown(Keys.D)) {
				xSpeed = 10;
			}else if (Keys.isDown(Keys.A)) {
				xSpeed = -10;
			}else {
				xSpeed *= 0.8;
			}
			if (Math.abs(xSpeed) < 1) {
				xSpeed = 0;
			}
			
			if (Keys.isDown(Keys.S)) {
				ySpeed = 10;
			}else if (Keys.isDown(Keys.W)) {
				ySpeed = -10;
			}else {
				ySpeed *= 0.8;
			}
			if (Math.abs(ySpeed) < 1) {
				ySpeed = 0;
			}
			
			//	Update speed and position
			xSpeed += xAccel;
			ySpeed += yAccel;
			x += xSpeed;
			y += ySpeed;

			//	Keep the collidable object at the player location
			collidable.x = x;
			collidable.y = y;
		}
		
	}

}