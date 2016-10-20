package game.client.manager
{
	
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	
	import game.client.net.ServerConfig;
	import game.core.utils.MassLoader;
	import game.core.utils.Timer;
	
	/**
	 * 舞台管理 
	 * @author Administrator
	 * 
	 */	
	public class StageManager
	{
		public static var stage:Stage;
		public static var stageText:TextField;
		
		public static function init(_stage:Stage, urlVersionDic:Dictionary):void
		{
			
			stageText = new TextField();
			stageText.defaultTextFormat = new TextFormat("_sans", 14, 0xFFFFFF);
			stageText.wordWrap = stageText.multiline = true;
			stageText.width = 1000;
			stageText.height = 800;
			_stage.addChild(stageText);
			stage = _stage;
			stage.frameRate = 30;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.addEventListener(Event.RESIZE, resize);
			stage.addEventListener(Event.ENTER_FRAME, Timer.run);
			
			MassLoader.init(ServerConfig.resourceHost, urlVersionDic);
		}
		
		private static function resize(... args):void
		{
			
		}
	}
}
