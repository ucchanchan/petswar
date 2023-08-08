//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.collections.model {
    import __AS3__.vec.*;
    import gaia.moga.collections.model.reward.*;

    public class MogaCollectionVO {

        private var _id:uint;
        private var _name:String;
        private var _description:String;
        private var _type:uint;
        private var _enabled:Boolean;
        private var _items:Vector.<MogaCollectionItem>;
        private var _reward:MogaCollectionReward;
        private var _factory:MogaCollectionFactory;

        public function MogaCollectionVO(_arg1:String, _arg2:MogaCollectionFactory):void{
            this._items = new Vector.<MogaCollectionItem>(0);
            this._id = uint(_arg1);
            this._factory = _arg2;
        }
        public function update(_arg1:Object):void{
            this._name = _arg1.name;
            this._description = _arg1.description;
            this._type = uint(_arg1.type);
            this._enabled = Boolean(parseInt(_arg1.is_enabled));
            this.updateItems(_arg1.items_bundle);
            this._reward = new MogaCollectionReward(_arg1.rewards_bundle);
        }
        public function get id():uint{
            return (this._id);
        }
        public function get name():String{
            return (this._name);
        }
        public function get description():String{
            return (this._description);
        }
        public function get type():uint{
            return (this._type);
        }
        public function get enabled():Boolean{
            return (this._enabled);
        }
        public function get reward():MogaCollectionReward{
            return (this._reward);
        }
        public function get items():Vector.<MogaCollectionItem>{
            return (this._items.slice());
        }
        public function get progress():Number{
            return (this.calculateProgress());
        }
        private function updateItems(_arg1:Object):void{
            var _local2:String;
            var _local3:Object;
            var _local4:MogaCollectionItem;
            this._items = ((this._items) || (new Vector.<MogaCollectionItem>()));
            this._items.length = 0;
            for (_local2 in _arg1) {
                _local3 = _arg1[_local2];
                _local4 = this._factory.getCollectable(_local2);
                if (_local3.props){
                    _local4.updateProperties(_local3.props);
                };
                _local4.requiredQuantity = _local3.q;
                this._items.push(_local4);
            };
        }
        private function calculateProgress():Number{
            var _local2:MogaCollectionItem;
            var _local1:Number = 0;
            for each (_local2 in this._items) {
                if (((_local2) && ((_local2.requiredQuantity <= _local2.quantity)))){
                    _local1 = (_local1 + (1 / this._items.length));
                };
            };
            return (_local1);
        }

    }
}//package gaia.moga.collections.model 
