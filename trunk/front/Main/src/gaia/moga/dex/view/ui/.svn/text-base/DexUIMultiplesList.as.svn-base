//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.view.ui {
    import flash.display.*;
    import org.osflash.signals.*;
    import __AS3__.vec.*;
    import gaia.moga.dex.model.*;

    public class DexUIMultiplesList {

        private var container:MovieClip;
        private var baseY:int;
        private var items:Vector.<DexUIMultiplesItem>;
        private var count:uint;
        private var _moga:DexMoga;
        private var _highlighted:DexUIMultiplesItem;
        private var _position:Number;
        private var _index:int;
        private var _addToTeam:Signal;
        private var _removeFromTeam:Signal;
        private var _selected:Signal;
        private var _isLocked:Boolean;

        public function DexUIMultiplesList(_arg1:MovieClip){
            this.container = _arg1;
            this.baseY = _arg1.y;
            this.items = this.generateItems(_arg1, "item_");
            this.count = this.items.length;
            this._addToTeam = new Signal(DexMogaInstance, DexUIAddToTeamButton);
            this._removeFromTeam = new Signal(DexMogaInstance);
            this._selected = new Signal(DexMogaInstance);
        }
        public function set moga(_arg1:DexMoga):void{
            this._moga = _arg1;
            this.updateItems();
            this.position = 0;
        }
        public function get moga():DexMoga{
            return (this._moga);
        }
        public function get isLocked():Boolean{
            return (this._isLocked);
        }
        public function set isLocked(_arg1:Boolean):void{
            if (this._isLocked == _arg1){
                return;
            };
            this._isLocked = _arg1;
            var _local2:int;
            while (_local2 < this.count) {
                this.items[_local2].isLocked = _arg1;
                _local2++;
            };
        }
        public function set position(_arg1:Number):void{
            var _local4:int;
            var _local5:DexUIMultiplesItem;
            this._position = (isNaN(_arg1)) ? 0 : _arg1;
            this.container.y = (this.baseY - (this._position * 70));
            var _local2 = (this._position | 0);
            if (_local2 == this._index){
                return;
            };
            this._index = _local2;
            var _local3:int = this.count;
            while (_local3--) {
                _local4 = (_local3 + _local2);
                _local5 = this.items[(_local4 % this.count)];
                _local5.y = (_local4 * 70);
                _local5.instance = this.moga.getInstance(_local4);
            };
        }
        public function get position():Number{
            return (this._position);
        }
        private function generateItems(_arg1:MovieClip, _arg2:String):Vector.<DexUIMultiplesItem>{
            var _local5:String;
            var _local6:MovieClip;
            var _local7:DexUIMultiplesItem;
            var _local3:Vector.<DexUIMultiplesItem> = new Vector.<DexUIMultiplesItem>();
            var _local4:int;
            do  {
                var _temp1 = _local4;
                _local4 = (_local4 + 1);
                _local5 = (_arg2 + _temp1);
                _local6 = _arg1[_local5];
                if (_local6){
                    _local7 = new DexUIMultiplesItem(_local6);
                    _local3.push(_local7);
                };
            } while (_local6);
            return (_local3);
        }
        private function updateItems():void{
            var _local3:DexUIMultiplesItem;
            var _local1 = -1;
            var _local2:int = ((this._moga.count < this.count)) ? this._moga.count : this.count;
            for each (_local3 in this.items) {
                ++_local1;
                if (_local1 < _local2){
                    _local3.moga = this.moga;
                    _local3.instance = this.moga.getInstance(_local1);
                    _local3.over.add(this.onItemOver);
                    _local3.out.add(this.onItemOut);
                    _local3.add.add(this.onItemAdd);
                    _local3.remove.add(this.onItemRemove);
                    _local3.click.add(this.onItemClick);
                    _local3.enabled = true;
                } else {
                    _local3.moga = null;
                    _local3.instance = null;
                    _local3.over.remove(this.onItemOver);
                    _local3.out.remove(this.onItemOut);
                    _local3.add.remove(this.onItemAdd);
                    _local3.remove.remove(this.onItemRemove);
                    _local3.click.remove(this.onItemClick);
                    _local3.enabled = false;
                };
            };
        }
        private function onItemOver(_arg1:DexUIMultiplesItem):void{
            if (this._highlighted){
                _arg1.isHighlighted = false;
            };
            this._highlighted = _arg1;
            _arg1.isHighlighted = true;
        }
        private function onItemOut(_arg1:DexUIMultiplesItem):void{
            _arg1.isHighlighted = false;
            if (this._highlighted == _arg1){
                this._highlighted = null;
            };
        }
        private function onItemAdd(_arg1:DexUIMultiplesItem):void{
            this._addToTeam.dispatch(_arg1.instance, _arg1.addToTeamButton);
        }
        private function onItemRemove(_arg1:DexUIMultiplesItem):void{
            this._removeFromTeam.dispatch(_arg1.instance);
        }
        private function onItemClick(_arg1:DexUIMultiplesItem):void{
            this._selected.dispatch(_arg1.instance);
        }
        public function get selected():ISignal{
            return (this._selected);
        }
        public function get addToTeam():ISignal{
            return (this._addToTeam);
        }
        public function get removeFromTeam():ISignal{
            return (this._removeFromTeam);
        }

    }
}//package gaia.moga.dex.view.ui 
