package game.client.module.ui.rank.list
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import game.component.Label;
	import game.component.ListItemBase;
	import game.component.RadioButton;
	
	public class RankCategoryListItem extends ListItemBase
	{
		public static const LISTITEM_CLICK:String = "LISTITEM_CLICK";
		public static var RankCategoryMemberItemPool:Vector.<RankCategoryListItem> = new Vector.<RankCategoryListItem>();
		public static function getInstance():RankCategoryListItem
		{
			return RankCategoryMemberItemPool.length ? RankCategoryMemberItemPool.shift() : new RankCategoryListItem();
		}
		
		private var _button:RadioButton;
		private var _buttonTxt:Label;
		public function RankCategoryListItem()
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
			_button = this.getChildByName("gerenpaihang") as RadioButton;
			_buttonTxt = _button.getChildByName("txtgrph") as Label;
			_button.addEventListener(MouseEvent.CLICK, onClickHandler);
		}
		
		override public function get data():Object
		{
			return super.data;
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			_buttonTxt.text = value.name;
		}
		
		public function get isSelected():Boolean
		{
			return _button.selected;
		}
		
		public function set isSelected(value:Boolean):void
		{
			_button.selected = value;
		}
		
		public function onClickHandler(e:MouseEvent = null):void
		{
			dispatchEvent(new Event(LISTITEM_CLICK));
		}
	}
}