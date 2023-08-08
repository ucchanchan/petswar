//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.monster.model {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.view.components.battle.vo.*;
    import com.gaiaonline.monster.service.*;

    public class MogaFactory {

        private var HANDLE_XP_AS_ABSOLUTE:Boolean = false;
        private var TRIM:RegExp;

		[Inject]
        public var actions:ActionsFactory;
		[Inject]
        public var text:TextService;
        private var map:Object;

        public function MogaFactory(){
            this.TRIM = /^[ \n\r]+|[ \n\r]+$/g;
            super();
            this.map = {};
        }
        public function create(_arg1:Object):MonsterModel{
            var _local2:String = _arg1.id;
            var _local3 = (_local2.charAt(0) == "n");
            var _local4:MonsterModel = this.map[_local2];
            var _local5:Boolean = ((_local3) || ((_local4 == null)));
            if (_local5){
                _local4 = this.innerCreate(_arg1);
                this.map[_local2] = _local4;
            } else {
                this.innerUpdate(_local4, _arg1);
            };
            return (_local4);
        }
        public function read(_arg1:String):MonsterModel{
            return (this.map[_arg1]);
        }
        public function update(_arg1:Object):MonsterModel{
            var _local2:String = _arg1.id;
            var _local3:MonsterModel = this.map[_local2];
            if (!_local3){
                return (null);
            };
            this.innerUpdate(_local3, _arg1);
            return (_local3);
        }
        public function dispose(_arg1:String):MonsterModel{
            var _local2:MonsterModel = this.map[_arg1];
            //delete ??getglobalscope [[_arg1]];
			//未解决的错误
			//delete null [[_arg1]];
            return (_local2);
        }
        private function innerCreate(_arg1:Object):MonsterModel{
            var _local2:MonsterModel;
            _local2 = new MonsterModel();
            var _local3:String = _arg1.id;
            var _local4:Object = _arg1.props;
            _local2.id = _local3;
            _local2.monsterID = _arg1.monster_id;
            _local2.name = (_arg1.name) ? _arg1.name.replace(this.TRIM, "") : "";
            _local2.hp = _arg1.hp;
            _local2.maxHP = (_local2.naturalMaxHP = int(_local4.hp));
            if (this.HANDLE_XP_AS_ABSOLUTE){
                _local2.xp = new ExperienceVO(_arg1.xp, _arg1.xp, (_arg1.xp + _arg1.xp_to_next_level), _arg1.level);
            } else {
                _local2.xp = new ExperienceVO(_arg1.xp, _arg1.xp_this_level, (_arg1.xp_this_level + _arg1.xp_to_next_level), _arg1.level);
            };
            _local2.actions = this.actions.create(_local3, _arg1.slot_contents);
            _local2.speed = _local4.speed;
            _local2.zodiac = _local4.zodiac_id;
            _local2.onTeam = int(_arg1.on_team);
            _local2.baseZodiacAttackStrength = _local4.zodiac_attack;
            _local2.baseZodiacDefenceStrength = _local4.zodiac_defense;
            _local2.basePhysicalAttackStrength = _local4.physical_attack;
            _local2.basePhysicalDefenceStrength = _local4.physical_defense;
            _local2.napTime = _local4.nap_time;
            _local2.napEndTime = int(_arg1.nap_end_time);
            _local2.isNapping = (_local2.napEndTime > 0);
            _local2.text = this.text.getMonsterText(_local2.monsterID);
            var _local5:Object = _arg1.battle_status;
            if (_local5){
                _local2.canTame = _local5.can_tame;
                this.updateBuffs(_local2, _arg1.battle_status);
            };
            _local2.inStorage = ((_arg1.storage_state) && ((_arg1.storage_state == 1)));
            return (_local2);
        }
        private function innerUpdate(_arg1:MonsterModel, _arg2:Object):void{
            _arg1.hp = _arg2.hp;
            _arg1.maxHP = _arg2.max_hp;
            if (this.HANDLE_XP_AS_ABSOLUTE){
                _arg1.xp.update(_arg2.xp, _arg2.xp, (_arg2.xp + _arg2.xp_to_next_level), ((_arg2.level) || (-1)));
            } else {
                _arg1.xp.update(_arg2.xp, _arg2.xp_this_level, (_arg2.xp_this_level + _arg2.xp_to_next_level), ((_arg2.level) || (-1)));
            };
            var _local3:Object = _arg2.battle_status;
            if (_local3){
                _arg1.canTame = _local3.can_tame;
                this.updateBuffs(_arg1, _arg2.battle_status);
            };
            _arg1.actions = this.actions.udpate(_arg1.id, _arg2.slot_contents);
        }
        private function updateBuffs(_arg1:MonsterModel, _arg2:Object):void{
            this.updateBuffsInner(_arg1, _arg2.props, _arg2.buffs);
            this.updateBuffsInner(_arg1, _arg2.props, _arg2.debuffs);
        }
        private function updateBuffsInner(_arg1:MonsterModel, _arg2:Object, _arg3:Object):void{
            var _local5:String;
            var _local6:Object;
            var _local7:uint;
            var _local8:BuffCountVO;
            var _local4:Object = _arg1.buffCounts;
            for (_local5 in _arg3) {
                _local6 = _arg2[_local5];
                _local7 = _local6.mod_type;
                _local8 = (_local4[_local5] = ((_local4[_local5]) || (this.generateCount(_local7, _local6))));
                _local8.count = _arg3[_local5];
            };
        }
        private function generateCount(_arg1:uint, _arg2:Object):BuffCountVO{
            var _local3:BuffVO = new BuffVO(BuffType.parse(_arg1), _arg2);
            return (new BuffCountVO(_local3));
        }

    }
}//package gaia.moga.monster.model 
