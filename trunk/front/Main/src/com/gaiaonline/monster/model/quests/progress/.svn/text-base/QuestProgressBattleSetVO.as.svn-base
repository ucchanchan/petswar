//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model.quests.progress {
    import __AS3__.vec.*;

    public class QuestProgressBattleSetVO implements QuestProgressVO {

        private var _type:String;// = "BATTLE"
        public var locations:Vector.<QuestProgressLocationVO>;

        public function QuestProgressBattleSetVO(_arg1:Object){
            var _local2:String;
            var _local3:String;
            super();
            this.locations = new Vector.<QuestProgressLocationVO>();
            for (_local2 in _arg1) {
                for each (_local3 in _arg1[_local2]) {
                    this.locations.push(new QuestProgressLocationVO(_local2, _local3));
                };
            };
        }
        public function get type():String{
            return (this._type);
        }
        public function get progressSummaryText():String{
            return (String(this.locations.length));
        }
        public function get length():uint{
            return ((this.locations) ? this.locations.length : 0);
        }

    }
}//package com.gaiaonline.monster.model.quests.progress 
