//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model.quests.goals {
    import __AS3__.vec.*;

    public class QuestGoalsItemSetVO implements QuestGoalsVO {

        private var _type:String;// = "ITEM"
        public var items:Vector.<QuestGoalsItemVO>;

        public function QuestGoalsItemSetVO(_arg1:Object){
            var _local2:String;
            super();
            this.items = new Vector.<QuestGoalsItemVO>();
            for (_local2 in _arg1) {
                this.items.push(new QuestGoalsItemVO(_local2, _arg1[_local2]));
            };
        }
        public function get type():String{
            return (this._type);
        }
        public function get goalsSummaryText():String{
            return (String(this.length));
        }
        public function get length():uint{
            var _local2:QuestGoalsItemVO;
            var _local1:uint;
            for each (_local2 in this.items) {
                _local1 = (_local1 + uint(_local2.needed));
            };
            return (_local1);
        }

    }
}//package com.gaiaonline.monster.model.quests.goals 
