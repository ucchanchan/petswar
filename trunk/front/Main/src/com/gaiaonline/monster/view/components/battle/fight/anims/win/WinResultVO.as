//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.win {
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import gaia.moga.monster.model.actions.*;

    public class WinResultVO {

        public var moga:MonsterModel;
        public var asset:Asset;
        public var name:String;
        public var priorLevel:uint;
        public var priorXP:uint;
        public var gainedXP:uint;
        public var currentXP:uint;
        public var levelCeilingXP:uint;
        public var levelupReward:LevelupRewardVO;
        public var newSkillRewards:Vector.<ActionPropsVO>;

        public function WinResultVO(_arg1:MonsterModel, _arg2:Object){
            this.moga = _arg1;
            this.name = _arg1.name;
            var _local3:ExperienceVO = _arg1.xp;
            this.priorXP = _local3.priorValue;
            this.gainedXP = _local3.change;
            var _local4:Boolean = _arg2.leveled_up;
            if (_local4){
                this.currentXP = (this.levelCeilingXP = _local3.priorMax);
                this.priorLevel = _arg2.level;
            } else {
                this.currentXP = _local3.value;
                this.priorLevel = _local3.level;
                this.levelCeilingXP = _local3.max;
            };
            this.levelupReward = this.getLevelUpReward(_arg2.leveled_up);
            this.newSkillRewards = this.getNewSkills(_arg2.level_up_grants);
        }
        private function getLevelUpReward(_arg1:Object):LevelupRewardVO{
            return ((_arg1) ? new LevelupRewardVO(_arg1) : null);
        }
        private function getNewSkills(_arg1:Object):Vector.<ActionPropsVO>{
            var _local3:Object;
            var _local2:Vector.<ActionPropsVO> = new Vector.<ActionPropsVO>();
            for each (_local3 in _arg1) {
                _local2.push(new ActionPropsVO(_local3));
            };
            return (_local2);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.win 
