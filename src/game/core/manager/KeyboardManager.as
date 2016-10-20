package game.core.manager
{
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.system.IME;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import game.client.manager.StageManager;
	
	public class KeyboardManager
	{
		
		private static var cast:Array = [];
		private static var _aidKeyArr:Array = new Array();
		private static var _aidKeyStateDic:Dictionary = new Dictionary();
		public static var enabled:Boolean = true;
		public static var isDown:Boolean = false;
		private static var downList:Array = [Keyboard.A,Keyboard.S,,Keyboard.W,Keyboard.D,,Keyboard.SHIFT,Keyboard.SPACE,Keyboard.R,Keyboard.E,Keyboard.Q,Keyboard.T,Keyboard.F];
		
		public static function init(GameKeyboard:Class):void
		{
			//确保玩家点击地图时IME.enabled=false
			StageManager.stage.addEventListener(MouseEvent.CLICK, onStageMouseClick);
			StageManager.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			StageManager.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			var properties:XMLList = describeType(GameKeyboard).method;
			for each (var propertyInfo:XML in properties)
			{
				if (KeyboardManager[propertyInfo.@name])
				{
					cast[KeyboardManager[propertyInfo.@name]] = GameKeyboard[propertyInfo.@name]
				}
			}
			_aidKeyArr.push(Keyboard.CONTROL);
		}
		
		private static function onStageMouseClick(evt:MouseEvent):void
		{
			var textField:TextField = StageManager.stage.focus as TextField;
			IME.enabled = textField && textField.type == TextFieldType.INPUT;
		}
		
		public static function onKeyUp(e:KeyboardEvent):void
		{
			isDown = false;
		}
		
		public static function onKeyDown(e:KeyboardEvent):void
		{
			var textField:TextField = StageManager.stage.focus as TextField;
			IME.enabled = textField && textField.type == TextFieldType.INPUT;
			if (isDown)
			{
				if(downList.indexOf(e.keyCode) == -1 && (e.keyCode < 48 || e.keyCode > 57))
				{
					return;
				}
			}
			if(IME.enabled && e.keyCode != Keyboard.ENTER)
			{
				return;
			}
			if (cast[e.keyCode] && enabled)
			{
				cast[e.keyCode](e);
				e.preventDefault();
			}
			isDown = true;
		}
		
		public static function checkAidKeyDown(keyCode:int):Boolean
		{
			if(_aidKeyStateDic[keyCode] == 1)
			{
				return true;
			}
			return false;
		}
		
		public static function dispose():void
		{
			StageManager.stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			StageManager.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		public static const SPACE:int = 32;
		public static const ESCAPE:int = 27;
		public static const ENTER:int = 13;
		public static const TAB:int = 9;
		public static const TILDE:int = 192;
		public static const SHIFT:int = 16;
		
		public static const NUMBER1:int = 49;
		public static const NUMBER2:int = 50;
		public static const NUMBER3:int = 51;
		public static const NUMBER4:int = 52;
		public static const NUMBER5:int = 53;
		public static const NUMBER6:int = 54;
		public static const NUMBER7:int = 55;
		public static const NUMBER8:int = 56;
		public static const NUMBER9:int = 57;
		public static const NUMBER0:int = 48;
		
		public static const A:int = 65;
		public static const B:int = 66;
		public static const C:int = 67;
		public static const D:int = 68;
		public static const E:int = 69;
		public static const F:int = 70;
		public static const G:int = 71;
		public static const H:int = 72;
		public static const I:int = 73;
		public static const J:int = 74;
		public static const K:int = 75;
		public static const L:int = 76;
		public static const M:int = 77;
		public static const N:int = 78;
		public static const O:int = 79;
		public static const P:int = 80;
		public static const Q:int = 81;
		public static const R:int = 82;
		public static const S:int = 83;
		public static const T:int = 84;
		public static const U:int = 85;
		public static const V:int = 86;
		public static const W:int = 87;
		public static const X:int = 88;
		public static const Y:int = 89;
		public static const Z:int = 90;
		
		public static const UP:int = 38;
		public static const DOWN:int = 40;
		public static const LEFT:int = 37;
		public static const RIGHT:int = 39;
		public static const COMMA:int = 188;
	}
}
