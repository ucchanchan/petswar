//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.collections.view {
    import flash.display.*;
    import gaia.moga.collections.model.*;
    import gaia.moga.collections.model.reward.*;
    import alecmce.list.*;
    import flash.filters.*;

    public class MogaCollectionDatum implements ListDatum {

        private var _collection:MogaCollectionVO;
        private var _mc:MovieClip;
        private var _rewardView:CollectionRewards;

        public function MogaCollectionDatum(_arg1:MogaCollectionVO){
            this._collection = _arg1;
        }
        public function get collection():MogaCollectionVO{
            return (this._collection);
        }
        public function get name():String{
            return (this._collection.name);
        }
        public function get progress():Number{
            return (this._collection.progress);
        }
        public function get rewardsMonster():Boolean{
            return ((0 < this._collection.reward.monsters.length));
        }
        public function get reward():MogaCollectionReward{
            return (this._collection.reward);
        }
        public function update():void{
            if (this._mc){
                this.apply(this._mc);
            };
        }
        public function clear(_arg1:MovieClip):void{
            _arg1.collectionSet.nameField.text = "";
            this.updateSlots(_arg1, true);
            this.clearTradeItemContainer(_arg1);
            this._mc = null;
        }
        public function apply(_arg1:MovieClip):void{
            this._mc = _arg1;
            _arg1.collectionSet.nameField.text = this.name;
            this.updateSlots(_arg1);
            this.updateTradeItemContainer(_arg1);
        }
        private function updateTradeItemContainer(_arg1:MovieClip):void{
            var _local2 = (this._collection.progress == 1);
            _arg1.tradeItemContainer.gotoAndStop((_local2) ? 1 : 2);
            _arg1.tradeItemContainer.rewards.mask = null;
            if (this._rewardView == null){
                this._rewardView = new CollectionRewards(this._collection.reward, _arg1.tradeItemContainer.spinny);
            };
            this._rewardView.spinny = _arg1.tradeItemContainer.spinny;
            _arg1.tradeItemContainer.rewards.addChild(this._rewardView);
        }
        private function clearTradeItemContainer(_arg1:MovieClip):void{
            while (0 < _arg1.tradeItemContainer.rewards.numChildren) {
                _arg1.tradeItemContainer.rewards.removeChildAt(0);
            };
            _arg1.tradeItemContainer.spinny.visible = true;
            _arg1.tradeItemContainer.spinny.play();
        }
        private function updateSlots(_arg1:MovieClip, _arg2:Boolean=false):void{
            var _local5:MovieClip;
            var _local6:MogaCollectionItem;
            var _local3:int = this._collection.items.length;
            var _local4:int;
            while (_local4 < _local3) {
                _local5 = _arg1.collectionSet[("slot" + _local4)];
                _local6 = this._collection.items[_local4];
                if (_arg2){
                    this.clearSlot(_local5, _local6);
                } else {
                    this.updateSlot(_local5, _local6);
                };
                _local4++;
            };
        }
        private function updateSlot(_arg1:MovieClip, _arg2:MogaCollectionItem):void{
            _arg1.wishlistButton.visible = false;
            _arg1.nameField.text = _arg2.name;
            _arg1.cardCount.gotoAndStop(((0 < _arg2.quantity)) ? 1 : 2);
            _arg1.itemHolder.asset.addChild(_arg2.asset.self);
            if (0 < _arg2.quantity){
                _arg2.asset.self.filters = [];
            } else {
                this.desaturate(_arg2.asset.self);
            };
            if (0 < _arg2.quantity){
                _arg1.cardCount.field.text = ("x" + _arg2.quantity);
            };
        }
        private function desaturate(_arg1:DisplayObject):void{
            var _local2:Array = new Array();
            _local2 = _local2.concat([0.25, 0.25, 0.25, 0, 0]);
            _local2 = _local2.concat([0.25, 0.25, 0.25, 0, 0]);
            _local2 = _local2.concat([0.25, 0.25, 0.25, 0, 0]);
            _local2 = _local2.concat([0, 0, 0, 0.25, 0]);
            var _local3:ColorMatrixFilter = new ColorMatrixFilter(_local2);
            _arg1.filters = [_local3];
        }
        public function clearSlot(_arg1:MovieClip, _arg2:MogaCollectionItem):void{
            _arg1.nameField.text = "";
            _arg1.cardCount.gotoAndStop(1);
            _arg1.cardCount.field.text = "";
            while (0 < _arg1.itemHolder.asset.numChildren) {
                _arg1.itemHolder.asset.removeChildAt(0);
            };
        }
        public function toString():String{
            return (this.name);
        }

    }
}//package gaia.moga.collections.view 
