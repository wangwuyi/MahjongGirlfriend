package game.client.module.ui.rank.list
{
	import game.client.module.ui.rank.skin.RankOverlordListSkin;
	
	public class RankOverlordList extends RankList
	{
		private static var _instance:RankOverlordList;
		public static function getInstance():RankOverlordList
		{
			if(_instance == null)
				_instance = new RankOverlordList();
			return _instance;
		}
		
		public function RankOverlordList()
		{
			this.skin = RankOverlordListSkin.skin;
		}
		
		override public function updateSubtype(subtype:int):void
		{
			// TODO Auto Generated method stub
			super.updateSubtype(subtype);
		}
	}
}