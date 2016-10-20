package game.client.module.ui.rank.list
{
	import game.client.module.ui.rank.skin.RankDoyenListSkin;
	
	public class RankDoyenList extends RankList
	{
		private static var _instance:RankDoyenList;
		public static function getInstance():RankDoyenList
		{
			if(_instance == null)
				_instance = new RankDoyenList();
			return _instance;
		}
		
		public function RankDoyenList()
		{
			this.skin = RankDoyenListSkin.skin;
		}

		override public function updateSubtype(subtype:int):void
		{
			// TODO Auto Generated method stub
			super.updateSubtype(subtype);
		}
	}
}