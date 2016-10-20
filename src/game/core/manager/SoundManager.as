package game.core.manager
{
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import game.core.utils.MassLoader;
	import game.core.utils.Utils;
	
	public class SoundManager
	{
		public static const DEFAULT_VOLUME:Number = 0.4;
		
		private static var urlRequest:URLRequest = new URLRequest();
		private static var soundTheme:Sound;
		private static var soundThemeChannel:SoundChannel;
		private static var isStopTheme:Boolean;
		private static var isStopMix:Boolean;
		private static var _id:int;
		private static var buffer:SoundLoaderContext = new SoundLoaderContext(5000);
		private static var soundTransform:SoundTransform = new SoundTransform(DEFAULT_VOLUME);
		private static var mixTransform:SoundTransform = new SoundTransform(DEFAULT_VOLUME)
		
		private static var delayIndex:int;
		private static var firstEnterWorld:Boolean = true;
		
		private static var _soundDic:Dictionary = new Dictionary();
				
		//播放一些小音效
		public static function play(type:String, id:int, isLoop:Boolean = false):void
		{
			var key:String = type + "_" + id;
			var sound:Sound;
			if(_soundDic[key] != null)
			{
				sound = _soundDic[key];
				try
				{
					var soundChannel:SoundChannel = sound.play();
					if(soundChannel != null)
					{
						soundChannel.soundTransform = mixTransform;
					}
				}
				catch(e:Error)
				{
					//ignore error
				}
			}
			else
			{
				sound = new Sound();
				sound.addEventListener(Event.COMPLETE, onLoadComplete);
				sound.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
				urlRequest.url = MassLoader.resHost + MassLoader.getResourceUrl("assets/resource/sound/" + type + "/" + id + ".mp3");
				sound.load(urlRequest);
				_soundDic[key] = sound;
			}
		}
		
		public static function playTheme(id:int):void
		{
			_id = id;
			if (delayIndex > 0)
			{
				clearTimeout(delayIndex);
			}
			if(firstEnterWorld == true)
			{
				firstEnterWorld = false;
				delayIndex = setTimeout(doPlayTheme, 5000); //首次进入游戏，延迟5秒加载场景背景音乐
			}
			else
			{
				doPlayTheme();
			}
		}
		
		private static function doPlayTheme():void
		{
			delayIndex = 0;
			if(isStopTheme == false)
			{
				stopThemePlay();
				closeThemePlay();
				urlRequest.url = MassLoader.resHost + MassLoader.getResourceUrl("assets/resource/sound/" + _id + ".mp3");
				soundTheme = new Sound(urlRequest, buffer);
				soundTheme.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
				var soundChannel:SoundChannel = soundTheme.play(0, 99999999);
				if (soundChannel != null)
				{
					soundThemeChannel = soundChannel;
					soundThemeChannel.soundTransform = soundTransform;
				}
			}
		}
		
		private static function stopThemePlay():void
		{
			if(soundThemeChannel != null)
			{
				soundThemeChannel.stop();
			}
		}
		
		private static function closeThemePlay():void
		{
			if(soundTheme != null)
			{
				try
				{
					soundTheme.close();
				}
				catch(e:Error)
				{
					//ignore error
				}
			}
		}
		
		public static function set stopMix(value:Boolean):void
		{
			isStopMix = value;
			mixTransform.volume = isStopMix ? 0 : 1;
		}
		
		public static function set stopTheme(value:Boolean):void
		{
			if(value == isStopTheme)
			{
				return;
			}
			isStopTheme = value;
			soundTransform.volume = isStopTheme ? 0 : 1;
			if(isStopTheme == true)
			{
				stopThemePlay();
				closeThemePlay();
			}
			else
			{
				doPlayTheme();
			}
		}
		private static function onLoadComplete(e:Event):void
		{
			var sound:Sound = e.target as Sound;
			sound.removeEventListener(Event.COMPLETE, onLoadComplete);
			sound.removeEventListener(IOErrorEvent.IO_ERROR, onLoadError);
			var soundChannel:SoundChannel = sound.play();
			if(soundChannel != null)
			{
				soundChannel.soundTransform = mixTransform;
			}
		}
		
		private static function onLoadError(e:IOErrorEvent):void
		{
			var sound:Sound = e.target as Sound;
			sound.removeEventListener(Event.COMPLETE, onLoadComplete);
			sound.removeEventListener(IOErrorEvent.IO_ERROR, onLoadError);
			Utils.log("Sound load error" + e.text, Utils.LOG_ERR);
		}
		
		public static function setThemeVolume(value:Number):void
		{
			soundTransform.volume = value;
			if(soundThemeChannel != null)
			{
				soundThemeChannel.soundTransform = soundTransform;
			}
		}
		
		public static function setMixVolume(value:Number):void
		{
			mixTransform.volume = value;
		}
	}
}
