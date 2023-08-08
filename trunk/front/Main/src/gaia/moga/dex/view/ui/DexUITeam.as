//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.view.ui {
    import flash.display.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import __AS3__.vec.*;
    import gaia.moga.dex.model.*;
    import alecmce.async.*;

    public class DexUITeam extends Sprite {

        private var _items:Vector.<DexUITeamItem>;
        private var _limit:uint;
        private var stack:AutoAsyncStack;
        private var _team:Vector.<DexMogaInstance>;
        private var _selected:Signal;
        private var _changed:Signal;
        private var _isLocked:Boolean;

        private static const COUNT:int = 6;

        public function DexUITeam(_arg1:Asset, _arg2:uint){
            this._items = this.generateItems(_arg1);
            this.limit = _arg2;
            this.stack = new AutoAsyncStack();
            this._changed = new Signal();
            this._selected = new Signal(DexMogaInstance);
            addChild(_arg1.self);
        }
        public function get limit():uint{
            return (this._limit);
        }
        public function set limit(_arg1:uint):void{
            if (_arg1 > COUNT){
                _arg1 = COUNT;
            };
            if (this._limit == _arg1){
                return;
            };
            this._limit = _arg1;
            if (((this._team) && ((this._team.length > this._limit)))){
                this._team.length = this._limit;
            };
            this.updateItemLocks();
        }
        public function get isLocked():Boolean{
            return (this._isLocked);
        }
        public function set isLocked(_arg1:Boolean):void{
            if (this._isLocked == _arg1){
                return;
            };
            this._isLocked = _arg1;
            this.updateItemLocks();
        }
        private function updateItemLocks():void{
            var _local1:int;
            while (_local1 < COUNT) {
                this._items[_local1].isLocked = ((this._isLocked) || ((_local1 >= this._limit)));
                _local1++;
            };
        }
        public function set team(_arg1:Vector.<DexMogaInstance>):void{
            var _local2:uint = _arg1.length;
            if (_local2 > this._limit){
                _arg1.length = this._limit;
                _local2 = this._limit;
            };
            this._team = _arg1;
            var _local3:int;
            while (_local3 < COUNT) {
                this._items[_local3].moga = ((_local3 < _local2)) ? _arg1[_local3] : null;
                _local3++;
            };
        }
        public function get team():Vector.<DexMogaInstance>{
            return (this._team);
        }
        public function get changed():ISignal{
            return (this._changed);
        }
        public function get items():Vector.<DexUITeamItem>{
            return (this._items);
        }
        public function get selected():Signal{
            return (this._selected);
        }
        private function generateItems(_arg1:Asset):Vector.<DexUITeamItem>{
            var _local5:DexUITeamItem;
            var _local2:MovieClip = (_arg1.content as MovieClip);
            var _local3:Vector.<DexUITeamItem> = new Vector.<DexUITeamItem>(COUNT, true);
            var _local4:int;
            while (_local4 < COUNT) {
                _local5 = new DexUITeamItem(_local2[("team" + _local4)]);
                _local5.selected.add(this.onMogaSelected);
                _local5.removed.add(this.onMogaRemoved);
                _local3[_local4] = _local5;
                _local4++;
            };
            return (_local3);
        }
        private function onMogaRemoved(_arg1:DexMogaInstance):void{
            var _local2:int = this._team.indexOf(_arg1);
            if (_local2 < (this._team.length - 1)){
                this.stack.push(new DexUITeamRemoveInstance(this, _arg1));
            } else {
                this._team.length--;
            };
            this._changed.dispatch();
        }
        private function onMogaSelected(_arg1:DexMogaInstance):void{
            this._selected.dispatch(_arg1);
        }

    }
}//package gaia.moga.dex.view.ui 
