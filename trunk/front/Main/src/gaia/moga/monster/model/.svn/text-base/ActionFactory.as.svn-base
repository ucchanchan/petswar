//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.monster.model {
    import gaia.moga.data.*;
    import gaia.moga.monster.model.actions.*;

    public class ActionFactory {

		[Inject]
        public var data:DataBundle;
        private var map:Object;

        public function ActionFactory(){
            this.map = {};
        }
        public function create(_arg1:String, _arg2:Object):Action{
            var _local3:String = _arg2.id;
            var _local4:String = this.generateID(_arg1, _local3);
            var _local5:Action = (this.map[_local4] = ((this.map[_local4]) || (new Action())));
            _local5.id = _local3;
            _local5.quantity = _arg2.quantity;
            var _local6:Object = _arg2.props;
            _local5.zodiacId = _local6.zodiac_id;
            _local5.damage = _local6.damage;
            _local5.accuracy = _local6.accuracy;
            _local5.max = _local6.quantity;
            _local5.type = ActionType.parse(_local6.equip_type, _local6.equip_sub_type);
            _local5.details = (_local6) ? _local6.detail_bundle : null;
            _local5.data = this.data.attacks.getData(_local3);
            return (_local5);
        }
        public function read(_arg1:String, _arg2:String):Action{
            var _local3:String = this.generateID(_arg1, _arg2);
            return (this.map[((_arg1 + ".") + _local3)]);
        }
        public function update(_arg1:String, _arg2:Object):Action{
            var _local3:String = _arg2.id;
            var _local4:String = this.generateID(_arg1, _local3);
            var _local5:Action = this.map[_local4];
            if (!_local5){
                return (null);
            };
            _local5.quantity = _arg2.quantity;
            return (_local5);
        }
        public function dispose(_arg1:String, _arg2:String):Action{
            var _local3:String = this.generateID(_arg1, _arg2);
            var _local4:Action = this.map[_local3];
            delete this.map[_local3];
            return (_local4);
        }
        private function generateID(_arg1:String, _arg2:String):String{
            return (((_arg1 + ".") + _arg2));
        }

    }
}//package gaia.moga.monster.model 
