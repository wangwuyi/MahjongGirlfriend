package game.client.module.ui.friend.container
{
	import game.client.module.page.CommonPage;
	import game.client.module.ui.friend.listItem.FriendListitem;
	import game.component.List;

	public class FriendListContainer
	{
		private var _list:List;
		
		private var _page:CommonPage;
		
		private const PAGE_SIZE:int=5;
		
		public function FriendListContainer(list:List,page:CommonPage)
		{
			_list=list;
			_page=page;
			_page.pageFn=setData;
			_page.pageSize=PAGE_SIZE;
		}
		
		private function init():void{
			_list.verticalGap=10;
			_list.columnCount=1;
			_list.rowCount=PAGE_SIZE;
		}
		
		private function setData(ary:Array):void{
			_list.removeAllItem();
			for (var i:int = 0; i < ary.length; i++) 
			{
				var item:FriendListitem = FriendListitem.getInstance();
				_list.addChild(item);
			}
		}
		
		public function setFriend(type:int):void{
			var arr:Array = [1,2,3,4,5];
			_page.pageData = arr;
		}
	}
}