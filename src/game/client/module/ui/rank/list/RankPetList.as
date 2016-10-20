package game.client.module.ui.rank.list
{
	import game.client.module.ui.rank.skin.RankPetListSkin;
	
	public class RankPetList extends RankList
	{
		private static var _instance:RankPetList;
		public static function getInstance():RankPetList
		{
			if(_instance == null)
				_instance = new RankPetList();
			return _instance;
		}
		
		public function RankPetList()
		{
			this.skin = RankPetListSkin.skin;
		}
		
		override public function updateSubtype(subtype:int):void
		{
			switch(subtype)
			{
				case 0:
				case 1:
				case 2:
				case 3:
					this.visible = true;
					RankPetRealList.getInstance().visible = false;
					break;
				case 4:
					this.visible = false;
					RankPetRealList.getInstance().visible = true;
					break;
			}
		}
	}
}