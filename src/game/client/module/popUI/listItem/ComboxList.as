package game.client.module.popUI.listItem
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import game.client.model.GlobalModel;
	import game.client.resource.ResourcePath;
	import game.component.ScaleImage;

	public class ComboxList extends Sprite
	{
		private var bg:ScaleImage;
		private var itemArr:Vector.<ComboBoxItem>;
		private static const COMBOX_NAME:int = 0;
		private static const COMBOX_FUN:int = 1;
		private static const COMBOX_TYPE:int = 2;
		
		public function ComboxList()
		{
			bg= new ScaleImage();
			bg.skin ={name:ResourcePath.TIP_BG,type:"ScaleImage",x:0,y:0,width:272,height:157,top:4,right:4,bottom:4,left:4,normal:{link:ResourcePath.TIP_BG,x:0,y:0,width:11,height:33}};
			bg.x = 5;
			addChild(bg);
			itemArr = new Vector.<ComboBoxItem>();
			GlobalModel.stage.addEventListener(MouseEvent.MOUSE_DOWN, hide);
		}
		
		public function setItem(data:Array):void
		{
			removeAllItem();
			var len:int = data[COMBOX_NAME].length;
			var item:ComboBoxItem;
			var maxWidth:int = 0;
			for(var i:int = 0; i<len; i++)
			{
				item =  ComboBoxItem.getInstance();
				item.setData(data[COMBOX_NAME][i],data[COMBOX_FUN],data[COMBOX_TYPE]);
				item.index = i;
				item.itemName = data[COMBOX_NAME][i];
				item.x = 17;
				item.y = 10 + item.height * i;
				addChild(item);
				if(item.width > maxWidth)
				{
					maxWidth = item.width;
				}
				itemArr.push(item);
			}
			bg.width = maxWidth + 5;
			bg.height = item.height + item.height * len;
		}
		
		public function get Bg():ScaleImage
		{
			return bg;
		}
		
		private function removeAllItem():void
		{
			for each(var item:ComboBoxItem in itemArr)
			{
				item.dispose();
				if(item.parent)
				{
					item.parent.removeChild(item);
				}
			}
			itemArr.length = 0;
		}
		
		private function hide(e:MouseEvent):void
		{
			if(this.parent != null)
			{
				this.parent.removeChild(this);
			}
			e.stopPropagation();
		}
		
	}
}