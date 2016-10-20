package game.client.module.ui.rank.listitem
{
	import flash.events.MouseEvent;
	
	import game.component.ListItemBase;
	
	public class RankGuildPersonListItem extends ListItemBase
	{
		public static var rankMemberItemPool:Vector.<RankGuildPersonListItem> = new Vector.<RankGuildPersonListItem>();
		public static function getInstance():RankGuildPersonListItem
		{
			return rankMemberItemPool.length ? rankMemberItemPool.shift() : new RankGuildPersonListItem();
		}
		
		public function RankGuildPersonListItem()
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