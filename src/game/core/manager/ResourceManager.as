package game.core.manager
{
	
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import game.core.utils.MassLoader;
	import game.core.utils.Timer;
	import game.core.utils.Utils;
	
	public class ResourceManager
	{
		/**
		 *储存引用 
		 */		
		private static var _referenceDic:Dictionary = new Dictionary();
		/**
		 *储存resObj 
		 */		
		private static var _resUrlDic:Dictionary = new Dictionary();
		/**
		 *储存图片 
		 */		
		private static var _imageUrlDic:Dictionary = new Dictionary();
		/**
		 *同时段加载同一图片对象 
		 */		
		private static var _imageUrlObj:Dictionary = new Dictionary();
		
		public static const RECYCLE_INTERVAL:int = 5*60*1000;
		public static const RECYCLE_TIME_SPAN:int = 3*60*1000;
		
		initialize();
		
		private static function initialize():void
		{
			//5分钟回收一次内存垃圾
			Timer.add(recycleResource, RECYCLE_INTERVAL);
		}
		
		private static function recycleResource(now:int):void
		{
			dispose();
		}
		
		public static function getResource(url:String, action:String, way:int, rate:Number, priority:int = 10):Object
		{
			var resObj:ResObj = _resUrlDic[url];
			if (resObj == null)
			{
				resObj = new ResObj(url, priority);
				_resUrlDic[url] = resObj;
			}
			return resObj.getResource(action, way, rate, priority);
		}
		
		/**
		 * 标记引用 
		 * @param url
		 * 
		 */		
		public static function increaseResourceReference(url:String):void
		{
			var reference:Reference = _referenceDic[url];
			if(reference == null)
			{
				reference = Reference.getInstance();
				reference.url = url;
				reference.count = 1;
				_referenceDic[url] = reference;
			}
			else
			{
				reference.count = reference.count + 1;
			}
		}
		
		/**
		 * 清除引用
		 * @param url
		 * 
		 */		
		public static function decreaseResourceReference(url:String):void
		{
			var reference:Reference = _referenceDic[url];
			if(reference != null)
			{
				reference.count = reference.count - 1;
				if(reference.count == 0)
				{
					reference.releaseTime = getTimer();
				}
			}
			else
			{
				Utils.log("资源： " + url + "可能有泄漏", Utils.LOG_ERR);
			}
		}
		
		public static function dispose(force:Boolean = false):void
		{
			var currentTime:int = getTimer();
			for(var url:String in _referenceDic)
			{
				var reference:Reference = _referenceDic[url];
				var releasable:Boolean = force || (currentTime - reference.releaseTime) >= RECYCLE_TIME_SPAN;
				if(reference.count <= 0 && releasable)
				{
					var resObj:ResObj = _resUrlDic[url] as ResObj;
					if(resObj != null)
					{
						resObj.dispose();
						reference.dispose();
						delete _resUrlDic[url];
						delete _referenceDic[url];
					}
				}
			}
		}
		
		public static function getConfig(url:String, action:String, property:String, priority:int = 10):Object
		{
			var resObj:ResObj = _resUrlDic[url]; 
			if (resObj == null)
			{
				resObj = new ResObj(url, priority);
				_resUrlDic[url] = resObj;
			}
			return resObj.getConfig(url, action, property);
		}
		
		public static function getBitmap(bitmap:Bitmap, url:String, callback:Function = null):void
		{
			var key:String = MassLoader.getResourceUrl(url);
			if (_imageUrlDic[key] == null && _imageUrlObj[key] == null)
			{
				_imageUrlObj[key] = [bitmap];
				MassLoader.addImage(url, function(info:Object):void
				{
					onLoad(info);
					if(callback != null)
					{
						callback();
					}
				}, bitmap);
			}else if(_imageUrlObj[key] != null){
				(_imageUrlObj[key] as Array).push(bitmap);
				if((_imageUrlObj[key] as Array).length==2){
					Utils.log(url+"被同时加载了。", Utils.LOG_INFO);
				}
			}else
			{
				bitmap.bitmapData = _imageUrlDic[key];
				if(callback != null)
				{
					callback();
				}
			}
		}
		
		private static function onLoad(info:Object):void
		{
			_imageUrlDic[info.url] = (info.content as Bitmap).bitmapData;
			info.target.bitmapData = _imageUrlDic[info.url];
			var objArray:Array = _imageUrlObj[info.url];
			for (var i:int = 0; i < objArray.length; i++) 
			{
				if(objArray[i] != info.target){
					objArray[i].bitmapData = _imageUrlDic[info.url];
				}
			}
			_imageUrlObj[info.url] = null;
		}
		
		/**
		 * 删除引用对象
		 */		
		public static function delImageUrlObj(url:String,target:Bitmap):void{
			var key:String = MassLoader.getResourceUrl(url);
			var objArray:Array = _imageUrlObj[key];
			if(objArray != null){
				objArray.splice(objArray.indexOf(target),1);
			}
		}
	}
}

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.system.ApplicationDomain;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

import game.core.utils.MassLoader;

class ResObj
{
	private var url:String;
	private var packs:Dictionary = new Dictionary();
	private var config:Object;
	private var _disposed:Boolean = false;
	
	public function ResObj(url:String, priority:int)
	{
		this.url = url;
		MassLoader.add(this.url + "/config.gif", onLoaded, this, null, null, onIoError, priority);
	}
	
	private function onLoaded(info:Object):void
	{
		if(_disposed == false)
		{
			try
			{
				info.data.uncompress();
				config = info.data.readObject();
			}
			catch(error:Error)
			{
				throw new Error(info.url);
			}
		}
	}
	
	private function onIoError(info:Object):void
	{
	}
	
	public function getResource(action:String, way:int, rate:Number, priority:int):Object
	{
		if (config == null)
		{
			return null;
		}
		var actionObj:Object = config[action];
		if (actionObj == null && (action == "ready" || action == "sit") && config["stand"])
		{
			action = "stand";
			actionObj = config[action];
		}
		if (actionObj == null && (action == "skill" || action == "singfire")&& config["attack"])
		{
			action = "attack";
			actionObj = config[action];
		}
		if (actionObj == null)
		{
			return null;
		}
		var pack:String = actionObj.pack;
		var packObj:Object = packs[pack]; 
		if (packObj == null)
		{
			packObj = new Pack(url, pack, priority);
			packs[pack] = packObj;
		}
		var count:int = actionObj.count;
		var index:int = actionObj.start + way * count + rate * count;
		return packObj.getResource(index, actionObj.rect[index]);
	}
	
	public function getConfig(url:String, action:String, property:String):Object
	{
		if (!config || !config[action])
			return null;
		return config[action][property];
	}
	
	public function dispose():void
	{
		_disposed = true;
		config = null;
		for(var key:String in packs)
		{
			var pack:Pack = packs[key];
			pack.dispose();
		}
		packs = null;
	}
}

class Pack
{
	private var imageArr:Array = [];
	private var domain:ApplicationDomain;
	
	public function Pack(url:String, pack:String, priority:int)
	{
		MassLoader.add(url + "/" + pack + ".swf", onLoad, url, null, null, null, priority);
	}
	
	private function onLoad(info:Object):void
	{
		domain = info.applicationDomain;
	}
	
	public function getResource(index:int, point:Array):Object
	{
		var imageObj:Object = imageArr[index];
		if (domain == null && imageObj == null)
		{
			return null;
		}
		if (imageObj == null)
		{
			imageObj = {index: index, bitmapData: new (domain.getDefinition("_" + index) as Class)(0, 0), x: point[0], y: point[1]};
			imageArr[index] = imageObj;
		}
		return imageObj;
	}
	
	public function dispose():void
	{
		for each(var imageObj:Object in imageArr)
		{
			imageObj.bitmapData.dispose();
		}
		imageArr = null;
	}
}

class Reference
{
	public var url:String = "";
	public var count:int;
	public var releaseTime:int; //引用计数为零的时刻
	
	private static var pool:Array = new Array();
	
	public static function getInstance():Reference
	{
		return pool.length > 0 ? pool.shift() : new Reference();
	}
	
	public function Reference()
	{
		
	}
	
	public function dispose():void
	{
		url = "";
		count = 0;
		releaseTime = 0;
		pool.push(this);
	}
}
