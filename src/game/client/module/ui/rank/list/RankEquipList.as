package game.client.module.ui.rank.list
{
	import flash.events.Event;
	
	import game.client.module.ui.rank.RankPanel;
	import game.client.module.ui.rank.skin.RankEquipListSkin;
	import game.component.List;
	
	public class RankEquipList extends RankList
	{
		private static var _instance:RankEquipList;
		public static function getInstance():RankEquipList
		{
			if(_instance == null)
				_instance = new RankEquipList();
			return _instance;
		}
		
		public function RankEquipList()
		{
			this.skin = RankEquipListSkin.skin;
			init();
		}
		
		private function init():void
		{
			_list = this.getChildByName("mingzi") as List;
			_list.verticalGap = 2;
		}
		
		
		public override function onUpdateList(e:Event):void
		{
			//datas = RankCache.getInstance().equipBoards;
			updateDatas(1, RankPanel.instance.career, RankPanel.instance.sex);
		}
		
		override public function updateDatas(page:int, job:int, sex:int):void
		{
			super.updateDatas(page, job, sex);
		}
		
		
		override public function updateSubtype(subtype:int):void
		{
			switch(subtype)
			{
				case 0:
				case 1:
				case 2:
					this.visible = true;
					RankMountList.getInstance().visible = false;
					break;
				case 3:
					this.visible = false;
					RankMountList.getInstance().visible = true;
					break;
			}
		}
	}
}