package game.client.module.popUI.listItem
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import game.client.resource.ResourcePath;
	import game.component.Label;
	import game.component.ScaleImage;

	public class ComboBoxItem extends Sprite
	{
		private var txt:Label;
		private var callBackFun:Function;
		private var bgOver:ScaleImage;
		private var select:Boolean;
		private var type:int;
		public var index:int;
		public var itemName:String;
		private static var pool:Vector.<ComboBoxItem> = new Vector.<ComboBoxItem>;
		public static const TYPE_PINBI:int = 1;
		public static const TYPE_CHANNAL:int = 2;
		public static const TYPE_OTHER:int = 3;
	    
		public static function getInstance():ComboBoxItem
		{
			return pool.length ? pool.shift() : new ComboBoxItem();
		}
		
		public function ComboBoxItem()
		{
			initBg();
			initTxt();
			this.buttonMode = true;
			this.addEventListener(MouseEvent.MOUSE_DOWN,onClick);
		}
		
		private function initTxt():void
		{
			txt = new Label();
			txt.width = 40;
			txt.wordWrap = false;
			addChild(txt);
		}
		
		private function initBg():void
		{
			bgOver= new ScaleImage();
			bgOver.skin ={name:ResourcePath.TIP_STRENGTH_STAR,type:"ScaleImage",x:0,y:0,width:10,height:15,top:4,right:4,bottom:4,left:4,normal:{link:ResourcePath.TIP_STRENGTH_STAR,x:0,y:0,width:10,height:15}};
			bgOver.x = -10;
			bgOver.width =15;
			bgOver.height = 15;
			bgOver.visible =  false;
			addChild(bgOver);
		}
		
		private function onOver(e:MouseEvent):void
		{
			bgOver.visible = true;
		}
		
		private function onOut(e:MouseEvent):void
		{
			if(select == false)
			{
				bgOver.visible = false;
			}
		}
		
	    private function onClick(e:MouseEvent):void
		{
//			e.stopPropagation();
			if(this.type == TYPE_PINBI)
			{
				select = !select;
				bgOver.visible = select;
			}
			if(callBackFun != null)
			{
				callBackFun(e);
			}
		}
		
		public function setData(str:String,fn:Function,type:int):void
		{
			this.type = type;
			callBackFun = fn;
			txt.htmlText = " <font color='#00ACEC'><a href='event:ok'>" + str + "</a></font>\n";
			txt.width = txt.textWidth + 4;
			if(type == TYPE_PINBI)
			{
				this.addEventListener(MouseEvent.MOUSE_OUT,onOut);
				this.addEventListener(MouseEvent.MOUSE_OVER,onOver);
			}
		}
		
		public function dispose():void
		{
			pool.push(this);
		}
		
	}
}