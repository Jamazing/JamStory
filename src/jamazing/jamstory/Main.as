//	Copyright 2012 Jamazing Games©
//	Author: Gordon Mckendrick
//
//	Main class for the JamStory game

package jamazing.jamstory
{
	import flash.display.Sprite;
	import flash.events.Event;
	import jamazing.jamstory.entity.Player;
	import jamazing.jamstory.util.Keys;
	import jamazing.jamstory.world.World;
	import jamazing.jamstory.object.BaseObject;
	import jamazing.jamstory.object.LevelTransition;
	import jamazing.jamstory.object.Platform;
	import jamazing.jamstory.util.Physics;
	
	
	public class Main extends Sprite 
	{
		private var player:Player;
		private var platforms:Array;
		private var bouncyJelly:Platform;
		private var slippyJelly:Platform;
		private var stickyJelly:Platform;
		
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, onTick);
			
			
			player = new Player();
			platforms = new Array();
			bouncyJelly = new Platform(100, stage.stageHeight - 55, 50, 10, 0xDD3300);
			slippyJelly = new Platform(350, stage.stageHeight - 55, 200, 10, 0xFFAA00);
			stickyJelly = new Platform(250, stage.stageHeight -200, 50, 50, 0xAA3300);
			
			var keys:Keys = new Keys(stage);
			
			//	Spawn platforms
			//		Spawn the ground platform
			var platform:Platform = new Platform(stage.stageWidth / 2, stage.stageHeight - 25, stage.stageWidth, 50);
			platforms.push(platform);
			addChild(platform);
			
			//		Spawn random platforms for fun
			for (var i:int = 0; i < 5; i++) {
				var width:int = (Math.random() * 40) + 50;
				var height:int = 30
				platform = new Platform(Math.random() * stage.stageWidth, Math.random() * stage.stageHeight/2 + stage.stageHeight/4, width, height);
				platforms.push(platform);
				addChild(platform);
			}
			
			
			
			addChild(bouncyJelly);
			addChild(slippyJelly);
			addChild(stickyJelly);
			addChild(player);
		}
		
		private function onTick(e:Event):void
		{
			//	Collision detection
			var collided:Boolean = false;
			for (var i:int = 0; i < platforms.length; i++) {
				if (player.hitTestObject(platforms[i])) {
					player.yForce = player.ySpeed  * - 15;
					player.jumping = false;
					collided = true;
				}
			}
			
			if (player.hitTestObject(bouncyJelly)) {
				player.bounce();
			}
			
			if (player.hitTestObject(slippyJelly)) {
				player.friction = 1;
			}else {
				player.friction = 2;
			}
			
			if (player.hitTestObject(stickyJelly)) {
				player.stuck = true;
				collided = true;
				player.ySpeed *= 0.5;
				player.ySpeed += 0.4;
			}else {
				player.stuck = false;
			}
			
			if (!collided) {
				player.yForce += Physics.GRAVITY * player.mass;
			}

			
			if ((player.x + player.xSpeed) < 0) {
				player.xForce = player.xSpeed * -15;
			}
			if ((player.x + player.xSpeed) > stage.stageWidth) {
				player.xForce = player.xSpeed * -15;
			}
			
		}
		
	}
	
}