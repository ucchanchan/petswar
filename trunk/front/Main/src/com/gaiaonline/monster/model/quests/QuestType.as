//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model.quests {

    public class QuestType {

        private var _id:uint;

        public static const MONSTER_HUNT:QuestType = new QuestType(1);
;
        public static const ITEM_HUNT:QuestType = new QuestType(2);
;
        public static const LOCATION:QuestType = new QuestType(3);
;
        public static const MONSTER_CAPTURE:QuestType = new QuestType(4);
;
        public static const BATTLE:QuestType = new QuestType(5);
;

        public function QuestType(_arg1:uint){
            this._id = _arg1;
        }
        public function get id():uint{
            return (this._id);
        }

        public static function parse(_arg1:int):QuestType{
            switch (_arg1){
                case 1:
                    return (MONSTER_HUNT);
                case 2:
                    return (ITEM_HUNT);
                case 3:
                    return (LOCATION);
                case 4:
                    return (MONSTER_CAPTURE);
                case 5:
                    return (BATTLE);
            };
            return (null);
        }

    }
}//package com.gaiaonline.monster.model.quests 
