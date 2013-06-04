package
{
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	import starling.utils.formatString;
	
	[SWF(frameRate="60", backgroundColor="#000")]
	
	public class Main extends Sprite
	{
		public static var stageWidth:int  = 240;
		public static var stageHeight:int = 426;
		public static var monStar:Starling;
		
		[Embed(source="/textures/1x/BG480.png")]
		private static var BGx1:Class;
		
		[Embed(source="/textures/2x/BG800.png")]
		private static var BGx2:Class;
		
		[Embed(source="/textures/3x/BG1024.png")]
		private static var BGx3:Class;
		
		[Embed(source="/textures/4x/BG1280.png")]
		private static var BGx4:Class;
		
		[Embed(source="/textures/5x/BG2048.png")]
		private static var BGXHD:Class;
		
		public static var scaleFactor:int;
		public static var stageRef:Stage;
		public static var viewPort:Rectangle;
		
		private var stageWidth:int;
		private var stageHeight:int;
		private var background:Bitmap;
		private var assets:AssetManager;
		private var appDir:File;
		
		public function Main()
		{
			var iOS:Boolean 	 = Capabilities.manufacturer.indexOf("iOS") != -1;
			var AND:Boolean 	 = Capabilities.manufacturer.indexOf("Android") != -1;
			
			Main.stageRef 				= stage;
			Main.stageRef.align 		= StageAlign.TOP_LEFT;
			Main.stageRef.scaleMode 	= StageScaleMode.NO_SCALE;
			
			Starling.multitouchEnabled = true;
			Starling.handleLostContext = !iOS;
			
			if (iOS == true) this.getScaleFactor("iOS");
			if (AND == true) this.getScaleFactor("Android");
				
			else this.getScaleFactor("default");
			
			//Main.stageWidth 	= this.stageWidth;
			//Main.stageHeight 	= this.stageHeight;
			
			Main.viewPort = RectangleUtil.fit(
				new Rectangle(0, 0, this.stageWidth, this.stageHeight), 
				new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight), 
				ScaleMode.NO_BORDER);
			
			this.appDir		= File.applicationDirectory;
			this.assets 	= new AssetManager(Main.scaleFactor);
			
			this.assets.enqueue(
				appDir.resolvePath("audio"),
				appDir.resolvePath(formatString("fonts/{0}x", scaleFactor)),
				appDir.resolvePath(formatString("textures/{0}x", scaleFactor))
			);
			
			this.background.x 			= Main.viewPort.x;
			this.background.y 			= Main.viewPort.y;
			this.background.width  		= Main.viewPort.width;
			this.background.height 		= Main.viewPort.height;
			this.background.smoothing 	= true;
			
			this.addChild(this.background);
			
			trace("**********************************************************");
			trace("MONSTER DODGEBALL 		v 1.0.0");
			trace("viewPort:			" + Main.viewPort);
			trace("Main.stageWidth:		" + Main.stageWidth);
			trace("Main.stageHeight:		" + Main.stageHeight);
			trace("scaleFactor: 			" + Main.scaleFactor);
			trace("Capabilities.screenDPI: 	" + Capabilities.screenDPI);
			trace("Capabilities.os: "	+ Capabilities.os);
			trace("Capabilities.screenResolutionX: " + Capabilities.screenResolutionX);
			trace("Capabilities.screenResolutionY: " + Capabilities.screenResolutionY);
			trace("**********************************************************");
			
			Main.monStar 						= new Starling(Root, stage, Main.viewPort);
			Main.monStar.stage.stageWidth  		= this.stageWidth;
			Main.monStar.stage.stageHeight 		= this.stageHeight;
			Main.monStar.simulateMultitouch  	= false;
			Main.monStar.enableErrorChecking 	= Capabilities.isDebugger;
			
			Main.monStar.addEventListener(starling.events.Event.ROOT_CREATED, rootCreated); 
		}
		
		private function getScaleFactor(OS:String):int
		{
			var perfectScale:Number =  (stage.fullScreenWidth / this.stageWidth);
			trace("perfectScale: " + perfectScale);
			
			switch (OS) {
				
				case "iOS":
					trace("iOS");
					if (stage.fullScreenHeight <= 480) Main.scaleFactor = 1; background = new BGx1();
					if (stage.fullScreenHeight > 480 && stage.fullScreenHeight <= 960) Main.scaleFactor = 2; this.background = new BGx2();
					if (stage.fullScreenHeight > 960 && stage.fullScreenHeight < 1024) Main.scaleFactor = 3; this.background = new BGx3();
					if (stage.fullScreenHeight >= 1024 && stage.fullScreenHeight < 2056) Main.scaleFactor = 4; this.background = new BGx4();
					if (stage.fullScreenHeight >= 2056) Main.scaleFactor = 5; this.background = new BGXHD();
					break;
				case "Android":
					trace("Android");
					if (stage.fullScreenHeight <= 480) Main.scaleFactor = 1; background = new BGx1();
					if (stage.fullScreenHeight > 480 && stage.fullScreenHeight <= 800) Main.scaleFactor = 2; this.background = new BGx2();
					if (stage.fullScreenHeight > 800 && stage.fullScreenHeight <= 1024) Main.scaleFactor = 3; this.background = new BGx3();
					if (stage.fullScreenHeight > 1024 && stage.fullScreenHeight <= 1280) Main.scaleFactor = 3; this.background = new BGx4();
					break;
				default:
					trace("default");
					if (stage.fullScreenHeight <= 480) Main.scaleFactor = 1; background = new BGx1();
					if (stage.fullScreenHeight > 480 && stage.fullScreenHeight <= 800) Main.scaleFactor = 2; this.background = new BGx2();
					if (stage.fullScreenHeight > 800 && stage.fullScreenHeight <= 1024) Main.scaleFactor = 3; this.background = new BGx3();
					if (stage.fullScreenHeight > 1024 && stage.fullScreenHeight <= 1280) Main.scaleFactor = 3; this.background = new BGx4();
					break;
			}
			
			this.stageWidth   = stage.fullScreenWidth/* / Main.scaleFactor*/;
			this.stageHeight  = stage.fullScreenHeight/* / Main.scaleFactor*/;
			
			Main.stageWidth = this.stageWidth/* * Main.scaleFactor*/;
			Main.stageHeight = this.stageHeight/* * Main.scaleFactor*/;
			
			trace("Main.scaleFactor: " + Main.scaleFactor);
			trace("Main.stageWidth: " + Main.stageWidth);
			trace("Main.stageHeight: " + Main.stageHeight);
			
			return Main.scaleFactor;
		}
		
		private function rootCreated(event:Object, app:Root):void
		{
			Main.monStar.removeEventListener(starling.events.Event.ROOT_CREATED, rootCreated);
			this.removeChild(this.background);
			
			var bgTexture:Texture = Texture.fromBitmap(this.background, false, false, Main.scaleFactor);
			var backGroundImage:Image = new Image(bgTexture);
			
			backGroundImage.width 	= Main.monStar.stage.stageWidth;
			backGroundImage.height 	= Main.monStar.stage.stageHeight;
			
			app.start(backGroundImage, this.assets);
			Main.monStar.start();
			
			Starling.current.showStats = true;
			Starling.current.showStatsAt("right", "bottom");
		}
	}
}