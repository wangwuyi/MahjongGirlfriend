package game.client.module.ui.rank.listitem
{
	import flash.events.MouseEvent;
	
	import game.component.ListItemBase;
	
	public class RankPetrealListItem extends ListItemBase
	{
		public static var rankMemberItemPool:Vector.<RankPetrealListItem> = new Vector.<RankPetrealListItem>();
		public static function getInstance():RankPetrealListItem
		{
			return rankMemberItemPool.length ? rankMemberItemPool.shift() : new RankPetrealListItem();
		}
		
		public function RankPetrealListItem()
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
			addEventListener(MouseEvent.CLICK, onClickHandler);
		}
		
		public override function set data(value:Object):void
		{
			
		}
		
		private function onClickHandler(e:MouseEvent):void
		{
			
		}
		
		public override function get data():Object
		{
			return _data;
		}
	}
}