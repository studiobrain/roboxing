package
{
	import physics.GameSpace;
	
	import scenes.Menu;
	import scenes.Scene;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	import utils.ProgressBar;
	
	
	public class Root extends Sprite
	{
		private var activeScene:Sprite;
		
		private static var starAssets:AssetManager;
		
		public function Root()
		{
			this.addEventListener(Menu.START_GAME, startScene);
			this.addEventListener(Scene.RETURN_MENU,  resetGame);
		}
		
		public function start(background:Image, assets:AssetManager):void
		{
			trace("Root start()")
			
			Root.starAssets = assets;
			
			this.addChild(background);
			
			trace("background.width: " + background.width);
			
			var progressBar:ProgressBar = new ProgressBar(175, 20);
			progressBar.x = (Main.stageWidth * 0.5) - (progressBar.width * 0.5);
			progressBar.y = (Main.stageHeight * 0.5) - (progressBar.height * 0.5);
			addChild(progressBar);
			
			assets.loadQueue(function onProgress(ratio:Number):void
			{
				progressBar.ratio = ratio;
				
				if (ratio == 1)
					
					Starling.juggler.delayCall(function():void
					{
						progressBar.removeFromParent(true);
						showMenu(Menu);
						
					}, 0.15);
			});
		}
		
		private function resetGame(event:Event):void
		{
			trace("Root resetGame()");
			showMenu(Menu);
		}
		
		private function startScene(event:Event, level:int):void
		{
			trace("Root startScene() LEVEL: " + level);
			showScene(0);
		}
		
		private function showMenu(screen:Class):void
		{
			if (this.activeScene) this.activeScene.removeFromParent(true);
			this.activeScene = new screen();
			this.addChild(this.activeScene);
		}
		
		private function showScene(level:int):void
		{
			if (activeScene) activeScene.removeFromParent(true);
			this.activeScene = new Scene(level);
			this.addChild(activeScene);
		}
		
		public static function get assets():AssetManager 
		{ 
			return Root.starAssets;
		}
	}
}