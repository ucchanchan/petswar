//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model.vo {

    public class StoreItemVO {

        private var _id:int;
        private var _type:int;
        private var _basic_cost:int;
        private var _premium_cost:int;
        private var _active:Boolean;
        private var _giftable:Boolean;
        private var _purchasable:int;
        private var _name:String;
        private var _description:String;
        private var _quantity:int;
        private var _detailBundle:Object;
        private var _onSale:Boolean;

        public function StoreItemVO(_arg1:Object){
            var _local2:Object = _arg1.props;
            this._id = _arg1.item_id;
            this._type = _arg1.item_type;
            this._basic_cost = _arg1.basic_cost;
            this._premium_cost = _arg1.premium_cost;
            this._active = _arg1.is_active;
            this._giftable = _arg1.is_giftable;
            this._purchasable = int(_arg1.is_purchasable);
            this._quantity = _local2.quantity;
            this._detailBundle = _local2.detail_bundle;
            if (((_local2.detail_bundle) && (_local2.detail_bundle.sale))){
                this._onSale = _local2.detail_bundle.sale;
            };
        }
        public function update(_arg1:Object):void{
        }
        public function get id():int{
            return (this._id);
        }
        public function get type():int{
            return (this._type);
        }
        public function get basic_cost():int{
            return (this._basic_cost);
        }
        public function get premium_cost():int{
            return (this._premium_cost);
        }
        public function get active():Boolean{
            return (this._active);
        }
        public function get giftable():Boolean{
            return (this._giftable);
        }
        public function get purchasable():int{
            return (this._purchasable);
        }
        public function get name():String{
            return (this._name);
        }
        public function get description():String{
            return (this._description);
        }
        public function get quantity():int{
            return (this._quantity);
        }
        public function get detailBundle():Object{
            return (this._detailBundle);
        }
        public function get onSale():Boolean{
            return (this._onSale);
        }
        public function set onSale(_arg1:Boolean):void{
            this._onSale = _arg1;
        }
        public function set name(_arg1:String):void{
            this._name = _arg1;
        }
        public function set description(_arg1:String):void{
            this._description = _arg1;
        }

    }
}//package com.gaiaonline.monster.model.vo 
