package game.client.module.ui.mainMenu
{
	import flash.events.MouseEvent;
	
	import game.client.model.GlobalModel;
	import game.client.module.BasePanel;
	import game.client.module.ui.bag.BagPanel;
	import game.client.module.ui.friend.FriendPanel;
	import game.client.module.ui.mainMenu.skin.MainMenuPanelSkin;
	import game.client.module.ui.skill.SkillPanel;
	import game.client.utils.HashMap;
	import game.component.Component;
	import game.core.utils.FileStorage;
	
	public class MainMenuPanel extends BasePanel
	{
		
		public static var instance:MainMenuPanel = new MainMenuPanel();
		
		private var _menuConfigArray:Array = 
			[
				{butName:"qinggong",	panelName:"qinggong", 		panelFunction:startFight},
				{butName:"qicheng",		panelName:"qicheng", 		panelFunction:putHorse},
				{butName:"jiaose", 		panelName:"FriendPanel", 	guideKey:"jiaose",	panelFunction:FriendPanel.instance.panelEntry},
				{butName:"beibao", 		panelName:"BagPanel", 		guideKey:"beibao",	panelFunction:BagPanel.instance.panelEntry},
				{butName:"jineng", 		panelName:"SkillPanel",		panelFunction:SkillPanel.instance.panelEntry}
			];
		
		private var _mainMenuHashMap:HashMap = new HashMap();//开放功能预留
		
		public function MainMenuPanel()
		{
			this.skin = MainMenuPanelSkin.skin;
			init();
		}
		
		private function init():void{
			for each(var obj:Object in _menuConfigArray)
			{
				var butName:String = obj.butName as String;
				var component:Component = getChildByName(butName) as Component;
				component.addEventListener(MouseEvent.CLICK, obj.panelFunction);
				component.guideKey = obj.guideKey;
				_mainMenuHashMap.put(obj.panelName,component);
			}
		}
		
		private var icon:int=0;
		private function putHorse(e:MouseEvent):void{
			
		}
		
		private function startFight(e:MouseEvent):void{
			//BattleFacade.getInstance().loadFileName();
			FileStorage.isDevMode = false;
			if(FileStorage.isNeedOpenSettingPanel){
				FileStorage.askForStorageSpace();
			}
			/*NightEffect.night = true;
			NightEffect.add(GlobalModel.hero);*/
		}
		
		public override function onResize():void
		{
			x = (GlobalModel.stage.stageWidth - width)/2;
			y = GlobalModel.stage.stageHeight - height;
		}
		
		public function get mainMenuHashMap():HashMap{
			return this._mainMenuHashMap;
		}
	}
}