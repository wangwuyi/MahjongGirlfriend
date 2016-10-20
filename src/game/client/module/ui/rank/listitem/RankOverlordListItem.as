package game.client.module.ui.rank.listitem
{
	import flash.events.MouseEvent;
	
	import game.component.ListItemBase;
	
	public class RankOverlordListItem extends ListItemBase
	{
		public static var rankMemberItemPool:Vector.<RankOverlordListItem> = new Vector.<RankOverlordListItem>();
		public static function getInstance():RankOverlordListItem
		{
			return rankMemberItemPool.length ? rankMemberItemPool.shift() : new RankOverlordListItem();
		}
		
		public function RankOverlordListItem()
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