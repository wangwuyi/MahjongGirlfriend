package game.client.module.ui.rank.listitem
{
	import flash.events.MouseEvent;
	
	import game.component.ListItemBase;
	
	public class RankCmpetitvListItem extends ListItemBase
	{
		public static var rankMemberItemPool:Vector.<RankCmpetitvListItem> = new Vector.<RankCmpetitvListItem>();
		public static function getInstance():RankCmpetitvListItem
		{
			return rankMemberItemPool.length ? rankMemberItemPool.shift() : new RankCmpetitvListItem();
		}
		
		public function RankCmpetitvListItem()
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