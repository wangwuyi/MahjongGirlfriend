package game.client.module.page
{
	import flash.events.MouseEvent;
	
	import game.component.Button;
	import game.component.Label;

	public class CommonPage extends Page
	{
		private var _firstBtn:Button;
		private var _lastBtn:Button;
		private var _preBtn:Button;
		private var _nextBtn:Button;
		private var _pageTxt:Label;
		
		private var _pageFn:Function;
		
		public function config(firstBtn:Button = null, lastBtn:Button = null,
							preBtn:Button = null, nextBtn:Button = null, pageTxt:Label = null):void
		{
			_firstBtn = firstBtn;
			_lastBtn = lastBtn;
			_preBtn = preBtn;
			_nextBtn = nextBtn;
			_pageTxt = pageTxt;
			addListener();
		}
		
		private function addListener():void
		{
			addBtnClickListener(_firstBtn, onFirst);
			addBtnClickListener(_lastBtn, onLast);
			addBtnClickListener(_preBtn, onPre);
			addBtnClickListener(_nextBtn, onNext);
		}
		
		private function addBtnClickListener(btn:Button, fun:Function):void
		{
			if(btn != null)
			{
				btn.addEventListener(MouseEvent.CLICK, fun);
			}
		}
		
		public function set pageFn(fun:Function):void
		{
			_pageFn = fun;
		}
		
		public function showFirstPage():void
		{
			jumpToFirstPage();
			refresh();
		}
		
		public function onFirst(evt:MouseEvent):void
		{
			jumpToFirstPage();
			refresh();
		}
		
		public function onLast(evt:MouseEvent):void
		{
			jumpToLastPage();
			refresh();
		}
		
		public function onPre(evt:MouseEvent):void
		{
			prePage();
			refresh();
		}
		
		public function onNext(evt:MouseEvent):void
		{
			nextPage();
			refresh();
		}
		
		public override function set pageData(value:Array):void
		{
			super.pageData = value;
			refresh();
		}
		
		public function refresh():void
		{
			if(currentPage > pageCount)
			{
				currentPage = pageCount;
			}
			else
			{
				if(_pageTxt != null)
				{
					_pageTxt.text = currentPage + "/" + pageCount;
				}
			}
			_pageFn(getCurrentData());
		}
	}
}