//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.collections.model {
    import flash.events.*;
    import __AS3__.vec.*;
    import gaia.moga.assets.*;
    import gaia.moga.collections.event.*;

    public class MogaCollectionsModel {

		[Inject]
        public var factory:MogaCollectionFactory;
		[Inject]
        public var dispatcher:IEventDispatcher;
		[Inject]
        public var assetService:AssetService;
        private var _collections:Vector.<MogaCollectionVO>;
        private var _inventory:Vector.<MogaCollectionItem>;

        public function MogaCollectionsModel(){
            this._collections = new Vector.<MogaCollectionVO>(0);
            this._inventory = new Vector.<MogaCollectionItem>(0);
        }
        public function shareCollectionData():void{
            this.dispatchCollections(MogaCollectionEvent.SHARE_COLLECTION_DATA);
        }
        public function init(_arg1:Object):void{
            this._collections = new Vector.<MogaCollectionVO>(0);
            this.updateCollections(_arg1);
            this.updateItems(_arg1.user_collection_inventory);
            this.dispatchCollections(MogaCollectionEvent.COLLECTIONS_UPDATED);
        }
        public function initDropData(_arg1:Object, _arg2:Object):void{
            this.updateCollection(_arg1);
            this.updateItems(_arg2);
            this.dispatchCollections(MogaCollectionEvent.COLLECTIONS_UPDATED);
        }
        public function get rewardMonsterIDs():Vector.<uint>{
            var _local2:MogaCollectionVO;
            var _local1:Vector.<uint> = new Vector.<uint>(0);
            for each (_local2 in this._collections) {
                _local1 = _local1.concat(_local2.reward.monsterIDs);
            };
            return (_local1);
        }
        private function dispatchCollections(_arg1:String):void{
            var _local2:MogaCollectionEvent = new MogaCollectionEvent(_arg1);
            _local2.collections = this._collections.slice();
            this.dispatcher.dispatchEvent(_local2);
        }
        private function updateCollections(_arg1:Object):void{
            var _local2:Object;
            this._collections.length = 0;
            for each (_local2 in _arg1.collection_props) {
                this.updateCollection(_local2);
            };
        }
        private function updateCollection(_arg1:Object):void{
            var _local3:MogaCollectionItem;
            var _local2:MogaCollectionVO = this.factory.getCollection(_arg1.id);
            _local2.update(_arg1);
            for each (_local3 in _local2.items) {
                _local3.asset = this.assetService.getCollectionItemAsset(_local3);
            };
            if (this._collections.indexOf(_local2) == -1){
                this._collections.push(_local2);
            };
        }
        private function updateItems(_arg1:Object):void{
            var _local2:MogaCollectionItem;
            var _local3:String;
            var _local4:Object;
            this._inventory.length = 0;
            for (_local3 in _arg1) {
                _local4 = _arg1[_local3];
                _local2 = this.factory.getCollectable(_local3);
                _local2.updateProperties(_local4.props);
                _local2.quantity = _local4.quantity;
                if (this._inventory.indexOf(_local2) == -1){
                    this._inventory.push(_local2);
                };
            };
        }

    }
}//package gaia.moga.collections.model 
