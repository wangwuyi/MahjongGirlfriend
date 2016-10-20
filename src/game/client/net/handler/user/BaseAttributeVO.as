package game.client.net.handler.user
{
	import game.client.module.ui.systemtip.SystemTip;

	public class BaseAttributeVO
	{
		public var objid:int;
		public var rolename:String;
		public var sex:int;
		public var job:int;
		/**阵营*/
		public var camp:int;
		/**帮会*/
		public var guildName:String;
		private var _level:int;
		public var status:int;
		public var sceneX:int;
		public var sceneY:int;
		public var targetPos:Array;
		public var targetDirection:int;
		public var maxhp:int;
		public var maxmp:int;
		private var _hp:int;
		private var _mp:int;
		public var speed:int;
		public var alphaNum:int;
		/**
		 *当前的称号 
		 */		
		public var title:Array;
		
		public function set hp(value:int):void
		{
			this._hp = value;
		}
		
		public function get hp():int
		{
			return this._hp;
		}
		
		public function set mp(value:int):void
		{
			this._mp = value;
		}
		
		public function get mp():int
		{
			return this._mp;
		}
		
		public function set level(value:int):void
		{
			this._level = value;
		}
		
		public function get level():int
		{
			return this._level;
		}
		
		/**形象Id*/
		public var bodyId:int;
		
		/**
		 经验值
		 * */
		private var _exp:int;
		
		public function get exp():int
		{
			return _exp;
		}
		
		public function set exp(i:int):void
		{
			var add:int = i - _exp;
			if(_exp > 0 && add > 0)
			{
//				SystemTip.addMsg("获得经验：" + add);
			}
			_exp = i;
		}
		
		/**
		 灵力值
		 * */
		private var _lingli:int;
		
		public function get lingli():int
		{
			return _lingli;
		}
		
		public function set lingli(i:int):void
		{
			var add:int = i - _lingli;
			if(_lingli > 0 && add > 0)
			{
//				SystemTip.addMsg("获得灵力：" + add);
			}
			_lingli = i;
		}
		
		/**
		 元宝 
		 * */
		public var rmb:int;
		/**
		 绑定元宝 
		 * */
		public var bindrmb:int;
		/**
		 铜币 
		 * */
		public var money:int;
		/**
		 绑定铜币 
		 * */
		public var bindmoney:int;
		/**
		 攻击力 
		 * */
		public var atk:int;
		/**
		 防御力 
		 * */
		public var def:int;
		/**
		 闪避 
		 * */
		public var dodge:int;
		/**
		 命中
		 * */
		public var hitrate:int;
		/**
		 暴击
		 * */
		public var bash:int;
		/**
		 坚韧
		 * */
		public var tough:int;
		/**
		 攻速
		 * */
		public var atkSpeed:int;
		/**
		 抗性A 
		 * */
		public var defA:int;
		/**
		 抗性B
		 * */
		public var defB:int;
		/**
		 抗性C
		 * */
		public var defC:int;
		
		/**
		 是否跳跃
		 * */
		public var isJump:int;
		
		/**
		 *双修对象的名字 
		 */		
		public var friendSit:String;
		
		/**
		 * 坐骑形象id
		 */
		public var horseIcon:int;
		
		/**
		 * 翅膀形象
		 */
		public var wing:int;
		
		/**
		 * 坐骑显示强化值
		 */
		public var horsePower:int;
		
		/**
		 *修为 
		 */		
		public var xiuWei:int;
		
		/**
		 * 怒气
		 */		
		public var anger:int;
		
		/**
		 * 是否是魂
		 * 1 --- 是
		 * 0 --- 不是  
		 */
		public var isSoul:int;
		
		
		/**
		 *战斗力 
		 */		
		public var fightValue:int;
		
		public function BaseAttributeVO()
		{
		}
	}
}