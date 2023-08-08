//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.collections.model.reward {
    import __AS3__.vec.*;

    public class MogaCollectionReward {

        private var _items:Vector.<MogaCollectionRewardItem>;
        private var _monsters:Vector.<MogaCollectionRewardMonster>;

        public function MogaCollectionReward(_arg1:Object){
            this.initData(_arg1);
        }
        public function get items():Vector.<MogaCollectionRewardItem>{
            return (this._items.slice());
        }
        public function get monsters():Vector.<MogaCollectionRewardMonster>{
            return (this._monsters.slice());
        }
        public function get monsterIDs():Vector.<uint>{
            var _local2:MogaCollectionRewardMonster;
            var _local1:Vector.<uint> = new Vector.<uint>(0);
            for each (_local2 in this._monsters) {
                _local1.push(_local2.id);
            };
            return (_local1);
        }
        private function initData(_arg1:Object):void{
            this._items = new Vector.<MogaCollectionRewardItem>(0);
            this._monsters = new Vector.<MogaCollectionRewardMonster>(0);
            this.initItemData(_arg1.item);
            this.initMonsterData(_arg1.monster);
        }
        private function initItemData(_arg1:Object):void{
            var _local2:String;
            for (_local2 in _arg1) {
                this._items.push(new MogaCollectionRewardItem(_local2, _arg1[_local2]));
            };
        }
        private function initMonsterData(_arg1:Object):void{
            var _local2:String;
            for (_local2 in _arg1) {
                this._monsters.push(new MogaCollectionRewardMonster(_local2, _arg1[_local2]));
            };
        }

    }
}//package gaia.moga.collections.model.reward 
