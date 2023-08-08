//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.monster.model.actions {

    public class MonsterActions {

        public var id:String;
        private var _physicalAttack:Action;
        private var _zodiacAttack:Action;
        private var _buffAttack:Action;
        private var map:Object;

        public function MonsterActions(){
            this.map = {};
        }
        public function recharge():void{
            this.physicalAttack.recharge();
            this.zodiacAttack.recharge();
            this.buffAttack.recharge();
        }
        public function areActionsDepleted():Boolean{
            return ((((((this.physicalAttack.quantity < this.physicalAttack.max)) || ((this.zodiacAttack.quantity < this.zodiacAttack.max)))) || ((this.buffAttack.quantity < this.buffAttack.max))));
        }
        public function haveActionPoints():Boolean{
            return ((((((this.physicalAttack.quantity > 0)) || ((this.zodiacAttack.quantity > 0)))) || ((this.buffAttack.quantity > 0))));
        }
        public function getAction(_arg1:String):Action{
            if (this.map[_arg1] == null){
                throw (new Error((("action " + _arg1) + " not found in Actions.getAction")));
            };
            return (this.map[_arg1]);
        }
        public function get physicalAttack():Action{
            return (this._physicalAttack);
        }
        public function set physicalAttack(_arg1:Action):void{
            this._physicalAttack = _arg1;
            if (this._physicalAttack){
                this.map[this._physicalAttack.id] = _arg1;
            };
        }
        public function get zodiacAttack():Action{
            return (this._zodiacAttack);
        }
        public function set zodiacAttack(_arg1:Action):void{
            this._zodiacAttack = _arg1;
            if (this._zodiacAttack){
                this.map[this._zodiacAttack.id] = _arg1;
            };
        }
        public function get buffAttack():Action{
            return (this._buffAttack);
        }
        public function set buffAttack(_arg1:Action):void{
            this._buffAttack = _arg1;
            if (this._buffAttack){
                this.map[this._buffAttack.id] = _arg1;
            };
        }

    }
}//package gaia.moga.monster.model.actions 
