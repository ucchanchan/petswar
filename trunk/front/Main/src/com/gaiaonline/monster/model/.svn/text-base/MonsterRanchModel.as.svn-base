//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model {
    import org.osflash.signals.*;
    import __AS3__.vec.*;
    import flash.geom.*;
    import gaia.moga.monster.model.*;
    import com.gaiaonline.monster.service.*;
    import org.robotlegs.mvcs.*;

    public class MonsterRanchModel extends Actor {

		[Inject]
        public var mogaFactory:MogaFactory;
		[Inject]
        public var text:TextService;
        private var _updated:Signal;
        public var treePosition:Point;
        public var basketPosition:Point;
        private var _decorations:Vector.<DecorationVO>;
        private var _types:Object;
        protected var _mogas:Vector.<MonsterModel>;
        private var _team:BattleTeamModel;
        public var numWhistles:uint;
        public var witherOn:int;
        public var _lastHarvested:uint;
        public var lastWatered:uint;
        public var nextHarvestable:uint;
        public var harvestPeriod:uint;

        public function MonsterRanchModel(){
            this.init();
        }
        private function init():void{
            this._updated = new Signal();
            this.treePosition = new Point(70, 280);
            this.basketPosition = new Point(70, 510);
            this._decorations = new Vector.<DecorationVO>();
            this._decorations.push(new DecorationVO({type:"house", id:8, xpos:550, ypos:205}));
            this._types = {};
            this._mogas = new Vector.<MonsterModel>();
            this._team = new BattleTeamModel(3);
        }
        public function update(_arg1:Object):void{
            this.numWhistles = uint(_arg1.whistle_tree_count);
            this.lastWatered = uint(_arg1.last_watered);
            this.witherOn = uint(_arg1.whistle_tree_withers_on);
            this._lastHarvested = uint(_arg1.last_harvested);
            this.nextHarvestable = uint(_arg1.next_harvestable);
            this.harvestPeriod = uint(_arg1.harvest_period);
            this.updateMogas(_arg1.monsters);
            this._updated.dispatch();
        }
        protected function updateMogas(_arg1:Array):void{
            var _local3:Object;
            var _local4:MonsterModel;
            var _local5:uint;
            var _local2:Vector.<MonsterModel> = new Vector.<MonsterModel>(this._team.maxTeamSize, true);
            for each (_local3 in _arg1) {
                _local4 = this.mogaFactory.update(_local3);
                if (!_local4){
                    _local4 = this.mogaFactory.create(_local3);
                };
                this.addMonster(_local4);
                _local5 = _local3.on_team;
                if (_local5 != 0){
                    _local2[(_local5 - 1)] = _local4;
                };
            };
            this._team.mogas = _local2;
        }
        public function get count():uint{
            return (this._mogas.length);
        }
        public function set lastHarvested(_arg1:uint):void{
            this._lastHarvested = _arg1;
            this.nextHarvestable = (this._lastHarvested + this.harvestPeriod);
        }
        public function addMonster(_arg1:MonsterModel):Boolean{
            var _local2:int = this._mogas.indexOf(_arg1);
            var _local3 = (_local2 == -1);
            if (_local3){
                this._mogas.push(_arg1);
                this.addMonsterToType(_arg1);
            };
            return (_local3);
        }
        private function addMonsterToType(_arg1:MonsterModel):void{
            var _local2:uint = _arg1.monsterID;
            var _local3:MogaType = this._types[_local2];
            if (!_local3){
                _local3 = new MogaType();
                _local3.id = _local2;
                this._types[_local2] = _local3;
            };
            _local3.add(_arg1);
        }
        public function get mogas():Vector.<MonsterModel>{
            return (this._mogas);
        }
        public function getMogaType(_arg1:uint):MogaType{
            return (this._types[_arg1]);
        }
        public function getAllDecorations():Vector.<DecorationVO>{
            return (this._decorations);
        }
        public function get team():BattleTeamModel{
            return (this._team);
        }
        public function get updated():ISignal{
            return (this._updated);
        }

    }
}//package com.gaiaonline.monster.model 
