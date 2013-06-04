package scenes
{
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	
	public class Menu extends Sprite
	{
		public static const START_GAME:String = "startGame";
		
		public var level:int;
		
		public function Menu()
		{
			init();
		}
		
		private function init():void
		{
			/*var textField:TextField = new TextField(250, 50, "Menu", "impact", BitmapFont.NATIVE_SIZE, 0xffffff);
			textField.x = (Main.stageWidth - textField.width) / 2;
			textField.y = 50;
			this.addChild(textField);*/
			
			var button:Button = new Button(Root.assets.getTexture("button_normal"), "");
			
			button.pivotX = button.width * 0.5;
			button.pivotY = button.height * 0.5;
			
			button.x = Main.stageWidth * 0.5;
			button.y = Main.stageHeight * 0.5;
			
			button.scaleX = Main.scaleFactor;
			button.scaleY = Main.scaleFactor;
			
			button.addEventListener(Event.TRIGGERED, startTriggered);
			this.addChild(button);
		}
		
		private function startTriggered():void
		{
			trace("Menu startTriggered()");
			
			this.level = 0;
			
			this.dispatchEventWith(START_GAME, true, this.level);
		}
	}
}