//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model.quests.progress {
    import __AS3__.vec.*;

    public class QuestProgressItemSetVO implements QuestProgressVO {

        private var _type:String;// = "ITEM"
        public var items:Vector.<QuestProgressItemVO>;

        public function QuestProgressItemSetVO(_arg1:Object){
            var _local2:String;
            super();
            this.items = new Vector.<QuestProgressItemVO>();
            for (_local2 in _arg1) {
                this.items.push(new QuestProgressItemVO(_local2, _arg1[_local2]));
            };
        }
        public function get type():String{
            return (this._type);
        }
        public function get progressSummaryText():String{
            return (String(this.length));
        }
        public function get length():uint{
            var _local2:QuestProgressItemVO;
            var _local1:uint;
            for each (_local2 in this.items) {
                _local1 = (_local1 + uint(_local2.found));
            };
            return (_local1);
        }

    }
}//package com.gaiaonline.monster.model.quests.progress 
