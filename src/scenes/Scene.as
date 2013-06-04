package scenes
{
	import UI.CrossHairs;
	import UI.JoyStick;
	
	import bots.Frenchie;
	
	import game.Bullet;
	import game.Monster;
	
	import physics.GameSpace;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class Scene extends Sprite
	{
		public static const RETURN_MENU:String = "return to menu";
		public static const SHOOT:String = "shoot";
		
		private var frenchie:Frenchie;
		
		public function Scene(level:int)
		{
			super();
			
			trace("Scene level: " + level);
			this.addBG();
			this.addOppBot();
			this.addReset();
			
		}
		
		private function addBG():void
		{
			/*var bg:Image = new Image(Root.assets.getTexture("bg"));
			this.addChild(bg);*/
		}
		
		private function addReset():void
		{
			var button:Button = new Button(Root.assets.getTexture("button_normal"), "");
			
			button.scaleX = Main.scaleFactor;
			button.scaleY = Main.scaleFactor;
			
			button.pivotX = button.width * 0.5;
			button.pivotY = button.height * 0.5;
			
			button.x = button.width + 100;//(Main.stageWidth * 0.5) + (button.width * 0.5);
			button.y = Main.stageHeight - 50;
			
			button.addEventListener(Event.TRIGGERED, returnToMenu);
			this.addChild(button);
		} 
		
		private function addOppBot():void
		{
			this.frenchie = new Frenchie();
			this.frenchie.x = Main.stageWidth * 0.5;
			this.frenchie.y = Main.stageHeight * 0.5;
			this.addChild(this.frenchie);
		}
		
		private function returnToMenu():void
		{
			trace("Scene returnToMenu()");
			this.dispatchEventWith(RETURN_MENU, true, 100);
		}
	}
}