package game.client.module.page
{
	public class Page
	{
		private var _currentPage:int = 1;
		private var _pageCount:int;
		private var _pageSize:int;
		private var _pageData:Array;
		
		public function get currentPage():int
		{
			return _currentPage;
		}
		
		public function set currentPage(value:int):void
		{
			_currentPage = Math.max(1,value);
		}
		
		public function get pageCount():int
		{
			return _pageCount;
		}
		
		public function set pageCount(value:int):void
		{
			_pageCount = value;
		}
		
		public function get pageSize():int
		{
			return _pageSize;
		}
		
		public function set pageSize(value:int):void
		{
			_pageSize = value;
		}
		
		public function get pageData():Array
		{
			return _pageData;
		}
		
		public function set pageData(value:Array):void
		{
			if(value)
			{
				_pageData = value;
				_pageCount = Math.max(1, Math.ceil(value.length / _pageSize));
			}
		}
		
		public function nextPage():void
		{
			if(_currentPage <= _pageCount - 1)
			{
				_currentPage++;
			}
		}
		
		public function prePage():void
		{
			if(_currentPage > 1)
			{
				_currentPage--;
			}
		}
		
		public function getStartIndex():int
		{
			return pageSize * (currentPage - 1);
		}
		
		public function jumpToFirstPage():void
		{
			_currentPage = 1;
		}
		
		public function jumpToLastPage():void
		{
			_currentPage = _pageCount;
		}
		
		public function jumpToPage(num:int):void
		{
			_currentPage = num;
		}
		
		public function getCurrentData():Array
		{
			var beginIndex:int = (_currentPage - 1) * _pageSize;
			var endIndex:int = beginIndex + _pageSize;
			var data:Array = null;
			if(_pageData)
				data = _pageData.slice(beginIndex, endIndex);
			return data;
		}
			
	}
}