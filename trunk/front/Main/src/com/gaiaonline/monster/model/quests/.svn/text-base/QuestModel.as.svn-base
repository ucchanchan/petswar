//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model.quests {
    import com.gaiaonline.monster.model.vo.*;
    import org.osflash.signals.*;
    import __AS3__.vec.*;

    public class QuestModel {

        public var newQuests:Vector.<QuestVO>;
        public var completeQuests:Vector.<QuestVO>;
        public var pastCompletedQuests:Vector.<QuestVO>;
        public var currentQuests:Vector.<QuestVO>;
        public var questListUpdated:Signal;
        private var _initialized:Boolean;// = false

        public function init(_arg1:Object):void{
            var _local2:Object;
            var _local3:QuestVO;
            this.newQuests = new Vector.<QuestVO>();
            this.completeQuests = new Vector.<QuestVO>();
            this.currentQuests = new Vector.<QuestVO>();
            this.pastCompletedQuests = new Vector.<QuestVO>();
            this.questListUpdated = new Signal();
            for (_local2 in _arg1) {
                _local3 = new QuestVO(_arg1[_local2]);
                if (_local3.isNew){
                    this.newQuests.push(_local3);
                } else {
                    if (_local3.isComplete){
                        this.completeQuests.push(_local3);
                    } else {
                        if (_local3.hasBeenCompleted){
                            this.pastCompletedQuests.push(_local3);
                        } else {
                            this.currentQuests.push(_local3);
                        };
                    };
                };
            };
            this._initialized = true;
            this.questListUpdated.dispatch(this.questCount);
        }
        public function get isInitialized():Boolean{
            return (this._initialized);
        }
        public function get questCount():int{
            return ((this.currentQuests.length + this.newQuests.length));
        }
        public function getQuestById(_arg1:uint):QuestVO{
            var _local2:QuestVO;
            for each (_local2 in this.newQuests.concat(this.completeQuests).concat(this.currentQuests).concat(this.pastCompletedQuests)) {
                if (_local2.id == _arg1){
                    return (_local2);
                };
            };
            return (null);
        }

    }
}//package com.gaiaonline.monster.model.quests 
