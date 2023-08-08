//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.monster.model.actions {
    import org.osflash.signals.*;
    import gaia.moga.data.attacks.*;

    public class Action {

        public var id:String;
        public var data:AttackDataVO;
        public var damage:uint;
        public var accuracy:uint;
        private var _quantity:int;
        public var max:int;
        public var type:ActionType;
        private var _updated:Signal;
        public var zodiacId:int;
        public var details:Object;

        public function Action(){
            this._updated = new Signal(Action);
        }
        public function get procID():uint{
            return (uint(this.details.mod));
        }
        public function get procIconID():uint{
            if (this.details.mod_props){
                return (uint(this.details.mod_props.icon_id));
            };
            return (null);
        }
        public function get critPercentage():Number{
            if (this.details.crit){
                return (Number(this.details.crit));
            };
            return (0);
        }
        public function get triggersProc():Boolean{
            return ((0 < this.procTriggerPercentage));
        }
        public function get procTriggerPercentage():Number{
            if (((this.details.mod) && (this.details.mod_chance))){
                return (Number(this.details.mod_chance));
            };
            if (this.details.mod){
                return (100);
            };
            return (0);
        }
        public function get quantity():int{
            return (this._quantity);
        }
        public function set quantity(_arg1:int):void{
            if (this._quantity == _arg1){
                return;
            };
            this._quantity = _arg1;
            this._updated.dispatch(this);
        }
        public function recharge():void{
            this.quantity = this.max;
        }
        public function get updated():Signal{
            return (this._updated);
        }

    }
}//package gaia.moga.monster.model.actions 
