package game.client.module.popUI
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	
	import game.client.model.GlobalModel;
	import game.client.module.BasePanel;
	import game.client.module.popUI.skin.MsgBoxSkin;
	import game.client.utils.HashMap;
	import game.component.Button;
	import game.component.Label;
	import game.core.utils.Timer;
	
	public class MsgBox extends BasePanel
	{
		public static const OK:int = 1;
		public static const CANCLE:int = 2;
		public static const YES:int = 1;
		public static const NO:int = 2;
		
		public static const OK_OR_CANCLE:int = 3;
		public static const YES_OR_NO:int = 4;
		public static const AGREE_OR_REJECT:int = 5;
		
		public static const CUSTOMIZE:int = 6;
		private static var _msgBoxHashMap:HashMap = new HashMap();
		
		private static var pool:Array = [];
		private static var _timerout:int;
		
		private var _btnClickHandler:Function;
		private var _titleTxt:Label;
		private var _displayContentTxt:Label;
		private var _confirmBtn:Button;
		private var _cancleBtn:Button;
		private var _mask:Sprite;
		private var _isCanClickOther:Boolean = true;
		private var _message:String;
		public function MsgBox()
		{
			this.skin = MsgBoxSkin.skin;
			_mask = new Sprite();
			initPanelElement();
			initElementListener();
		}
		
		public static function show(text:String = "", flags:uint = MsgBox.YES, closeHandler:Function = null, isCanClickOther:Boolean = true, timerout:int=0,customBtnLabel:String = ""):MsgBox
		{
			_timerout = timerout;
			var msgBox:MsgBox;
			if(_msgBoxHashMap.get(text) == null)
			{
				msgBox = pool.length?pool.pop(): new MsgBox;
				_msgBoxHashMap.put(text,msgBox);
			}
			else
			{
				msgBox = _msgBoxHashMap.get(text) as MsgBox;
			}
			msgBox.show.apply(null, [text, flags, closeHandler, isCanClickOther,customBtnLabel]);
			return msgBox;
		}
		
		private function initPanelElement():void
		{
			_confirmBtn = getChildByName("queding") as Button;
			_confirmBtn.label.x -= 10;
			_confirmBtn.label.width = 55;
			_confirmBtn.label.autoSize = TextFieldAutoSize.CENTER;
			_confirmBtn.label.align = TextFormatAlign.CENTER;
			_cancleBtn = getChildByName("quxiao") as Button;
			_displayContentTxt = getChildByName("txtshuomingwenzi") as Label;
			_displayContentTxt.width = 245;
			_displayContentTxt.leading = 2;
			_displayContentTxt.height = 90;
			_displayContentTxt.multiline = true;
			_displayContentTxt.wordWrap = true;
			_displayContentTxt.mouseEnabled = true;
		}
		
		private function initElementListener():void
		{
			_confirmBtn.addEventListener(MouseEvent.CLICK, onClick);
			_cancleBtn.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(evt:MouseEvent):void
		{
			this.visible = false;
			if(_btnClickHandler == null)
			{
				return;
			}
			var clickTarget:Object = evt.target;
			switch(clickTarget)
			{
				case _confirmBtn:
				{
					_btnClickHandler(YES);
					break;
				}
				case _cancleBtn:
				{
					_btnClickHandler(NO);
					break;
				}
			}
		}
		
		public function show(content:String, flags:uint = MsgBox.OK_OR_CANCLE, callFunction:Function = null, isCanClickOther:Boolean = true, customBtnLabel:String = ""):void
		{
			this.visible = true;
			if(content == null)
			{
				return;
			}
			_message = content;
			if(_timerout > 0)
				Timer.add(run, 1000);
			_isCanClickOther = isCanClickOther;
			displayBtnFormat(flags,customBtnLabel);
			_displayContentTxt.htmlText = content;
			_displayContentTxt.y = (height - 40) >> 1
			_displayContentTxt.x = (width - _displayContentTxt.width) >> 1;
			this._btnClickHandler = callFunction;
		}
		
		private function run(now:int):void
		{
			_timerout --;
			var mes:String = _message.replace("$timerout", "<font color='#ff0000'>"+_timerout+"</font>");
			_displayContentTxt.htmlText = mes;
			if(_timerout <= 0)
			{
				Timer.remove(run);
				if(_btnClickHandler != null)
					_btnClickHandler(NO);
				this.visible = false;
			}
		}
		
		private function displayBtnFormat(flags:int,customBtnLabel:String):void
		{
			if(flags == MsgBox.YES_OR_NO)
			{
				_confirmBtn.label.text = " 是";
				_cancleBtn.label.text = " 否";
			}
			if(flags == MsgBox.AGREE_OR_REJECT)
			{
				_confirmBtn.label.text = "同意";
				_cancleBtn.label.text = "拒绝";
			}
			if(flags == MsgBox.YES || flags == MsgBox.OK)
			{
				_cancleBtn.visible = false;
				_confirmBtn.label.text = "确认";
				_cancleBtn.label.text = "取消";
				_confirmBtn.x = (width - _confirmBtn.width) >> 1;
			}
			if(flags == MsgBox.OK_OR_CANCLE)
			{
				_confirmBtn.label.text = "确认";
				_cancleBtn.label.text = "取消";
			}
			if(flags == MsgBox.CANCLE)
			{
				_cancleBtn.label.text = "取消";
			}
			if(flags == MsgBox.CUSTOMIZE)
			{
				_cancleBtn.visible = false;
				_confirmBtn.x = (width - _confirmBtn.width) >> 1;
				_confirmBtn.label.text = customBtnLabel;
			}
		}
		
		public override function set visible(value:Boolean):void
		{
			super.visible = value;
			if(value == false)
			{
				dispose();
			}
		}
		
		override protected function finishInitSkin(value:Boolean):void
		{
			if(value == true && _isCanClickOther == false && this.parent != null)
			{
				var index:int = this.parent.getChildIndex(this);
				this.parent.addChildAt(_mask,index);
			}
		}
		
		override public function onResize():void
		{
			super.onResize();
			_mask.graphics.clear();
			_mask.graphics.beginFill(0,0.5);
			_mask.graphics.drawRect(0, 0, GlobalModel.stage.stageWidth, GlobalModel.stage.stageHeight);
			_mask.graphics.endFill();
		}
		
		public function dispose():void
		{
			if (pool.indexOf(this) == -1)
			{
				pool.push(this);
			}
			if(_mask.parent != null)
			{
				_mask.parent.removeChild(_mask);
			}
			_msgBoxHashMap.remove(_message);
		}
	}
}