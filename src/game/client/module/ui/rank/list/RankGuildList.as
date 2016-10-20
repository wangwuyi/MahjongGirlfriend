package game.client.module.ui.rank.list
{
	import game.client.module.ui.rank.skin.RankGuildListSkin;
	
	public class RankGuildList extends RankList
	{
		private static var _instance:RankGuildList;
		public static function getInstance():RankGuildList
		{
			if(_instance == null)
				_instance = new RankGuildList();
			return _instance;
		}
		
		public function RankGuildList()
		{
			this.skin = RankGuildListSkin.skin;
		}
		
		override public function updateSubtype(subtype:int):void
		{
			switch(subtype)
			{
				case 0:
				case 1:
					this.visible = true;
					RankGuildPersonList.getInstance().visible = false;
					break;
				case 2:
					this.visible = false;
					RankGuildPersonList.getInstance().visible = true;
					break;
			}
		}
	}
}