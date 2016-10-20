package game.client.utils
{
        import flash.display.DisplayObject;
        import flash.filters.GlowFilter;
        
        import game.core.utils.Timer;

		/**
		 * 滤镜特效 
		 * @author wwy
		 * 
		 */		
        public class GlowTween
        {
				/**
				 *目标对象 
				 */			
                private var _target:DisplayObject; 
				/**
				 *光晕颜色 
				 */				
				private var _color:Number;
				/**
				 *颜色的 Alpha 透明度值
				 */				
				private var _alpha:Number;
				/**
				 *水平或垂直模糊量
				 */				
				private var _blur:Number;
				/**
				 *水平或垂直模糊量最小值 
				 */				
				private var _blurMin:Number;
				/**
				 *水平或垂直模糊量最大值
				 */				
				private var _blurMax:Number;
				/**
				 *印记或跨页的强度 
				 */				
				private var _strength:Number;
				/**
				 *应用滤镜的次数 
				 */				
				private var _quality:Number;
				/**
				 *是否为内侧发光 
				 */				
				private var _inner:Boolean;
				/**
				 *是否具有挖空效果 
				 */				
				private var _knockout:Boolean;
				
				private var isAdd:Boolean;

				/**
				 * 添加滤镜动画 
				 * @param target	目标对象 
				 * @param color		光晕颜色 
				 * @param alpha		颜色的 Alpha 透明度值
				 * @param blurX		水平模糊量 
				 * @param blurY		垂直模糊量 
				 * @param strength	印记或跨页的强度 
				 * @param quality	应用滤镜的次数 
				 * @param inner		是否为内侧发光 
				 * @param knockout	是否具有挖空效果
				 * 
				 */							
                public function startGlow(target:DisplayObject,color:uint = 0xFF0000, alpha:Number = 1.0, blurMin:Number = 6, blurMax:Number = 15, strength:Number = 2, quality:int = 1, inner:Boolean = false, knockout:Boolean = false):void
                {
					if(target==null)return;
					_target=target;
					_color=color;
					_alpha=alpha;
					_blur=blurMin;
					_blurMin=blurMin;
					_blurMax=blurMax;
					_strength=strength;
					_quality=quality;
					_inner=inner;
					_knockout=knockout;
					Timer.add(blinkHandler);
                }

				/**
				 * 停止滤镜
				 */				
                public function stopGlow():void
                {
					if(_target){
						Timer.remove(blinkHandler);
                        _target.filters=null;
						_target = null;
					}
                }
				
				/**
				 * 是否滤镜中 
				 * @return 
				 * 
				 */				
				public function running():Boolean{
					return _target != null;
				}
				
                private function blinkHandler(now:int):void
                {
                        if (_blur >= _blurMax)
							isAdd = false;
                        else if(_blur <= _blurMin){
							isAdd = true;
						}
						isAdd?_blur++:_blur--;
                        _target.filters = [new GlowFilter(_color, _alpha, _blur, _blur, _strength, _quality, _inner, _knockout)];
                }
        }
}