//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model.vo {
    import __AS3__.vec.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.model.quests.rewards.*;
    import com.gaiaonline.monster.model.quests.goals.*;
    import com.gaiaonline.monster.model.quests.*;
    import com.gaiaonline.monster.model.quests.progress.*;

    public class QuestVO {

        public var hasBeenCompleted:Boolean;
        public var isComplete:Boolean;
        public var isNew:Boolean;
        public var id:uint;
        public var type:QuestType;
        public var requirements:Vector.<QuestRequirementVO>;
        public var rewards:Vector.<QuestRewardVO>;
        public var progress:QuestProgressVO;
        public var goals:QuestGoalsVO;
        public var acceptStoryId:String;
        public var completeStoryId:String;

        public function QuestVO(_arg1:Object=null):void{
            var _local3:Object;
            super();
            if (!_arg1){
                return;
            };
            this.isNew = _arg1.accepted;
            this.isComplete = _arg1.is_complete;
            var _local2:Object = _arg1.props;
            if (_local2){
                this.id = uint(_local2.id);
                this.type = QuestType.parse(int(_local2.quest_type));
                this.requirements = this.parseRequirements(_local2.requirements_bundle);
                this.rewards = this.parseRewards(_local2.reward_bundle);
                this.goals = this.parseGoals(this.type, _local2.detail_bundle);
                _local3 = _local2.metadata_bundle;
                if (_local3){
                    this.acceptStoryId = _local3["as"];
                    this.completeStoryId = _local3["cs"];
                };
            };
            if (_arg1.progress_bundle){
                this.progress = this.parseProgress(this.type, _arg1.progress_bundle);
            };
            this.hasBeenCompleted = ((((_arg1.has_been_completed) || (this.isComplete))) || (((this.progress) ? this.progress.length : 0 >= (this.goals) ? this.goals.length : 0)));
        }
        public function parseGoals(_arg1:QuestType, _arg2:Object):QuestGoalsVO{
            switch (_arg1){
                case QuestType.LOCATION:
                    return (new QuestGoalsLocationSetVO(_arg2));
                case QuestType.MONSTER_HUNT:
                    return (new QuestGoalsKillSetVO(_arg2));
                case QuestType.ITEM_HUNT:
                    return (new QuestGoalsItemSetVO(_arg2));
                case QuestType.MONSTER_CAPTURE:
                    return (new QuestGoalsCaptureSetVO(_arg2));
                case QuestType.BATTLE:
                    return (new QuestGoalsBattleSetVO(_arg2));
                default:
                    throw (new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 104));
            };
        }
        public function parseProgress(_arg1:QuestType, _arg2:Object):QuestProgressVO{
            switch (_arg1){
                case QuestType.LOCATION:
                    return (new QuestProgressLocationSetVO(_arg2));
                case QuestType.MONSTER_HUNT:
                    return (new QuestProgressKillSetVO(_arg2));
                case QuestType.ITEM_HUNT:
                    return (new QuestProgressItemSetVO(_arg2));
                case QuestType.MONSTER_CAPTURE:
                    return (new QuestProgressCaptureSetVO(_arg2));
                case QuestType.BATTLE:
                    return (new QuestProgressBattleSetVO(_arg2));
                default:
                    throw (new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 105));
            };
        }
        private function parseRequirements(_arg1:Object):Vector.<QuestRequirementVO>{
            var _local3:Object;
            var _local2:Vector.<QuestRequirementVO> = new Vector.<QuestRequirementVO>();
            for each (_local3 in _arg1) {
                _local2.push(new QuestRequirementVO(_local3));
            };
            return (_local2);
        }
        private function parseRewards(_arg1:Object):Vector.<QuestRewardVO>{
            var _local3:String;
            var _local4:String;
            var _local5:Object;
            var _local2:Vector.<QuestRewardVO> = new Vector.<QuestRewardVO>();
            for (_local3 in _arg1) {
                _local5 = _arg1[_local3];
                switch (_local3){
                    case "c":
                        _local2.push(new QuestRewardCurrencyVO(int(_local5)));
                        break;
                    case "x":
                        _local2.push(new QuestRewardXPVO(int(_local5)));
                        break;
                    case "i":
                        for (_local4 in _local5) {
                            _local2.push(new QuestRewardItemVO(int(_local4), int(_local5[_local4])));
                        };
                        break;
                    case "m":
                        for (_local4 in _local5) {
                            _local2.push(new QuestRewardMonsterVO(int(_local4), int(_local5[_local4])));
                        };
                        break;
                };
            };
            return (_local2);
        }

    }
}//package com.gaiaonline.monster.model.vo 
