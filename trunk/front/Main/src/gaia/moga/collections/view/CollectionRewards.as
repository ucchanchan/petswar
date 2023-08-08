//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.collections.view {
    import flash.display.*;
    import __AS3__.vec.*;
    import flash.geom.*;
    import gaia.moga.collections.model.reward.*;

    public class CollectionRewards extends Sprite {

        private var _reward:MogaCollectionReward;
        private var _spinny:MovieClip;
        private var _items:Vector.<CollectionRewardDisplay>;
        private var _extraPadding:Number = 0

        private static const PADDING:int = -10;

        public function CollectionRewards(_arg1:MogaCollectionReward, _arg2:MovieClip=null){
            this._reward = _arg1;
            this._spinny = _arg2;
            this.showSpinny();
        }
        public function set spinny(_arg1:MovieClip):void{
            this._spinny = _arg1;
            if (this._items){
                this.hideSpinny();
            } else {
                this.showSpinny();
            };
        }
        public function set extraPadding(_arg1:Number):void{
            this._extraPadding = _arg1;
        }
        public function get reward():MogaCollectionReward{
            return (this._reward);
        }
        public function display(_arg1:Vector.<CollectionRewardDisplay>):void{
            this._items = _arg1;
            this.hideSpinny();
            this.setup();
        }
        private function showSpinny():void{
            if (!this._spinny){
                return;
            };
            this._spinny.visible = true;
            this._spinny.play();
        }
        private function hideSpinny():void{
            if (!this._spinny){
                return;
            };
            this._spinny.visible = false;
            this._spinny.stop();
        }
        public function setup():void{
            var _local2:int;
            var _local3:CollectionRewardDisplay;
            var _local7:Rectangle;
            var _local1:uint = this._items.length;
            var _local4:uint;
            var _local5:Vector.<Rectangle> = new Vector.<Rectangle>(_local1, true);
            _local2 = 0;
            while (_local2 < _local1) {
                _local3 = this._items[_local2];
                _local3.setup();
                _local7 = _local3.getRect(_local3);
                _local5[_local2] = _local7;
                _local4 = (_local4 + ((_local7.width + PADDING) + this._extraPadding));
                _local2++;
            };
            _local4 = (_local4 - (PADDING + this._extraPadding));
            var _local6:Number = (-(_local4) * 0.5);
            _local2 = 0;
            while (_local2 < _local1) {
                _local3 = this._items[_local2];
                _local3.x = (_local6 - _local5[_local2].left);
                _local6 = (_local6 + ((_local5[_local2].width + PADDING) + this._extraPadding));
                addChild(_local3);
                _local2++;
            };
        }

    }
}//package gaia.moga.collections.view 
