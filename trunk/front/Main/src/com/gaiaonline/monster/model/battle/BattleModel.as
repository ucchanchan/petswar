//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model.battle {
    import com.gaiaonline.monster.model.vo.*;
    import org.osflash.signals.*;
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import gaia.moga.friendlist.model.*;
    import com.gaiaonline.monster.view.components.battle.vo.*;
    import gaia.moga.monster.model.actions.*;
    import gaia.moga.monster.model.*;
    import com.gaiaonline.monster.service.*;

    public class BattleModel {

		[Inject]
        public var text:TextService;
		[Inject]
        public var factory:MogaFactory;
        private var _id:String;
        private var _type:uint;
        private var _start:Date;
        public var npc:NpcVO;
        private var _state:BattleState;
        private var _stateChanged:Signal;
        private var _playerMonster:MonsterModel;
        private var _previousMonster:MonsterModel;
        private var _estimatesUpdated:Signal;
        public var attack:AttackResponseVO;
        public var friend:Friend;
        public var isRetrievedBattle:Boolean;
        public var hasStarted:Boolean;
        public var weakenedThreshold:int;
        public var catchPercentage:int;
        public var rarity:int;
        public var pendingActionType:ActionType;
        public var isCapture:Boolean;
        public var attackEstimates:Object;
        public var isBattleInited:Boolean;
        public var isButtBattle:Boolean;
        private var _playerRecharged:Signal;

        public function BattleModel(){
            this._stateChanged = new Signal(BattleState);
            this._estimatesUpdated = new Signal();
            this._playerRecharged = new Signal(MonsterModel);
        }
        public function init(_arg1:Object, _arg2:Object, _arg3:Object):void{
            var _local4:Object = _arg1.battle_state;
            this.isBattleInited = true;
            this._state = BattleState.BEFORE_BATTLE_HAS_STARTED;
            this.isRetrievedBattle = false;
            this._id = _local4.id;
            this.hasStarted = false;
            this._type = _local4.battle_type;
            if (_local4.battle_start != null){
                this._start = new Date(_local4.battle_start);
            };
            this._playerMonster = null;
            this._previousMonster = null;
            var _local5:Vector.<MonsterModel> = this.generateNPCMogas(_arg1.npc_monster_roster);
            this.npc = new NpcVO(_arg2, _local5);
            if (this.npc.id == -1){
                this.weakenedThreshold = uint(_local4.weakened_threshold);
                this.rarity = int(_local4.rarity);
                this.catchPercentage = uint(_local4.catch_percentage);
            } else {
                this.weakenedThreshold = -1;
                this.rarity = -1;
                this.catchPercentage = -1;
            };
            if (_arg3){
                this.updateMoveEstimates(_arg3);
            };
        }
        public function conclude():void{
            var _local1:MonsterModel;
            for each (_local1 in this.npc.monsters) {
                this.factory.dispose(_local1.id);
            };
            this._id = null;
            this.hasStarted = false;
            this.isBattleInited = false;
            this._playerMonster = null;
            this._previousMonster = null;
        }
        private function generateNPCMogas(_arg1:Array):Vector.<MonsterModel>{
            var _local2:uint = _arg1.length;
            var _local3:Vector.<MonsterModel> = new Vector.<MonsterModel>(_local2, true);
            while (_local2--) {
                _local3[_local2] = this.factory.create(_arg1[_local2]);
            };
            return (_local3);
        }
        public function update(_arg1:Object):void{
            this.hasStarted = true;
            var _local2:Object = _arg1.battle_state;
            if (this.npc.id == -1){
                this.weakenedThreshold = uint(_local2.weakened_threshold);
                this.rarity = int(_local2.rarity);
                this.catchPercentage = uint(_local2.catch_percentage);
            };
            if (((this._id) && (!((_local2.id == this._id))))){
                throw (new Error("the battle model is out of sync"));
            };
            if (!this._id){
                this._id = _local2.id;
            };
            if ((((this._start == null)) && (!((_local2.battle_start == null))))){
                this._start = new Date(_local2.battle_start);
            };
            this.updateNPCMogas(_arg1.npc_monster_roster);
            this.npc.getCurrentMonster();
            this.updateUserMogas(_arg1.user_monster_roster);
        }
        private function updateUserMogas(_arg1:Object):void{
            var _local2:Object;
            for each (_local2 in _arg1) {
                this.factory.update(_local2);
            };
        }
        private function updateNPCMogas(_arg1:Object):void{
            var _local2:Object;
            for each (_local2 in _arg1) {
                this.factory.update(_local2);
            };
        }
        public function get id():String{
            return (this._id);
        }
        public function get state():BattleState{
            return (this._state);
        }
        public function set state(_arg1:BattleState):void{
            if (this._state == _arg1){
                return;
            };
            this._state = _arg1;
            this._stateChanged.dispatch(_arg1);
        }
        public function get stateChanged():Signal{
            return (this._stateChanged);
        }
        public function get npcMonster():MonsterModel{
            return (this.npc.monster);
        }
        public function get playerMonster():MonsterModel{
            return (this._playerMonster);
        }
        public function set playerMonster(_arg1:MonsterModel):void{
            if (this._playerMonster){
                this._playerMonster.recharged.remove(this.onPlayerRecharged);
            };
            this._previousMonster = this._playerMonster;
            this._playerMonster = _arg1;
            if (this._playerMonster){
                this._playerMonster.recharged.add(this.onPlayerRecharged);
            };
        }
        private function onPlayerRecharged(_arg1:MonsterModel):void{
            this._playerRecharged.dispatch(_arg1);
        }
        public function revertMonster():void{
            if (this._previousMonster){
                this._playerMonster = this._previousMonster;
            };
            this._previousMonster = null;
        }
        public function updateMoveEstimates(_arg1:Object):void{
            var _local2:String;
            this.attackEstimates = {};
            for (_local2 in _arg1) {
				//未解决的错误
				if(_local2 != "master_seed_cost")
                	this.attackEstimates[_local2] = this.parseMonsterEstimates(_local2, _arg1[_local2]);
            };
            this.estimatesUpdated.dispatch();
        }
        private function parseMonsterEstimates(_arg1:String, _arg2:Object):AttackEstimatesVO{
            var _local5:String;
            var _local6:String;
            var _local3:AttackEstimatesVO = new AttackEstimatesVO();
            var _local4:MonsterModel = this.factory.read(_arg1);
            if (_local4.actions.physicalAttack){
                _local5 = _local4.actions.physicalAttack.id;
                _local3.physical = (_arg2[_local5]) ? new AttackEstimateVO(_arg2[_local4.actions.physicalAttack.id]) : null;
            };
            if (_local4.actions.zodiacAttack){
                _local6 = _local4.actions.zodiacAttack.id;
                _local3.zodiac = (_arg2[_local6]) ? new AttackEstimateVO(_arg2[_local4.actions.zodiacAttack.id]) : null;
            };
            _local3.bonus = (_arg2["bonus"]) ? new AttackEstimateVO(_arg2["bonus"]) : null;
            return (_local3);
        }
        public function getEstimates(_arg1:String):AttackEstimatesVO{
            return (this.attackEstimates[_arg1]);
        }
        public function get estimatesUpdated():Signal{
            return (this._estimatesUpdated);
        }
        public function get previousMonster():MonsterModel{
            return (this._previousMonster);
        }
        public function get playerRecharged():ISignal{
            return (this._playerRecharged);
        }

    }
}//package com.gaiaonline.monster.model.battle 
