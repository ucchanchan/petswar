//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.view.ui {
    import flash.display.*;
    import org.osflash.signals.*;
    import __AS3__.vec.*;
    import gaia.moga.dex.model.*;
    import flash.text.*;

    public class DexUIGridZodiac {

        private var length:uint;
        private var list:Vector.<DexUIItem>;
        private var count:TextField;
        private var _isEnabled:Boolean;
        private var _captured:uint;
        private var _total:uint;
        private var _mogas:Vector.<DexMoga>;
        private var _click:Signal;
        private var _over:Signal;
        private var _out:Signal;

        public function DexUIGridZodiac(_arg1:Vector.<MovieClip>, _arg2:TextField){
            this.length = _arg1.length;
            this.list = this.generateList(_arg1);
            this.count = _arg2;
            _arg2.text = "";
            this._click = new Signal(DexUIItem);
            this._over = new Signal(DexUIItem);
            this._out = new Signal(DexUIItem);
        }
        public function set mogas(_arg1:Vector.<DexMoga>):void{
            var _local3:DexUIItem;
            var _local4:DexMoga;
            if (this._mogas == _arg1){
                return;
            };
            this._mogas = _arg1;
            if (this._mogas){
                this._mogas.sort(this.compareFunction);
            };
            this._captured = 0;
            this._total = (this._mogas) ? this._mogas.length : 0;
            var _local2:int;
            while (_local2 < this.length) {
                _local3 = this.list[_local2];
                _local4 = ((_local2 < this._total)) ? _arg1[_local2] : null;
                if (_local4){
                    _local3.moga = _local4;
                    if (_local4.count > 0){
                        this._captured++;
                    };
                    _local3.click.add(this.onItemClick);
                    _local3.over.add(this.onItemOver);
                    _local3.out.add(this.onItemOut);
                } else {
                    _local3.moga = null;
                    _local3.click.removeAll();
                    _local3.over.removeAll();
                    _local3.out.removeAll();
                };
                _local2++;
            };
            this.updateCount();
        }
        private function compareFunction(_arg1:DexMoga, _arg2:DexMoga):int{
            return ((_arg1.rarity - _arg2.rarity));
        }
        public function add(_arg1:DexMoga):void{
            if (!this._mogas){
                this._mogas = new Vector.<DexMoga>();
            } else {
                if (this._mogas.length == this.length){
                    return;
                };
                if (this._mogas.fixed){
                    this._mogas.fixed = false;
                };
            };
            this._captured++;
            this._total++;
            this.updateCount();
            var _local2:uint = this._mogas.push(_arg1);
            this.list[_local2].moga = _arg1;
        }
        public function get isEnabled():Boolean{
            return (this._isEnabled);
        }
        public function set isEnabled(_arg1:Boolean):void{
            this._isEnabled = _arg1;
            var _local2:int = this.length;
            while (_local2--) {
                this.list[_local2].isEnabled = _arg1;
            };
        }
        public function get click():ISignal{
            return (this._click);
        }
        public function get over():ISignal{
            return (this._over);
        }
        public function get out():ISignal{
            return (this._out);
        }
        private function generateList(_arg1:Vector.<MovieClip>):Vector.<DexUIItem>{
            var _local2:Vector.<DexUIItem> = new Vector.<DexUIItem>(this.length, true);
            var _local3:int;
            while (_local3 < this.length) {
                _local2[_local3] = new DexUIItem(_arg1[_local3]);
                _local3++;
            };
            return (_local2);
        }
        private function onItemClick(_arg1:DexUIItem):void{
            this._click.dispatch(_arg1);
        }
        private function onItemOver(_arg1:DexUIItem):void{
            this._over.dispatch(_arg1);
        }
        private function onItemOut(_arg1:DexUIItem):void{
            this._out.dispatch(_arg1);
        }
        private function updateCount():void{
            this.count.text = ((this._captured + " / ") + this._total);
        }

    }
}//package gaia.moga.dex.view.ui 
