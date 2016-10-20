package game.client.module.ui.rank.list
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import game.client.manager.DispatchManager;
	import game.client.model.GlobalModel;
	import game.client.module.BasePanel;
	import game.client.module.ui.rank.RankPanel;
	import game.component.List;
	
	public class RankList extends BasePanel
	{
		
		public var subtype:int;
		public var datas:Object;
		public var _list:List;
		public function RankList()
		{
			super();
		}
		
		public function updateSubtype(subtype:int):void
		{
			this.subtype = subtype;
		}
		
		private function initEvent():void
		{
			DispatchManager.instance.addEventListener(GlobalModel.RANK_LIST_UPDATE, onUpdateList);
		}
		
		public function onUpdateList(e:Event):void
		{
			
		}
		
		public function updateDatas(page:int,job:int,sex:int):void
		{
		}
		
		override public function onResize():void
		{
			this.x = 132;
			this.y = 104;
		}
		
		override public function set visible(value:Boolean):void
		{
			super.visible = value;
			if(value == true)
				initEvent();
			else
				removeEvent();
		}
		
		private function removeEvent():void
		{
			DispatchManager.instance.removeEventListener(GlobalModel.RANK_LIST_UPDATE, onUpdateList);
		}
		
		override public function get uiParent():DisplayObjectContainer
		{
			return  RankPanel.instance;
		}
	}
}