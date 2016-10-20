package game.client.module.ui.rank.list
{
	import flash.events.Event;
	
	import game.client.module.ui.rank.RankPanel;
	import game.client.module.ui.rank.listitem.RankMineListItem;
	import game.client.module.ui.rank.skin.RankMineListSkin;
	import game.component.List;

	public class RankMineList extends RankList
	{
		private static var _instance:RankMineList;
		public static function getInstance():RankMineList
		{
			if(_instance == null)
				_instance = new RankMineList();
			return _instance;
		}
		
		public function RankMineList()
		{
			this.skin = RankMineListSkin.skin;
			init();
		}
		
		private function init():void
		{
			_list = this.getChildByName("mingzi") as List;
			_list.verticalGap = 2;
		}
		
		public override function onUpdateList(e:Event):void
		{
			//datas = RankCache.getInstance().myBoards;
			updateDatas(1, 0, 0);
		}
		
		override public function updateDatas(page:int, job:int, sex:int):void
		{
			_list.removeAllItem();
			var index:int = (page-1)*10;
			var last:int = page*10 > datas.length?datas.length:page*10;
			for(var i:int=index; i<last; i++)
			{
				var item:RankMineListItem = new RankMineListItem();
				_list.addChild(item);
				item.data = datas[i];
			}
			_list.configSkin();
			var total:int = (datas.length+9)/10;
			RankPanel.instance.setPage(page, total);
		}
	}
}