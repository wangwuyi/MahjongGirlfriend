package game.client.module.ui.rank.listitem
{
	import flash.events.MouseEvent;
	
	import game.component.ListItemBase;
	
	public class RankGuildListITem extends ListItemBase
	{
		public static var rankMemberItemPool:Vector.<RankGuildListITem> = new Vector.<RankGuildListITem>();
		public static function getInstance():RankGuildListITem
		{
			return rankMemberItemPool.length ? rankMemberItemPool.shift() : new RankGuildListITem();
		}
		
		public function RankGuildListITem()
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