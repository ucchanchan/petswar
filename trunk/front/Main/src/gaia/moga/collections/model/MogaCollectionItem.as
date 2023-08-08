//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.collections.model {
    import org.osflash.signals.*;
    import alecmce.ui.*;

    public class MogaCollectionItem {

        private var _id:String;
        private var _name:String;
        private var _description:String;
        private var _asset:Asset;
        private var _quantity:int;
        public var requiredQuantity:int;// = 1
        private var _updated:Signal;

        public function MogaCollectionItem(_arg1:String){
            this._id = _arg1;
            this._updated = new Signal();
        }
        public function get updated():Signal{
            return (this._updated);
        }
        public function get id():String{
            return (this._id);
        }
        public function get quantity():int{
            return (this._quantity);
        }
        public function set quantity(_arg1:int):void{
            this._quantity = _arg1;
            this._updated.dispatch(_arg1);
        }
        public function get name():String{
            return (this._name);
        }
        public function get description():String{
            return (this._description);
        }
        public function updateProperties(_arg1:Object):void{
            if (_arg1.id == this._id){
                this._description = ((_arg1.description) || (_arg1.name));
                this._name = _arg1.name.replace(" Card", "");
            };
        }
        public function set asset(_arg1:Asset):void{
            this._asset = _arg1;
            this._asset.init();
        }
        public function get asset():Asset{
            return (this._asset);
        }

    }
}//package gaia.moga.collections.model 
