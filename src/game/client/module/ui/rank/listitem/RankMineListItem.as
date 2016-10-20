package game.client.module.ui.rank.listitem
{
	import game.client.module.ui.rank.data.RankDataVo;
	import game.component.Image;
	import game.component.Label;
	import game.component.ListItemBase;
	
	public class RankMineListItem extends ListItemBase
	{
		public static var myMemberItemPool:Vector.<RankMineListItem> = new Vector.<RankMineListItem>();
		public static function getInstance():RankMineListItem
		{
			return myMemberItemPool.length ? myMemberItemPool.shift() : new RankMineListItem();
		}
		
		private var _rank:Label;
		private var _value:Label;
		private var _selectBg:Image;
		public function RankMineListItem()
		{
			super();
		}
		
		public override function set skin(value:Object):void
		{
			super.skin = value;
			init();
		}
		
		private function init():void
		{
			_selectBg = this.getChildByName("xuanzhongxx21") as Image;
			_rank = this.getChildByName("txtpaim11") as Label;
			_value = this.getChildByName("txtmingzi11") as Label;
			selected = false;
		}
		
		override public function set selected(value:Boolean):void
		{
			super.selected = value;
			_selectBg.visible = value;
		}
		
		
		override public function set data(value:Object):void
		{
			super.data = value;
			_rank.text = RankDataVo(data).rank.toString();
			_value.text = RankDataVo(data).rankName;
		}
	}
}