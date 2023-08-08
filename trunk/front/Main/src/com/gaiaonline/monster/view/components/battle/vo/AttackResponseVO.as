//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.vo {
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.win.*;

    public class AttackResponseVO {

        public var id:uint;
        public var modKill:Boolean;
        public var player:MonsterModel;
        public var npc:MonsterModel;
        private var battleTeam:BattleTeamModel;
        public var playerAttack:AttackResultVO;
        public var npcAttack:AttackResultVO;
        public var newUserBuffsOnUser:Vector.<BuffVO>;
        public var newUserBuffsOnNPC:Vector.<BuffVO>;
        public var newNPCBuffsOnUser:Vector.<BuffVO>;
        public var newNPCBuffsOnNPC:Vector.<BuffVO>;
        public var newUserDebuffsOnUser:Vector.<BuffVO>;
        public var newUserDebuffsOnNPC:Vector.<BuffVO>;
        public var newNPCDebuffsOnUser:Vector.<BuffVO>;
        public var newNPCDebuffsOnNPC:Vector.<BuffVO>;
        public var existingBuffsFromUserAttacking:Vector.<BuffResultVO>;
        public var existingBuffsFromNPCAttacking:Vector.<BuffResultVO>;
        public var existingBuffsFromUserTakingDamage:Vector.<BuffResultVO>;
        public var existingBuffsFromNPCTakingDamage:Vector.<BuffResultVO>;
        public var existingUserBuffsFromRound:Vector.<BuffResultVO>;
        public var existingNPCBuffsFromRound:Vector.<BuffResultVO>;
        public var rewards:Vector.<WinResultVO>;
        public var itemGranted:Object;
        public var collectionID:uint;

        public static const MOD_RESULT_RECIPIENT_OPPONENT:String = "1";
        public static const MOD_RESULT_RECIPIENT_SELF:String = "2";
        public static const MOD_TARGET_PLAYER:String = "player";
        public static const MOD_TARGET_NPC:String = "npc";

        public function AttackResponseVO(_arg1:Object, _arg2:MonsterModel, _arg3:MonsterModel, _arg4:BattleTeamModel){
            this.player = _arg2;
            this.npc = _arg3;
            this.battleTeam = _arg4;
            var _local5:Object = (_arg1.user_monster) ? _arg1.user_monster : {};
            this.playerAttack = new AttackResultVO(true, _arg2, _arg3, _local5);
            if (_local5.attack){
                this.playerAttack.attackingMove = _arg2.actions.getAction(_local5.attack);
            };
            if (_arg1.rewards){
                this.rewards = this.parseRewards(_arg1.rewards);
            };
            if (_arg1.collection_props){
                this.collectionID = parseInt(_arg1.collection_props.id);
            };
            this.itemGranted = _arg1.item_granted;
            var _local6:Object = _arg1.npc_monster;
            if (_local6){
                this.npcAttack = new AttackResultVO(false, _arg3, _arg2, _local6);
                this.npcAttack.attackingMove = _arg3.actions.getAction(_local6.attack);
            } else {
                _local6 = {};
            };
            this.newUserBuffsOnUser = this.getNewBuffs(_local5.mod_applied, BuffType.BUFF, BuffAppliesTo.PLAYER);
            this.newUserBuffsOnNPC = this.getNewBuffs(_local5.mod_applied, BuffType.BUFF, BuffAppliesTo.NPC);
            this.newNPCBuffsOnUser = this.getNewBuffs(_local6.mod_applied, BuffType.BUFF, BuffAppliesTo.PLAYER);
            this.newNPCBuffsOnNPC = this.getNewBuffs(_local6.mod_applied, BuffType.BUFF, BuffAppliesTo.NPC);
            this.newUserDebuffsOnUser = this.getNewBuffs(_local5.mod_applied, BuffType.DEBUFF, BuffAppliesTo.PLAYER);
            this.newUserDebuffsOnNPC = this.getNewBuffs(_local5.mod_applied, BuffType.DEBUFF, BuffAppliesTo.NPC);
            this.newNPCDebuffsOnUser = this.getNewBuffs(_local6.mod_applied, BuffType.DEBUFF, BuffAppliesTo.PLAYER);
            this.newNPCDebuffsOnNPC = this.getNewBuffs(_local6.mod_applied, BuffType.DEBUFF, BuffAppliesTo.NPC);
            this.existingBuffsFromUserAttacking = this.getExistingBuffs(_local5.mod_result, BuffAction.ATTACK);
            this.existingBuffsFromNPCAttacking = this.getExistingBuffs(_local6.mod_result, BuffAction.ATTACK);
            this.existingBuffsFromUserTakingDamage = this.getExistingBuffs(_local6.mod_result, BuffAction.DAMAGE);
            this.existingBuffsFromNPCTakingDamage = this.getExistingBuffs(_local5.mod_result, BuffAction.DAMAGE);
            this.existingUserBuffsFromRound = this.getExistingBuffs(_local5.mod_result, BuffAction.EACH_ROUND);
            this.existingNPCBuffsFromRound = this.getExistingBuffs(_local6.mod_result, BuffAction.EACH_ROUND);
        }
        private function getExistingBuffs(_arg1:Object, _arg2:BuffAction=null):Vector.<BuffResultVO>{
            var _local4:Object;
            var _local5:uint;
            var _local6:Boolean;
            var _local7:Boolean;
            var _local8:MonsterModel;
            var _local9:MonsterModel;
            var _local10:MonsterModel;
            var _local3:Vector.<BuffResultVO> = new Vector.<BuffResultVO>();
            for each (_local4 in _arg1) {
                if (_local4.mod_kill){
                    this.modKill = true;
                };
                _local5 = uint(_local4.on_action);
                if (((_arg2) && (!((_local5 == _arg2.id))))){
                } else {
                    _local6 = (uint(_local4.applies_to) == 1);
                    _local7 = (uint(_local4.recipient) == 1);
                    _local8 = (_local6) ? this.player : this.npc;
                    _local9 = (_local6) ? this.npc : this.player;
                    _local10 = (_local7) ? _local8 : _local9;
                    _local3.push(new BuffResultVO(_local10, _local8, _local6, _local7, _local4));
                };
            };
            return (_local3);
        }
        private function getNewBuffs(_arg1:Object, _arg2:BuffType=null, _arg3:BuffAppliesTo=null):Vector.<BuffVO>{
            var _local5:String;
            var _local6:Object;
            var _local7:uint;
            var _local8:uint;
            var _local4:Vector.<BuffVO> = new Vector.<BuffVO>();
            for (_local5 in _arg1) {
                _local6 = _arg1[_local5];
                _local7 = uint(_local6.mod_type);
                _local8 = uint(_local6.recipient);
                if (((((_arg2) && (!((_local7 == _arg2.id))))) || (((_arg3) && (!((uint(_local5) == _arg3.id))))))){
                } else {
                    _local4.push(new BuffVO(BuffType.parse(_local7), _local6));
                };
            };
            return (_local4);
        }
        private function parseRewards(_arg1:Object):Vector.<WinResultVO>{
            var _local3:String;
            var _local4:Object;
            var _local5:MonsterModel;
            var _local6:WinResultVO;
            var _local2:Vector.<WinResultVO> = new Vector.<WinResultVO>();
            for (_local3 in _arg1) {
                _local4 = _arg1[_local3];
                _local5 = this.battleTeam.getMonsterByID(_local3);
                _local6 = new WinResultVO(_local5, _local4);
                _local2.push(_local6);
            };
            return (_local2);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.vo 
