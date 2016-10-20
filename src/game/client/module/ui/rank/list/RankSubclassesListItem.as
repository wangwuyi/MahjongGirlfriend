package game.client.module.ui.rank.list
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import game.component.Image;
	import game.component.Label;
	import game.component.ListItemBase;
	
	public class RankSubclassesListItem extends ListItemBase
	{
		public static const RANK_SUB_CLICK:String = "RANK_SUB_CLICK";
		public static var RankSubclassesMemberItemPool:Vector.<RankSubclassesListItem> = new Vector.<RankSubclassesListItem>();
		public static function getInstance():RankSubclassesListItem
		{
			return RankSubclassesMemberItemPool.length ? RankSubclassesMemberItemPool.shift() : new RankSubclassesListItem();
		}
		
		private var _subTxt:Label;
		private var _selectBg:Image;
		public function RankSubclassesListItem()
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
			_subTxt = this.getChildByName("zhandoupaihang") as Label;
			this.addEventListener(MouseEvent.CLICK, onClickHandler);
			_selectBg = this.getChildByName("xuanzhogn") as Image;
			selected = false;
		}
		
		override public function get data():Object
		{
			return super.data;
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			_subTxt.text = value.name;
		}
		
		override public function set selected(value:Boolean):void
		{
			super.selected = value;
			_selectBg.visible = value;
		}
		
		private function onClickHandler(e:MouseEvent):void
		{
			dispatchEvent(new Event(RANK_SUB_CLICK));
		}
	}
}