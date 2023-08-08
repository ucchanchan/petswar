//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.collections.model {
    import flash.utils.*;

    public class MogaCollectionFactory {

        private var _itemTable:Dictionary;
        private var _collectionTable:Dictionary;

        public function MogaCollectionFactory(){
            this._itemTable = new Dictionary();
            this._collectionTable = new Dictionary();
        }
        public function getCollectable(_arg1:String):MogaCollectionItem{
            this._itemTable[_arg1] = ((this._itemTable[_arg1]) || (new MogaCollectionItem(_arg1)));
            return (this._itemTable[_arg1]);
        }
        public function getCollection(_arg1:String):MogaCollectionVO{
            this._collectionTable[_arg1] = ((this._collectionTable[_arg1]) || (new MogaCollectionVO(_arg1, this)));
            return (this._collectionTable[_arg1]);
        }

    }
}//package gaia.moga.collections.model 
