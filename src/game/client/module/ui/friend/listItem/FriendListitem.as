package game.client.module.ui.friend.listItem
{
	import game.component.ListItemBase;

	public class FriendListitem extends ListItemBase
	{
		
		public static var itemPool:Vector.<FriendListitem> = new Vector.<FriendListitem>();
		
		public static function getInstance():FriendListitem{
			return itemPool.length?itemPool.pop():new FriendListitem();
		}
		
		public function FriendListitem()
		{
			super();
		}
		
		override protected function configChildren():void{
			
		}
		
		override public function set data(value:Object):void{
			super.data=value;
		}
		
		override public function dispose():void{
			itemPool.push(this);
		}
	}
}