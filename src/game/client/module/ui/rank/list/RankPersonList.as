package game.client.module.ui.rank.list
{
	import flash.events.Event;
	
	import game.client.module.ui.rank.RankPanel;
	import game.client.module.ui.rank.data.RankDataVo;
	import game.client.module.ui.rank.listitem.RankPersonListItem;
	import game.client.module.ui.rank.skin.RankPersonListSkin;
	import game.component.Label;
	import game.component.List;
	
	public class RankPersonList extends RankList
	{
		private static var _instance:RankPersonList;
		public static function getInstance():RankPersonList
		{
			if(_instance == null)
				_instance = new RankPersonList();
			return _instance;
		}
		
		private var _changeTxt:Label;
		public function RankPersonList()
		{
			this.skin = RankPersonListSkin.skin;
			init();
		}
		
		private function init():void
		{
			_changeTxt = this.getChildByName("txtzhandouli") as Label;
			_list = this.getChildByName("mingzi") as List;
			_list.verticalGap = 2;
		}
		
		public override function onUpdateList(e:Event):void
		{
			//datas = RankCache.getInstance().humanBoards;
			updateDatas(1, RankPanel.instance.career, RankPanel.instance.sex);
		}
		
		override public function updateDatas(page:int, job:int, sex:int):void
		{
			_list.removeAllItem();
			var showList:Array = sortOn(job, sex);
			var index:int = (page-1)*10;
			var last:int = page*10 > showList.length?showList.length:page*10;
			for(var i:int=index; i<last; i++)
			{
				var item:RankPersonListItem = RankPersonListItem.getInstance();
				_list.addChild(item);
				item.data = showList[i];
			}
			_list.configSkin();
			var total:int = (showList.length+9)/10;
			RankPanel.instance.setPage(page, total);
		}
		
		private function sortOn(job:int, sex:int):Array
		{
			var arr:Array = getSortOnJob(datas as Array, job);
			return getSortOnSex(arr, sex);
		}
		
		private function getSortOnSex(arr:Array,sex:int):Array
		{
			if(sex == 0) return arr;
			var result:Array = [];
			for each(var item:RankDataVo in arr)
			{
				if(item.sex == sex)
					result.push(item);
			}
			return result;
		}
		
		private function getSortOnJob(arr:Array,job:int):Array
		{
			if(job == 0) return arr;
			var result:Array = [];
			for each(var item:RankDataVo in arr)
			{
				if(item.job == job)
					result.push(item);
			}
			return result;
		}
		
		
		public override function updateSubtype(subtype:int):void
		{
			switch(subtype)
			{
				case 0:
					_changeTxt.text = "战斗力";
					break;
				case 1:
					_changeTxt.text = "等级";
					break;
				case 2:
					_changeTxt.text = "财富";
					break;
				case 3:
					_changeTxt.text = "成就";
					break;
			}
		}
	}
}