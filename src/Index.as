package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.system.ApplicationDomain;
	import flash.system.Security;
	import flash.text.TextField;
	
	import game.client.live.Live;
	import game.client.manager.StageManager;
	import game.client.map.BaseScene;
	import game.client.model.GlobalModel;
	import game.client.net.GameServer;
	import game.client.net.ServerConfig;
	import game.client.resource.ResourcePath;
	import game.client.resource.ResourceVersionConfig;
	import game.component.Component;
	import game.core.utils.MassLoader;
	import game.core.utils.Utils;
	import game.lang.Lang;
	
	[SWF(backgroundColor="0x0", frameRate="30")]
	public class Index extends Sprite
	{	
		private var videoSprite:Sprite = new Sprite();
		private var gameSprite:Sprite = new Sprite();
		private var initText:TextField=new TextField();
		
		public function Index()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			Component.domain = ApplicationDomain.currentDomain;
			this.tabChildren = false;
//			MonsterDebugger.initialize(this);	//size:30KB
//			stage.addChild(new TheMiner());		//size:319KB
		}
		
		private function init(e:Event):void{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.BEST;
			stage.addEventListener(Event.RESIZE, resizeHandler);
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			removeEventListener(Event.COMPLETE, init);
			initText.text = "初始化...";
			initText.selectable = false;
			initText.textColor = 0xffffff;
			initText.x = (stage.stageWidth - initText.textWidth) / 2;
			initText.y = (stage.stageHeight - initText.textHeight) / 2;
			stage.addChild(initText);
			//控制台输出等级
			Utils.logLevel = Utils.LOG_ALL;
			GlobalModel.stage = stage;
			ServerConfig.init(stage);
			StageManager.init(stage, ResourceVersionConfig.urlVersionDic);
//			KeyboardManager.init(GameKeyBorder);
//			contextMenu=ServerConfig.getContextMenu();
			
			MassLoader.add(ResourcePath.UI + "Loading.swf",loadComplete,null,addProgress,null,null,MassLoader.HIGH,Component.domain);
		}
		
		private function loadComplete(info:Object):void{
			if(initText.parent != null){
				initText.parent.removeChild(initText);
			}
			this.addChild(videoSprite);
			this.addChild(gameSprite);
			gameSprite.addChild(GameLoad.getInstance());
			Lang.progressFun=langProgressFun;
			Lang.finishFun=langFinishFun;
			Lang.loadConfLang(ServerConfig.resourceHost+MassLoader.getResourceUrl("assets/keys.txt?"));
		}
		
		private function addProgress(e:ProgressEvent):void{
			initText.text = "加载主文件..."+int(e.bytesLoaded*100/e.bytesTotal)+"%";
		}
		
		//语言包加载进度
		private function langProgressFun(bytesLoaded:Number,bytesTotal:Number):void{
			GameLoad.getInstance().setItemPercent("LanguageInit...",bytesLoaded,bytesTotal);
			GameLoad.getInstance().setTotalPercent(1, 3);
		}
		
		//语言包加载完毕
		private function langFinishFun():void{
			Lang.finishFun=null;
			loadGameMainSwf();
		}
		
		//加载游戏资源
		private function loadGameMainSwf():void{
			MassLoader.add(ResourcePath.UI + "view.swf",gameMainCompleteFun,null,gameMainProgressFun,null,null,MassLoader.HIGH,Component.domain);
		}
		
		private function gameMainProgressFun(e:ProgressEvent):void{
			GameLoad.getInstance().setItemPercent("加载游戏资源",e.bytesLoaded,e.bytesTotal);
		}
		
		private function gameMainCompleteFun(info:Object):void{
			GameLoad.getInstance().setTotalPercent(2, 3);
			loadSharedSwf()
		}
		
		//加载公共资源
		private function loadSharedSwf():void{
			MassLoader.add(ResourcePath.UI + "shared.swf",sharedCompleteFun,null,sharedProgressFun,null,null,MassLoader.HIGH,Component.domain);
		}
		
		private function sharedProgressFun(e:ProgressEvent):void{
			GameLoad.getInstance().setItemPercent("加载公共UI资源",e.bytesLoaded,e.bytesTotal);
		}
		
		private function sharedCompleteFun(info:Object):void{
			GameLoad.getInstance().setTotalPercent(3, 3);
			gameSprite.addChild(BaseScene.getInstance());
			GameLoad.getInstance().dispose();
			Live.getInstance().show(videoSprite);
			Live.getInstance().connect("rtmp://live.hkstv.hk.lxdns.com/live");
//			Live.getInstance().connect("rtmp://livedown.1198.com/live");
//			SceneFacade.getInstance().enterScene();
			GameServer.getInstance().init();
		}
		
		private function resizeHandler(e:Event):void{
			if(stage.contains(initText)){
				initText.x = (stage.stageWidth - initText.textWidth) / 2;
				initText.y = (stage.stageHeight - initText.textHeight) / 2;
			}
		}
	}
}