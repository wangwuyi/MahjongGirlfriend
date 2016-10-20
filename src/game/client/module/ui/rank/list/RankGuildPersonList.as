package game.client.module.ui.rank.list
{
	import game.client.module.ui.rank.skin.RankGuildPersonListSkin;

	public class RankGuildPersonList extends RankList
	{
		private static var _instance:RankGuildPersonList;
		public static function getInstance():RankGuildPersonList
		{
			if(_instance == null)
				_instance = new RankGuildPersonList();
			return _instance;
		}
		
		public function RankGuildPersonList()
		{
			this.skin = RankGuildPersonListSkin.skin;
		}
		
		override public function updateSubtype(subtype:int):void
		{
		}
	}
}