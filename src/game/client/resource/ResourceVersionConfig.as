package game.client.resource
{
	import flash.utils.Dictionary;
	public class ResourceVersionConfig
	{
		public static var urlVersionDic:Dictionary;
		initialize();
		private static function initialize():void
		{
			urlVersionDic=new Dictionary();
			urlVersionDic['assets/ui/BagPanel.swf']=1;
			urlVersionDic['assets/ui/ChatPanel.swf']=1;
			urlVersionDic['assets/ui/FriendPanel.swf']=1;
			urlVersionDic['assets/ui/Loading.swf']=1;
			urlVersionDic['assets/ui/MainMenuPanel.swf']=1;
			urlVersionDic['assets/ui/shared.swf']=1;
			urlVersionDic['assets/ui/SkillPanel.swf']=1;
			urlVersionDic['assets/ui/SystemTip.swf']=1;
			urlVersionDic['assets/ui/view.swf']=1;
		}
	}
}