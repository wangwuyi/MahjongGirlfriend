package game.core.gameUnit.role
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.getTimer;
	
	public class NameBar extends Sprite
	{
		public static const ICON_LEFT:String = "left";
		public static const ICON_RIGHT:String = "right";
		public static const NAME:String = "nameBar";
		
		private var _label:TextField;
		private var _textContent:String;
		
		private var _icon:NameBarBitmap;
		private var _iconAnchor:String;
		
		private var _sortedTitleImageList:Vector.<NameBarBitmap>;
		private var _titleHeight:int;
		
		private var _hp:Bitmap;
		private var _hpBg:Bitmap;
		private var _isShowHp:Boolean = false;
		private var _lastUpdateHpTime:int;
		private var _lastHpPercent:int = 100;
				
		public function NameBar()
		{
			initialize();
			createChildren();
			showHp(false);
		}
		
		private function initialize():void
		{
			this.mouseEnabled = false;
			this.mouseChildren = false;
			this.name = NAME;
			_sortedTitleImageList = new Vector.<NameBarBitmap>();
			this.y = -120;
		}
		
		private function createChildren():void
		{
			_hp = new Bitmap;
			addChild(_hp);
			_hpBg = new Bitmap;
			addChild(_hpBg);
			_hp.bitmapData = new BitmapData(50,5,false,0x0);
			_hpBg.bitmapData = new BitmapData(50,5,false,0xff0000)
			_hp.x = -_hp.width >> 1;
			_hpBg.x = -_hpBg.width >> 1;
			addLabel();
		}
		
		private function addLabel():void
		{
			_label = new TextField();
			_label.height = 20;
			_label.mouseEnabled=false;
			_label.mouseWheelEnabled=false;
			_label.wordWrap=true;
			_label.selectable=false;
			var dtf:TextFormat=new TextFormat();
			dtf.align=TextFormatAlign.CENTER;
			_label.defaultTextFormat=dtf;
			addChild(_label);
		}
		
		public function set textContent(value:String):void
		{
			_textContent = value;
			_label.htmlText = _textContent;
			updateLayout();
		}
		
		public function get textContent():String
		{
			return _textContent;
		}
		
		public function addIcon(iconUrl:String, anchor:String = ICON_RIGHT):void
		{
			if(_icon == null)
			{
				_icon = NameBarBitmap.getInstance();
				_icon.addEventListener(NameBarBitmap.EVT_CONSTRUCTED, onIconConstructed);
			}
			_iconAnchor = anchor;
			_icon.url = iconUrl;
		}
		
		private function onIconConstructed(evt:Event):void
		{
			updateIconLayout();
			addChild(_icon);
		}
		
		public function removeIcon():void
		{
			if(_icon != null && contains(_icon) == true)
			{
				removeChild(_icon);
				_icon.removeEventListener(NameBarBitmap.EVT_CONSTRUCTED, onIconConstructed);
				_icon.dispose();
				_icon = null;
			}
		}
		
		private function updateIconLayout():void
		{
			if(_icon != null)
			{
				if(_iconAnchor == ICON_RIGHT)
				{
					_icon.x = _label.x + _label.width + 4 - (_label.width - _label.textWidth)/2;
				}
				else
				{
					_icon.x = _label.x - _icon.width - 4 + (_label.width - _label.textWidth)/2;
				}
				_icon.y = _label.y + ((_label.textHeight - _icon.height) >> 1);
			}
		}
		
		public function addTitle(url:String, priority:int):void
		{
			if(url == "" || url == null)
			{
				return;
			}
			var titleImage:NameBarBitmap = NameBarBitmap.getInstance();
			titleImage.addEventListener(NameBarBitmap.EVT_CONSTRUCTED, onTitleImageConstructed);
			titleImage.priority = priority;
			insertToSortedTitleImageList(titleImage);
			titleImage.url = url;
		}
		
		private function insertToSortedTitleImageList(image:NameBarBitmap):void
		{
			var len:int = _sortedTitleImageList.length;
			var index:int = len;
			for(var i:int = 0; i < len; i++)
			{
				var currentImage:NameBarBitmap = _sortedTitleImageList[i];
				if(image.priority > currentImage.priority && index > i)
				{
					index = i;
				}
			}
			_sortedTitleImageList.splice(index, 0, image);
		}
		
		private function onTitleImageConstructed(evt:Event):void
		{
			updateTitleListLayout();
		}
		
		private function updateTitleListLayout():void
		{
			_titleHeight = 0;
			var len:int = _sortedTitleImageList.length;
			var anchorY:int = _label.y;
			for(var i:int = 0; i < len; i++)
			{
				var titleImage:NameBarBitmap = _sortedTitleImageList[i];
				titleImage.x = -titleImage.width >> 1;
				titleImage.y = anchorY - titleImage.height;
				anchorY -= titleImage.height;
				_titleHeight += titleImage.height;
				addChild(titleImage);
			}
		}
		
		public function removeAllTitle():void
		{
			var len:int = _sortedTitleImageList.length;
			for(var i:int = 0; i < len; i++)
			{
				var titleImage:NameBarBitmap = _sortedTitleImageList[i];
				titleImage.removeEventListener(NameBarBitmap.EVT_CONSTRUCTED, onTitleImageConstructed);
				if(contains(titleImage) == true)
				{
					removeChild(titleImage);
				}
				titleImage.dispose();
			}
			_sortedTitleImageList.length = 0;
		}
		
		private function updateLayout():void
		{
			updateLabelLayout();	//刷新名称
			updateIconLayout(); 	//刷新图标
			updateTitleListLayout();//刷新称号
		}
		
		private function updateLabelLayout():void
		{
			_label.x = -_label.width / 2;
			if(_isShowHp == true)
			{
				_label.y = -_label.height - _hpBg.height-5;
			}
			else
			{
				_label.y = -_label.height - 5;
			}
		}
		
		public function updateHp(hp:int, hpMax:int):void
		{
			var current:int = getTimer();
			var percent:int = Math.ceil(hp/hpMax * 100); 
			if(_lastHpPercent != percent)
			{
				_hp.scaleX = percent/100;
				_lastHpPercent = percent;
				_lastUpdateHpTime = current;
				showHp(true);
			}
			if(current - _lastUpdateHpTime > 10000)
			{
				showHp(false);
			}
		}
		
		public function showHp(value:Boolean):void
		{
			_isShowHp = value;
			_hpBg.y = - _hpBg.height - 2;
			_hp.y = _hpBg.y;
			_hp.visible = value;
			_hpBg.visible = value;
			updateLayout();
		}
		
		public function get titleHeight():int
		{
			return _titleHeight;
		}
		
		public function dispose():void
		{
			removeIcon();
			removeAllTitle();
			showHp(false);
		}
		
	}
}
