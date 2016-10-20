package game.client.module.tip
{
	import game.component.Label;

	public class CommonTip extends Tip implements ITip
	{
		protected var _txtInfo:Label;
		public function CommonTip()
		{
			_txtInfo = new Label();
			_txtInfo.color = 0xFFFFFF;
			_txtInfo.leading = 3;
			_txtInfo.x = 30;
			_txtInfo.y = 30;
			_txtInfo.width = 226;
			_txtInfo.height = 156;
			addChild(_txtInfo);
		}
		
		public function show():void
		{
			var data:String = tipBindObject.userData as String;
			_txtInfo.htmlText = data;
			_width = _txtInfo.x + _txtInfo.textWidth + 30;
			_height = _txtInfo.y + _txtInfo.textHeight + 30;
			_bgIcon.setSize(_width, _height);
		}
	}
}