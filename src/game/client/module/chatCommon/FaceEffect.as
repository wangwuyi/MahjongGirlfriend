package game.client.module.chatCommon
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import game.client.resource.ResourcePath;
	import game.core.utils.MassLoader;
	
	public class FaceEffect extends Sprite
	{
		protected var _url:String;//地址
		protected var _link:String;//链接
		protected var _movieClip:MovieClip;
		public function FaceEffect()
		{
			this.mouseChildren = false;
			this.mouseEnabled = false;
			
		}
		
		public function setIndex(index:int):void
		{
			configUrl(index);
			configLink(index);
			clearClip();
			if(Face.hasResource(this._url) == true)
			{
				addClip();
			}
			else
			{
				MassLoader.add(this._url,onCompleteHanlder)
			}
		}
		
		protected function configUrl(index:int):void
		{
			this._url = ResourcePath.FACE+"face"+index+".swf";
		}
		
		protected function configLink(index:int):void
		{
			this._link = "Face" + index;
		}
		
		private function onCompleteHanlder(info:Object):void
		{
			Face.add(this._url,info.applicationDomain);
			addClip();
		}
		
		private function addClip():void
		{
			clearClip();
			var cl:Class = Face.getClass(this._url,this._link);
			_movieClip = new cl as MovieClip;
			_movieClip.x = -_movieClip.width / 2;
			_movieClip.y = -_movieClip.height / 2;
			this.addChild(_movieClip);
		}
		
		public function clearClip():void
		{
			if(_movieClip != null && contains(_movieClip) == true)
			{
				removeChild(_movieClip);
			}
			_movieClip = null;
		}
		
		public function dispose():void
		{
			if(this.parent!=null)
			{
				this.parent.removeChild(this);
			}
			_movieClip = null;
		}
		
	}
}