//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.view.ui {
    import flash.display.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import __AS3__.vec.*;

    public class DexUITokens extends Sprite {

        private var tokens:Vector.<DexUIToken>;
        private var selectedIndex:uint;
        private var _selected:Signal;
        private var _series:uint;

        public function DexUITokens(_arg1:Asset){
            addChild(_arg1.self);
            this.tokens = this.generateTokens((_arg1.content as MovieClip));
            this.selectedIndex = 0;
            this._selected = new Signal(uint);
        }
        public function setVisibleTokens(_arg1:uint):void{
            var _local2:uint = this.tokens.length;
            if (_arg1 > _local2){
                return;
            };
            var _local3:int;
            while (_local3 < _local2) {
                this.tokens[_local3].isVisible = (_local3 < _arg1);
                _local3++;
            };
        }
        public function get selected():Signal{
            return (this._selected);
        }
        private function generateTokens(_arg1:MovieClip):Vector.<DexUIToken>{
            var _local4:MovieClip;
            var _local5:DexUIToken;
            var _local2:Vector.<DexUIToken> = new Vector.<DexUIToken>();
            var _local3:int;
            do  {
                _local4 = _arg1[("series_" + _local3)];
                if (_local4){
                    _local5 = new DexUIToken(_local4);
                    _local5.isSelected = (_local3 == 0);
                    _local5.clicked.add(this.onTokenSelected);
                    _local2.push(_local5);
                };
                _local3++;
            } while (_local4 != null);
            return (_local2);
        }
        private function onTokenSelected(_arg1:DexUIToken):void{
            var _local2:DexUIToken = this.tokens[this.selectedIndex];
            if (_local2 == _arg1){
                return;
            };
            _local2.isSelected = false;
            this.selectedIndex = this.tokens.indexOf(_arg1);
            _arg1.isSelected = true;
            this._selected.dispatch(this.selectedIndex);
        }
        public function get series():uint{
            return (this._series);
        }
        public function set series(_arg1:uint):void{
            this._series = _arg1;
            this.onTokenSelected(this.tokens[_arg1]);
        }

    }
}//package gaia.moga.dex.view.ui 
