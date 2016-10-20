package game.client.module.tip
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import game.client.resource.ResourcePath;
	import game.component.Component;
	
	public class TipClose extends Sprite
	{
		private var _closeIcon:Bitmap;
		public function TipClose()
		{
			initIcon();
			initListener();
			this.buttonMode = true;
		}
		
		private function initIcon():void
		{
			_closeIcon = new Bitmap();
			addChild(_closeIcon);
			_closeIcon.bitmapData = Component.getBitmapData(ResourcePath.CLOSE_ICON);
		}
		
		private function initListener():void
		{
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(evt:MouseEvent):void
		{
			if(this.parent != null)
			{
				TipManager.hide();
			}
			evt.stopPropagation();
		}
		
		public override function set visible(value:Boolean):void
		{
			super.visible = value;
		}
	}
}