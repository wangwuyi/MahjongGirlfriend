package game.client.facade
{
	import game.client.manager.SingletonFactory;
	import game.client.module.ui.chat.ChatPanel;
	import game.client.module.ui.mainMenu.MainMenuPanel;
	import game.client.module.ui.systemtip.SystemTip;
	import game.core.manager.SoundManager;

	public class SceneFacade
	{
		
		public static function getInstance():SceneFacade
		{
			return SingletonFactory.createObject(SceneFacade);
		}
		
		public function enterScene():void
		{
			SoundManager.play("min", 22);
			showSceneUI();
		}
		
		private function showSceneUI():void
		{
			ChatPanel.getInstance().visible = true;
			MainMenuPanel.instance.visible = true;
			SystemTip.instance().visible = true;
		}
		
	}
}