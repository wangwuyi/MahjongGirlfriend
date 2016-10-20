package game.client.utils
{
	/**
	 * 场景彩字 
	 * @author As_HJM
	 * 
	 */	
	public class ColorWord
	{
		public static const UP:int         = 0;
		public static const BOTTOM:int     = 1;
		private static var _wordClip:TextClip;
		/**
		 * 场景中显示像歌词一样的彩字 
		 * @param word 显示文字
		 * @param color 颜色web颜色
		 * @param size
		 * @param pos
		 * @param showTime 显示的时间
		 * @param fadeInTime 淡入的时间毫秒
		 * @return 
		 * 
		 */		
		public static function show(word:String="我们都在这里", color:String = "#FFFFFF", size:int = 30, pos:int = ColorWord.BOTTOM, showTime:int = 1000, fadeInTime:int = 0):void
		{
			if(_wordClip == null)
			{
				_wordClip = new TextClip;
			}
			_wordClip.showWord(word, color, size, pos, showTime, fadeInTime);
		}
		public static function clear():void{
			show("","",0,ColorWord.BOTTOM,0);
		}
	}
}

import flash.display.Sprite;
import flash.events.Event;
import flash.filters.GlowFilter;
import flash.text.TextField;
import flash.text.TextFormatAlign;
import flash.utils.clearTimeout;
import flash.utils.setTimeout;

import game.client.model.GlobalModel;
import game.client.utils.ColorWord;
import game.core.utils.Tween;

class TextClip extends Sprite
{
	private static var T:Number;
	private var _wordTxt:TextField = new TextField;
	private var _size:int;
	private var _color:String;
	private var _pos:int;
	private var _y:int;
	public function TextClip()
	{
		_wordTxt = getTextField();
		_wordTxt.autoSize = TextFormatAlign.CENTER;
		_wordTxt.selectable = false;
		_wordTxt.mouseEnabled = false;
		_wordTxt.height = 40;
		
		GlobalModel.stage.addEventListener(Event.RESIZE, resize);
		GlobalModel.stage.addChild(_wordTxt);
	}
	
	private function setStyle(color:String = "#FFFFFF", size:int = 20, pos:int = ColorWord.BOTTOM):void
	{
		_size = size;
		_color = color;
		_pos = pos;
		var intColor:uint = new uint("0x"+color.substring(1,6));
		_wordTxt.filters = [new GlowFilter(intColor,1,13,13,4,3,false,false)];
	}
	
	private function getTextField():TextField
	{
		return new TextField;
	}
	
	private function resize(e:Event):void
	{
		_wordTxt.x = (GlobalModel.stage.stageWidth - _wordTxt.width) / 2;
		setPos();
	}
	
	/**
	 * 显示彩字 
	 * @param word
	 * @param showTime 显示时间(毫秒)
	 * @param fadeInTime 淡入时间（毫秒）
	 * 
	 */	
	public function showWord(word:String="我们都在这里", color:String = "#FFFFFF", size:int = 30, pos:int = ColorWord.BOTTOM, showTime:int = 1000, fadeInTime:int = 50):void
	{
		setStyle(color, size, pos);
		GlobalModel.stage.addEventListener(Event.RESIZE, resize);
		_wordTxt.htmlText = "<font color='" + _color + "' size='"+ _size +"'>" + word + "</font>";
		_wordTxt.x = (GlobalModel.stage.stageWidth - _wordTxt.textWidth) / 2;
		setPos();
		_wordTxt.visible = true;
		if(fadeInTime < 50)
		{
			fadeInTime = 100;
		}
		Tween.to(_wordTxt, fadeInTime, {y:[_y, _y], alpha:[0,1]});
		clearTimeout(T); //防止内存泄露
		T = setTimeout(dispose, showTime+fadeInTime);
	}
	
	private function setPos():void
	{
		if(_pos == ColorWord.UP)
		{
			_y= 140;
		}
		if(_pos == ColorWord.BOTTOM)
		{
			_y = GlobalModel.stage.stageHeight - 160;
		}
		_wordTxt.y = _y;
	}
	
	private function dispose():void
	{
		if(_wordTxt.visible)
		{
			GlobalModel.stage.removeEventListener(Event.RESIZE, resize);
			_wordTxt.visible = false;
		}
	}
}