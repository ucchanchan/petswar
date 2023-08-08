//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model.quests.goals {
    import __AS3__.vec.*;

    public class QuestGoalsCaptureSetVO implements QuestGoalsVO {

        private var _type:String;// = "CAPTURE"
        public var monsters:Vector.<QuestGoalsCaptureVO>;

        public function QuestGoalsCaptureSetVO(_arg1:Object){
            var _local2:String;
            super();
            this.monsters = new Vector.<QuestGoalsCaptureVO>();
            for (_local2 in _arg1) {
                this.monsters.push(new QuestGoalsCaptureVO(_local2, _arg1[_local2]));
            };
        }
        public function get type():String{
            return (this._type);
        }
        public function get goalsSummaryText():String{
            var _local2:QuestGoalsCaptureVO;
            var _local1:uint;
            for each (_local2 in this.monsters) {
                _local1 = (_local1 + uint(_local2.needed));
            };
            return (String(_local1));
        }
        public function get length():uint{
            return ((this.monsters) ? this.monsters.length : 0);
        }

    }
}//package com.gaiaonline.monster.model.quests.goals 
