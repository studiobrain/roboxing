package bots
{
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class Frenchie extends Sprite
	{
		private var idle:MovieClip;
		private var jab:MovieClip;
		private var combo:MovieClip;
		private var animationState:int;
		private var dictionary:Dictionary = new Dictionary();
		private var autoTime:Timer = new Timer(this.randNum(1000, 3000), 0);
		
		public static const IDLE:int 	= 0;
		public static const JAB:int 	= 1;
		public static const COMBO:int 	= 2;
		
		public function Frenchie()
		{
			this.buildOutBot();
			this.addAnimStates();
			this.setAutoBot();
		}
		
		private function buildOutBot():void
		{
			var idleFrames:Vector.<Texture> = Root.assets.getTextures("idle/");
			
			this.idle 			= new MovieClip(idleFrames, 15);
			this.idle.loop 		= true;
			this.idle.pivotX	= this.idle.width * 0.5;
			this.idle.pivotY	= this.idle.height * 0.5;
			this.idle.x 		= 0;
			this.idle.y 		= 50;
			this.idle.scaleX	= Main.scaleFactor * 1.5;
			this.idle.scaleY	= Main.scaleFactor * 1.5;
			
			var jabFrames:Vector.<Texture> = Root.assets.getTextures("jabLeft/");
			
			this.jab 			= new MovieClip(jabFrames, 25);
			this.jab.loop 		= false;
			this.jab.pivotX		= this.jab.width * 0.5;
			this.jab.pivotY		= this.jab.height * 0.5;
			this.jab.x 			= 0;
			this.jab.y 			= 50;
			this.jab.scaleX		= Main.scaleFactor * 1.5;
			this.jab.scaleY		= Main.scaleFactor * 1.5;
			
			this.jab.addEventListener(Event.COMPLETE, resetBot);
			
			var comboFrames:Vector.<Texture> = Root.assets.getTextures("combo/");
			
			this.combo 			= new MovieClip(comboFrames, 25);
			this.combo.loop 	= false;
			this.combo.pivotX	= this.combo.width * 0.5;
			this.combo.pivotY	= this.combo.height * 0.5;
			this.combo.x 		= 0;
			this.combo.y 		= 50;
			this.combo.scaleX	= Main.scaleFactor * 1.5;
			this.combo.scaleY	= Main.scaleFactor * 1.5;
			
			this.combo.addEventListener(Event.COMPLETE, resetBot);
			
			this.animationState = IDLE;
			this.addChild(this.idle);
			
			Starling.juggler.add(this.idle);
		}
		
		private function resetBot(event:Event):void
		{
			this.animate(0);
		}
		
		private function addAnimStates():void
		{
			this.dictionary[IDLE] 		= this.idle;
			this.dictionary[JAB] 		= this.jab;
			this.dictionary[COMBO] 		= this.combo;
		}
		
		public function animate(animationState:int):void
		{
			this.removeChild(this.dictionary[this.animationState]);
			Starling.juggler.remove(this.dictionary[this.animationState]);
			
			this.dictionary[this.animationState].stop();
			this.animationState = animationState;
			
			this.addChild(this.dictionary[this.animationState]);
			Starling.juggler.add(this.dictionary[this.animationState]);
			this.dictionary[this.animationState].play();
		}
		
		private function setAutoBot():void
		{
			this.autoTime.addEventListener(TimerEvent.TIMER, punch);
			this.autoTime.start();
		}
		
		private function randNum(min:Number, max:Number):Number
		{
			return Math.floor((Math.random() * max) + min);
		}
		
		private function punch(event:TimerEvent):void
		{
			this.animate(this.randNum(1, 2));
		}
	}
}