//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model {
    import __AS3__.vec.*;

    public class BattleTeamModel {

        private var _mogas:Vector.<MonsterModel>;
        private var _maxTeamSize:uint;
        private var idMap:Object;

        public function BattleTeamModel(_arg1:uint){
            this._mogas = new Vector.<MonsterModel>(_arg1, true);
            this.idMap = {};
            this._maxTeamSize = _arg1;
        }
        public function get mogas():Vector.<MonsterModel>{
            return (this._mogas);
        }
        public function set mogas(_arg1:Vector.<MonsterModel>):void{
            var _local4:MonsterModel;
            var _local5:MonsterModel;
            var _local2:uint = _arg1.length;
            var _local3:int = this.maxTeamSize;
            while (_local3--) {
                _local4 = this._mogas[_local3];
                _local5 = ((_local3 < _local2)) ? _arg1[_local3] : null;
                this._mogas[_local3] = _local5;
                if (_local4){
                    delete this.idMap[_local4.id];
                };
                if (_local5){
                    this.idMap[_local5.id] = _local5;
                };
            };
        }
        public function getMonsterByIndex(_arg1:uint):MonsterModel{
            return (((_arg1 < this.maxTeamSize)) ? this._mogas[_arg1] : null);
        }
        public function getMonsterByID(_arg1):MonsterModel{
            return (this.idMap[String(_arg1)]);
        }
        public function get firstEligibleMonster():MonsterModel{
            var _local3:MonsterModel;
            var _local1:uint = this._mogas.length;
            var _local2:int;
            while (_local2 < _local1) {
                _local3 = this._mogas[_local2];
                if (((_local3) && (_local3.canFight))){
                    return (_local3);
                };
                _local2++;
            };
            return (null);
        }
        public function get canFight():Boolean{
            var _local2:MonsterModel;
            var _local1:int = this._mogas.length;
            while (_local1--) {
                _local2 = this._mogas[_local1];
                if (((_local2) && (_local2.canFight))){
                    return (true);
                };
            };
            return (false);
        }
        public function get highestMonsterLevel():int{
            var _local3:MonsterModel;
            var _local1:uint;
            var _local2:int = this._mogas.length;
            while (_local2--) {
                _local3 = this._mogas[_local2];
                _local1 = (((_local3) && ((_local3.level > _local1)))) ? _local3.level : _local1;
            };
            return (_local1);
        }
        public function get maxTeamSize():uint{
            return (this._maxTeamSize);
        }
        public function set maxTeamSize(_arg1:uint):void{
            this._maxTeamSize = _arg1;
            throw (new Error("this functionality is not ready yet!"));
        }
        public function isMonsterInNap():Boolean{
            var _local2:MonsterModel;
            var _local1:int = this._mogas.length;
            while (_local1--) {
                _local2 = this._mogas[_local1];
                if (((_local2) && (_local2.isNapping))){
                    return (true);
                };
            };
            return (false);
        }
        public function isOnTeam(_arg1:MonsterModel):Boolean{
            return (!((this._mogas.indexOf(_arg1) == -1)));
        }

    }
}//package com.gaiaonline.monster.model 
