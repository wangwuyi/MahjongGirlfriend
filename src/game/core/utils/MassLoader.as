package game.core.utils
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	public class MassLoader
	{
		public static const LOW:int 	= 0;
		public static const MEDIUM:int 	= 10;
		public static const HIGH:int 	= 20;
		
		public static const MAX_PARALLEL_NUM:int = 3;
		private static const FILE_REGEXP:RegExp = /\.swf|\.jpg|\.gif|\.mp3/;
		
		private static var loaderPool:Array = [];
		private static var decoderPool:Array = [];
		private static var infoPool:Array = [];
		
		private static var urlMap:Dictionary = new Dictionary();
		private static var request:URLRequest = new URLRequest();
		private static var loadlist:Array = [];
		private static var decodelist:Array = [];
		private static var urlVersionDic:Dictionary;
		
		/*资源路径*/
		public static var resHost:String;
		
		public static function init(res:String, urlVersionDic:Dictionary):void
		{
			resHost = res;
			MassLoader.urlVersionDic = urlVersionDic;
			for (var i:int = 0; i < MAX_PARALLEL_NUM; i++)
			{
				var loader:MyLoader = new MyLoader();
				loader.dataFormat = URLLoaderDataFormat.BINARY;
				loader.addEventListener(Event.OPEN, openHandler);
				loader.addEventListener(Event.COMPLETE, completeHandler);
				loader.addEventListener(ProgressEvent.PROGRESS, progressHandler);
				loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);				
				loaderPool.push(loader);
				var decoder:MyDecode = new MyDecode();
				decoder.contentLoaderInfo.addEventListener(Event.COMPLETE, decoderComplete);
				decoderPool.push(decoder);
			}
		}
		
		public static function add(url:String, complete:Function, target:Object = null, progress:Function = null, onStart:Function = null, IOError:Function = null, level:int = MEDIUM, domain:ApplicationDomain = null, isFixedUrl:Boolean = false):void
		{
			url = getResourceUrl(url);
			var info:Object = infoPool.length ? infoPool.pop() : {};
			info.url = url;
			info.isFixedUrl = isFixedUrl;
			info.complete = complete;
			info.target = target;
			info.level = level;
			info.progress = progress;
			info.onStart = onStart;
			info.IOError = IOError;
			info.isEmbedImage = false;
			info.domain = domain;
			doAdd(url, info);
		}
		
		//专门给ResoureManager.getBitmap使用，兼容加载png,jpeg，内嵌图片的swf
		public static function addImage(url:String, complete:Function, target:Object = null, progress:Function = null, IOError:Function = null, level:int = MEDIUM):void
		{
			url = getResourceUrl(url);
			var info:Object = infoPool.length ? infoPool.pop() : {};
			info.url = url;
			info.complete = complete;
			info.target = target;
			info.level = level;
			info.progress = progress;
			info.IOError = IOError;
			info.domain = null;
			if (url.match(/\.png|\.jpg/) != null)
			{
				info.isEmbedImage = false;
			}
			else
			{
				info.isEmbedImage = true;
			}
			doAdd(url, info);
		}
		
		private static function doAdd(url:String, info:Object):void
		{
			Utils.log("Load resource: " + url, Utils.LOG_INFO);
			var cookieData:ByteArray = FileStorage.getFile(url);
			if (cookieData)
			{
				if (needDecode(url))
				{
					info.data = cookieData;
					if (urlMap[info.url])
					{
						urlMap[info.url].push(info);
					}
					else
					{
						urlMap[info.url] = [info];
						decodelist.push(info);
						decode();
					}
				}
				else
				{
					info.data = makeByteArrayCopy(cookieData);
					if(info.complete != null)
					{
						info.complete(info);
					}
				}
			}
			else
			{
				if (urlMap[info.url] != null)
				{
					//同时多个加载
					urlMap[info.url].push(info);
				}
				else
				{
					urlMap[info.url] = [info];
					loadlist.push(info);
					start();
				}
			}
		}
		
		public static function getResourceUrl(url:String):String
		{
			var trueUrl:String = url;
			var version:int = urlVersionDic[trueUrl];
			if(version > 0)
			{
				var result:Array = trueUrl.match(FILE_REGEXP);
				if(result != null)
				{
					var postfix:String = result[0];//.swf
					var token:String =  postfix + "?v" + version;//.swf?v1
					trueUrl = trueUrl.replace(postfix, token);//xxx.swf?v1
				}
			}
			return trueUrl;
		}
		
		private static function start():void
		{
			if (loaderPool.length == 0)
			{
				return;
			}
			var loader:MyLoader;
			if(loadlist.length > 0)
			{
				loadlist.sortOn("level", Array.NUMERIC);
				loader = loaderPool.pop();
				loader.info = loadlist.pop();
				request.url = getRequestUrl(loader.info);
				loader.load(request);
			}
			else
			{
				var preloadUrl:String = MassPreloader.getResourceUrl();
				if(preloadUrl != null)
				{
					add(preloadUrl, null, null, null, null, null, LOW);
					start();
				}
			}
		}
		
		private static function getRequestUrl(info:Object):String
		{
			if(info.isFixedUrl){
				return info.url;
			}
			return resHost + info.url;
		}
		
		private static function openHandler(e:Event):void
		{
			var loader:MyLoader = e.target as MyLoader;
			var info:Object = loader.info;
			if (info.onStart)
			{
				info.onStart(e);
			}
		}
		
		private static function completeHandler(e:Event):void
		{
			var loader:MyLoader = e.target as MyLoader;
			var info:Object = loader.info;
			info.data = loader.data;
			if (needDecode(info.url))
			{
				FileStorage.addFile(info.url, info.data);
				decodelist.push(info);
				decode();
			}
			else
			{
				FileStorage.addFile(info.url, makeByteArrayCopy(info.data));
				var infoList:Array = urlMap[info.url];
				while (infoList.length)
				{
					var tempInfo:Object = infoList.shift();
					if(tempInfo.complete != null)
					{
						tempInfo.complete(info);
					}
				}
				delete urlMap[info.url];
				infoPool.push(info);
			}
			loaderPool.push(loader);
			start();
		}
		
		private static function makeByteArrayCopy(data:ByteArray):ByteArray
		{
			var result:ByteArray = new ByteArray();
			data.readBytes(result);
			data.position = 0;
			return result;
		}
		
		/**
		 * 是否swf、png、jpg 
		 * @param url
		 * @return 
		 * 
		 */		
		private static function needDecode(url:String):Boolean
		{
			return url.match(/\.swf|\.png|\.jpg/) != null
		}
		
		private static function progressHandler(e:ProgressEvent):void
		{
			if (e.target.info.progress)
				e.target.info.progress(e);
		}
		
		private static function errorHandler(e:IOErrorEvent):void
		{
			var loader:MyLoader = e.target as MyLoader;
			Utils.log("MassLoader IO_ERROR: " + loader.info.url, Utils.LOG_ERR);
			Utils.log(e.text, Utils.LOG_ERR);
			if (loader.info.IOError)
			{
				loader.info.IOError(loader.info);
			}
			loader.close();
			loaderPool.push(loader);
			start();
		}
		
		/**
		 *二进制数据加载 
		 * 
		 */		
		private static function decode():void
		{
			if (!decoderPool.length || !decodelist.length)
				return;
			decodelist.sortOn("level", Array.NUMERIC);
			var decoder:MyDecode = decoderPool.pop();
			decoder.info = decodelist.shift();
			if(decoder.info.domain != null)
			{
				//放入指定的领域
				var loaderContext:LoaderContext = new LoaderContext(false, decoder.info.domain);
				decoder.loadBytes(decoder.info.data,loaderContext);
			}
			else
			{
				decoder.loadBytes(decoder.info.data);
			}
		}
		
		private static function decoderComplete(e:Event):void
		{
			var decoder:MyDecode = e.target.loader as MyDecode;
			var info:Object = decoder.info;
			var infoList:Array = urlMap[info.url];
			while (infoList.length)
			{
				info = infoList.shift();
				//是否嵌入图片
				if (info.isEmbedImage == true)
				{
					var clz:Class = decoder.contentLoaderInfo.applicationDomain.getDefinition("Image") as Class;
					info.content = new Bitmap(new clz() as BitmapData);
				}
				else
				{
					info.content = decoder.content;
				}
				info.applicationDomain = decoder.contentLoaderInfo.applicationDomain;
				if(info.complete != null)
				{
					info.complete(info);
				}
				infoPool.push(info);
			}
			delete urlMap[info.url];
			decoderPool.push(decoder);
			decode();
		}
	}
}

import flash.display.Loader;
import flash.net.URLLoader;

class MyLoader extends URLLoader
{
	public var info:Object;
}

class MyDecode extends Loader
{
	
	public var info:Object;
}
