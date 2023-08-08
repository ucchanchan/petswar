//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model.quests.goals {
    import __AS3__.vec.*;

    public class QuestGoalsLocationSetVO implements QuestGoalsVO {

        private var _type:String;// = "LOCATION"
        public var locations:Vector.<QuestGoalsLocationVO>;

        public function QuestGoalsLocationSetVO(_arg1:Object){
            var _local2:String;
            var _local3:String;
            super();
            this.locations = new Vector.<QuestGoalsLocationVO>();
            for (_local2 in _arg1) {
                for each (_local3 in _arg1[_local2]) {
                    this.locations.push(new QuestGoalsLocationVO(_local2, _local3));
                };
            };
        }
        public function get type():String{
            return (this._type);
        }
        public function get goalsSummaryText():String{
            return (String(this.locations.length));
        }
        public function get length():uint{
            return ((this.locations) ? this.locations.length : 0);
        }

    }
}//package com.gaiaonline.monster.model.quests.goals 
