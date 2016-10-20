package game.client.module.tip
{
	import flash.display.Sprite;
	
	import game.client.resource.ResourcePath;
	import game.component.ScaleImage;
	
	public class Tip extends Sprite
	{
		protected var _bgIcon:ScaleImage;
		protected var _width:int;
		protected var _height:int;
		protected var _tipBindObject:TipBindObject;
		protected var _tipClose:TipClose;
		public function Tip()
		{
			initBgIcon();
			initTipClose();
		}
		
		private function initBgIcon():void
		{
			_bgIcon = new ScaleImage();
			_bgIcon.skin = {
				name:"bg",
				type:"ScaleImage",
				top:30,
				bottom:30,
				left:30,
				right:30,
				normal:{link:ResourcePath.TIP_BG, x:0, y:0, width:286, height:216}
			}
			addChild(_bgIcon);
		}
		
		private function initTipClose():void
		{
			_tipClose = new TipClose();
			_tipClose.visible = false;
			addChild(_tipClose);
		}
		
		public function clear():void
		{
			width = 0;
			height = 0;
			_bgIcon.width = 0;
			_bgIcon.height = 0;
		}
		
		public function hide():void
		{
		}

		public function get tipBindObject():TipBindObject
		{
			return _tipBindObject;
		}

		public function set tipBindObject(value:TipBindObject):void
		{
			_tipBindObject = value;
		}
		
		public function setClose(value:Boolean):void
		{
			_tipClose.visible = value;	
			setChildIndex(_tipClose,this.numChildren - 1);
			_tipClose.x = this._bgIcon.width - 30;
		}
	}
}