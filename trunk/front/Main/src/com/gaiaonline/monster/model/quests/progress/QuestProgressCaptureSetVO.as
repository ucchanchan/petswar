//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model.quests.progress {
    import __AS3__.vec.*;

    public class QuestProgressCaptureSetVO implements QuestProgressVO {

        private var _type:String;// = "CAPTURE"
        public var monsters:Vector.<QuestProgressCaptureVO>;

        public function QuestProgressCaptureSetVO(_arg1:Object){
            var _local2:String;
            super();
            this.monsters = new Vector.<QuestProgressCaptureVO>();
            for (_local2 in _arg1) {
                this.monsters.push(new QuestProgressCaptureVO(_local2, _arg1[_local2]));
            };
        }
        public function get type():String{
            return (this._type);
        }
        public function get progressSummaryText():String{
            return (String(this.length));
        }
        public function get length():uint{
            var _local2:QuestProgressCaptureVO;
            var _local1:uint;
            for each (_local2 in this.monsters) {
                _local1 = (_local1 + uint(_local2.captureCount));
            };
            return (_local1);
        }

    }
}//package com.gaiaonline.monster.model.quests.progress 
