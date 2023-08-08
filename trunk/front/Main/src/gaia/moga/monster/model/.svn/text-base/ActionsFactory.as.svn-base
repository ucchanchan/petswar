//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.monster.model {
    import gaia.moga.monster.model.actions.*;

    public class ActionsFactory {

		[Inject]
        public var instances:ActionFactory;
        private var map:Object;

        public function ActionsFactory(){
            this.map = {};
        }
        public function create(_arg1:String, _arg2:Object):MonsterActions{
            var _local4:Object;
            var _local5:Action;
            var _local3:MonsterActions = (this.map[_arg1] = ((this.map[_arg1]) || (new MonsterActions())));
            _local3.id = _arg1;
            for each (_local4 in _arg2) {
                _local5 = this.instances.create(_arg1, _local4);
                this.applyAction(_local3, _local5);
            };
            return (_local3);
        }
        public function read(_arg1:String):MonsterActions{
            return (this.map[_arg1]);
        }
        public function udpate(_arg1:String, _arg2:Object):MonsterActions{
            var _local4:Object;
            var _local5:Action;
            var _local3:MonsterActions = this.map[_arg1];
            if (!_local3){
                return (null);
            };
            for each (_local4 in _arg2) {
                _local5 = this.instances.update(_arg1, _local4);
                if (!_local5){
                    this.applyAction(_local3, this.instances.create(_arg1, _local4));
                };
            };
            return (_local3);
        }
        public function dispose(_arg1:String):MonsterActions{
            var _local3:Action;
            var _local2:MonsterActions = this.map[_arg1];
            if (!_local2){
                return (null);
            };
            _local3 = _local2.physicalAttack;
            if (_local3){
                this.instances.dispose(_arg1, _local3.id);
            };
            _local3 = _local2.zodiacAttack;
            if (_local3){
                this.instances.dispose(_arg1, _local3.id);
            };
            _local3 = _local2.buffAttack;
            if (_local3){
                this.instances.dispose(_arg1, _local3.id);
            };
            delete this.map[_arg1];
            return (_local2);
        }
        private function applyAction(_arg1:MonsterActions, _arg2:Action):void{
            switch (_arg2.type){
                case ActionType.PHYSICAL:
                    _arg1.physicalAttack = _arg2;
                    break;
                case ActionType.ZODIAC:
                    _arg1.zodiacAttack = _arg2;
                    break;
                case ActionType.BUFF:
                case ActionType.DEBUFF:
                    _arg1.buffAttack = _arg2;
                    break;
                case ActionType.ITEM:
                    break;
            };
        }

    }
}//package gaia.moga.monster.model 
