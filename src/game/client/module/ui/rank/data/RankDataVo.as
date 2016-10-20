package game.client.module.ui.rank.data
{
	public class RankDataVo
	{
		public var rank:int;
		public var vip_level:int;
		public var name:String;
		public var sex:int;
		public var job:int;
		public var guild_name:String;
		public var level:int;
		public var camp:int;
		public var owner:String;
		public var owner_sex:int;
		public var owner_job:int;
		
		/**
		 * 角色相关变值 
		 */		
		public var person_value:int;
		/**
		 * 装备相关变值 
		 */		
		public var equip_value:int;
		/**
		 * 坐骑相关变值
		 */		
		public var mount_value:int;
		/**
		 * 宠物相关变值
		 */		
		public var pet_value:int;
		/**
		 * 排行榜类型 
		 */		
		public var rank_type:int;
		/**
		 * 获取当前选中排行榜名称 
		 */		
		public function get rankName():String
		{
			var type:int = rank_type/1000;
			var subtype:int = rank_type%1000;
			return RankType.RANK_SUB_TYPES[type-1][subtype-1];
		}
		
		public function get sexName():String
		{
			if(sex == 1)
				return "男";
			return "女";
		}
		
		public function get careerName():String
		{
			switch(job)
			{
				case 1:
					return "武灵";
				case 2:
					return "法尊";
				case 3:
					return "修罗";
			}
			return "无";
		}
		
		public function initHumanData(arr:Array):void
		{
			rank = arr[0];
			vip_level = arr[1];
			name = arr[2];
			sex = arr[3];
			job = arr[4];
			guild_name = arr[5];
			camp = arr[6];
			person_value = arr[7];
		}
		
		public function initEquipData(arr:Array):void
		{
			rank = arr[0];
			name = arr[1];
			level = arr[2];
			equip_value = arr[3];
			camp = arr[4];
			owner = arr[5];
			owner_sex = arr[6];
			owner_job = arr[7];
		}
		
		public function initMountData(arr:Array):void
		{
			rank = arr[0];
			name = arr[1];
			mount_value = arr[2];
			camp = arr[3];
			owner = arr[4];
			owner_sex = arr[5];
			owner_job = arr[6];
		}
		
		public function initPetData(arr:Array):void
		{
			rank = arr[0];
			name = arr[1];
			pet_value = arr[2];
			camp = arr[3];
			owner = arr[4];
			owner_sex = arr[5];
			owner_job = arr[6];
		}
		
		public function RankDataVo()
		{
		}
		
		public static function getHumanDatas(arr:Array):Array
		{
			var result:Array = [];
			for each(var data:Array in arr)
			{
				var item:RankDataVo = new RankDataVo();
				item.initHumanData(data);
				result.push(item);
			}
			return result;
		}
		
		public static function getEquipDatas(arr:Array):Array
		{
			var result:Array = [];
			for each(var data:Array in arr)
			{
				var item:RankDataVo = new RankDataVo();
				item.initEquipData(data);
				result.push(item);
			}
			return result;
		}
		
		public static function getMountDatas(arr:Array):Array
		{
			var result:Array = [];
			for each(var data:Array in arr)
			{
				var item:RankDataVo = new RankDataVo();
				item.initMountData(data);
				result.push(item);
			}
			return result;
		}
		
		public static function getPetDatas(arr:Array):Array
		{
			var result:Array = [];
			for each(var data:Array in arr)
			{
				var item:RankDataVo = new RankDataVo();
				item.initPetData(data);
				result.push(item);
			}
			return result;
		}
		
		public static function getMyDatas(arr:Array):Array
		{
			var result:Array = [];
			for each(var data:Array in arr)
			{
				var item:RankDataVo = new RankDataVo();
				item.rank = data[0];
				item.rank_type = data[1];
				result.push(item);
			}
			return result;
		}
	}
}