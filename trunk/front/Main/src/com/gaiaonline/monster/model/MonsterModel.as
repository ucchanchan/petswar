//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model {
    import org.osflash.signals.*;
    import gaia.moga.monster.model.actions.*;
    import com.gaiaonline.monster.service.vo.*;
    import org.robotlegs.mvcs.*;

    public class MonsterModel extends Actor {

        public var id:String;
        public var monsterID:uint;
        public var name:String;
        public var description:String;
        public var hp:int;
        public var maxHP:uint;
        public var opponentHpBeforeAttack:uint;
        public var naturalMaxHP:uint;
        public var speed:uint;
        public var xp:ExperienceVO;
        public var defaultName:String;
        public var zodiac:uint;
        private var _onTeam:uint;
        private var _inStorage:Boolean;// = false
        public var napTime:uint;
        public var napEndTime:int;
        public var baseZodiacAttackStrength:uint;
        public var baseZodiacDefenceStrength:uint;
        public var basePhysicalAttackStrength:uint;
        public var basePhysicalDefenceStrength:uint;
        public var actions:MonsterActions;
        public var canTame:Boolean;
        public var buffCounts:Object;
        public var napping:Signal;
        public var isNapping:Boolean;
        private var _recharged:Signal;
        public var coloredRarity:String;

        private static const NAP_NAG_THRESHOLD:Number = 0.25;

        public function MonsterModel(){
            this.napping = new Signal(MonsterModel, Boolean);
            this.buffCounts = {};
            this._recharged = new Signal(MonsterModel);
        }
        public function set text(_arg1:MonsterTextVO):void{
            this.defaultName = _arg1.name;
            if (this.name == ""){
                this.name = this.defaultName;
            };
            this.description = _arg1.description;
        }
        public function get canNap():Boolean{
            return ((((this.hp < this.naturalMaxHP)) || (this.actions.areActionsDepleted())));
        }
        public function recharge():void{
            this.hp = this.maxHP;
            this.actions.recharge();
            this._recharged.dispatch(this);
        }
        public function resetNapEndTime():void{
            this.napEndTime = 0;
        }
        public function hpPercentage():uint{
            return (((100 * this.hp) / this.naturalMaxHP));
        }
        public function nap(_arg1:uint):void{
            this.napEndTime = (_arg1 + this.napTime);
            this.isNapping = true;
            this.napping.dispatch(this, true);
        }
        public function awaken():void{
            this.napEndTime = 0;
            this.isNapping = false;
            this.napping.dispatch(this, false);
        }
        public function get canFight():Boolean{
            return ((((this.hp > 0)) && (this.actions.haveActionPoints())));
        }
        public function set onTeam(_arg1:uint):void{
            this._onTeam = _arg1;
            this._inStorage = ((this._inStorage) && ((_arg1 == 0)));
        }
        public function get onTeam():uint{
            return (this._onTeam);
        }
        public function set inStorage(_arg1:Boolean):void{
            this._inStorage = _arg1;
            if (_arg1){
                this._onTeam = 0;
            };
        }
        public function get inStorage():Boolean{
            return (this._inStorage);
        }
        public function get wantsNap():Boolean{
            var _local1:Number = (this.hp / this.maxHP);
            return ((((_local1 < NAP_NAG_THRESHOLD)) && (!(this.napEndTime))));
        }
        public function get level():int{
            return (this.xp.level);
        }
        public function get recharged():ISignal{
            return (this._recharged);
        }

    }
}//package com.gaiaonline.monster.model 
