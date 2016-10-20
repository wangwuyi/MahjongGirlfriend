package game.client.data.dataBase
{
      import flash.utils.Dictionary;
      public class AchieveListConfig
      {
        /**
         * id
         */
        public var id:int;
        /**
         * 名称
         */
        public var name:String;
        /**
         * 成就礼包id集合
         */
        public var reward:Array;
        public function AchieveListConfig(data:Array)
        {
            id = data[0];
            name = data[1];
            reward = data[2];
        }
        private static var _data:Array = [
            [1, "角色成就", [205012,205013,205014,205015,205016], ],
            [2, "宠物成就", [205017,205018,205019,205020,205021], ],
            [3, "任务成就", [205022,205023,205024,205025,205026], ],
            [4, "装备成就", [205027,205028,205029,205030,205031], ],
            [5, "试炼成就", [205037,205038,205039,205040,205041], ],
            [6, "隐藏成就", [205037,205038,205039,205040,205041], ],
        ];
        private static function InitData(): Dictionary
        {
            var dic:Dictionary = new Dictionary();
            for (var i:int = 0; i < _data.length; i++)
            {
                var data:Array = (_data[i] as Array);
                dic[data[0]] = new AchieveListConfig(data);
            }
            return dic;
        }
        public static var configData:Dictionary = InitData();
    }
}
