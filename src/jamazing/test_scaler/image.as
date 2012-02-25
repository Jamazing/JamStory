package jamazing.test_scaler 
{
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	//	Class: image
	public class image extends Sprite
	{
		[Embed(source = "../../../resources/jamjar.png")]
		private var picture:Class;
	
		public var img:Sprite;
		public var bitm:Bitmap;
		public var handle_topLeft:Sprite;
		public var handle_topRight:Sprite;
		public var handle_botLeft:Sprite;
		public var handle_botRight:Sprite;
		public var backing:Shape;
		
		public var xDown:Number;
		public var yDown:Number;
		
		public var xmoving:Boolean;
		public var xscaling:Boolean;
		public var ymoving:Boolean;
		public var yscaling:Boolean;
		public var currentWidth:Number;
		public var currentHeight:Number;
		
		//	Class: image
		public function image() 
		{
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		public function onInit(e:Event = null):void
		{
			xmoving = false;
			xscaling = false;
			ymoving = false;
			yscaling = false;
			currentWidth = 150;
			currentHeight = 150;
			img = new Sprite();
			
			addChild(img);
			bitm = new picture();
			img.addChild(bitm);
			img.width = 150;
			img.height = 150;
			img.x = -75;
			img.y = -75;
			
			handle_topLeft = new Sprite();
			handle_topLeft.graphics.beginFill(0xFF6600);
			handle_topLeft.graphics.drawRect(0, 0, 10, 10);
			handle_topLeft.graphics.endFill();
			handle_topLeft.x = -75;
			handle_topLeft.y = -75;
			addChild(handle_topLeft);
			
			handle_topRight = new Sprite();
			handle_topRight.graphics.beginFill(0xFF6600);
			handle_topRight.graphics.drawRect(-10, 0, 10, 10);
			handle_topRight.graphics.endFill();
			handle_topRight.x = img.width - 75;
			handle_topRight.y = -75;
			addChild(handle_topRight);
			
			handle_botLeft = new Sprite();
			handle_botLeft.graphics.beginFill(0xFF6600);
			handle_botLeft.graphics.drawRect(0, -10, 10, 10);
			handle_botLeft.graphics.endFill();
			handle_botLeft.x = -75;
			handle_botLeft.y = img.height -75 ;
			addChild(handle_botLeft);
			
			handle_botRight = new Sprite();
			handle_botRight.graphics.beginFill(0xFF6600);
			handle_botRight.graphics.drawRect(-10, -10, 10, 10);
			handle_botRight.graphics.endFill();
			handle_botRight.x = img.width-75;
			handle_botRight.y = img.height-75;
			addChild(handle_botRight);
			
			x = 200;
			y = 200;
			
			handle_topLeft.visible = false;
			handle_topRight.visible = false;
			handle_botLeft.visible = false;
			handle_botRight.visible = false;
			
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(Event.ENTER_FRAME, onTick);
			
			handle_botRight.addEventListener(MouseEvent.MOUSE_DOWN, rightDown);
			handle_botLeft.addEventListener(MouseEvent.MOUSE_DOWN, rightDown);
			
			img.addEventListener(MouseEvent.MOUSE_DOWN, irightDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, rightUp);
			addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			addEventListener(MouseEvent.ROLL_OUT, onRollOut);
		}
		
		public function irightDown(e:MouseEvent):void
		{
			trace("idown");
			xDown = e.stageX;
			yDown = e.stageY;
			if (e.shiftKey) {
				xmoving = true;
			}else {
				xmoving = true;
				ymoving = true;
			}
			
		}
		
		public function rightDown(e:MouseEvent):void
		{
			xDown = e.stageX;
			yDown = e.stageY;
			if (e.shiftKey) {
				xscaling = true;
			}else {
				xscaling = true;
				yscaling = true;
			}
		}
		
		public function rightUp(e:MouseEvent):void
		{
			xDown = e.stageX;
			yDown = e.stageY;
			currentWidth = img.width;
			currentHeight = img.height;
			xscaling = false;
			xmoving = false;
			yscaling = false;
			ymoving = false;
		}
		
		private function onRollOver(e:MouseEvent):void
		{
			
			handle_topLeft.visible = true;
			handle_topRight.visible = true;
			handle_botLeft.visible = true;
			handle_botRight.visible = true;
		}
		
		private function onRollOut(e:MouseEvent):void
		{
			handle_topLeft.visible = false;
			handle_topRight.visible = false;
			handle_botLeft.visible = false;
			handle_botRight.visible = false;
		}
		
		public function onTick(e:Event):void
		{
			if (xscaling) {
				img.width = currentWidth + stage.mouseX - xDown;
				handle_topRight.x = img.width-75;
				handle_botRight.x = img.width-75;
			}
			if (yscaling) {
				img.height = currentHeight + stage.mouseY - yDown;
				handle_botLeft.y = img.height-75;
				handle_botRight.y = img.height-75;
			}
			
			if (xmoving) {
				x += stage.mouseX - xDown;
				xDown = stage.mouseX;
			}
			
			if (ymoving) {
				y += stage.mouseY - yDown;
				yDown = stage.mouseY;
			}
		}
	}

}