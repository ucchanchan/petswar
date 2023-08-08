//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.view.ui {
    import flash.display.*;
    import com.gskinner.motion.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import __AS3__.vec.*;
    import gaia.moga.dex.model.*;
    import gaia.moga.dex.assets.*;
    import com.gskinner.motion.easing.*;

    public class DexUIGrid extends Sprite {

        private var grid:Vector.<DexUIGridZodiac>;
        private var black:MovieClip;
        private var blackTween:GTween;
        private var bubble:DexUIGridBubble;
        private var _mogas:Vector.<DexMoga>;
        private var _selected:Signal;
        private var _isEnabled:Boolean;
        private var _itemOver:Boolean;

        private static const DURATION:Number = 1;
        private static const COUNT:uint = 12;
        private static const COLUMNS:uint = 12;
        private static const ALPHA:Number = 0.6;

        public function DexUIGrid(_arg1:Asset, _arg2:DexLanguageBundle){
            var _local3:MovieClip = (_arg1.content as MovieClip);
            this.grid = this.generateGrid(_local3, _local3.items);
            this.black = _local3.items.black;
            this.black.alpha = 0;
            this.black.mouseChildren = false;
            this.black.mouseEnabled = false;
            this.blackTween = new GTween(this.black, DURATION, null, {ease:Quadratic.easeInOut});
            this.bubble = new DexUIGridBubble(_local3.bubble, _arg2);
            this._selected = new Signal(DexUIItem);
            addChild(_arg1.self);
        }
        public function get mogas():Vector.<DexMoga>{
            return (this._mogas);
        }
        public function set mogas(_arg1:Vector.<DexMoga>):void{
            var _local5:DexMoga;
            var _local6:uint;
            if (this._mogas == _arg1){
                return;
            };
            this._mogas = _arg1;
            var _local2:uint = (this._mogas) ? this._mogas.length : 0;
            var _local3:Vector.<Vector.<DexMoga>> = new Vector.<Vector.<DexMoga>>(COUNT, true);
            var _local4:int;
            while (_local4 < _local2) {
                _local5 = this._mogas[_local4];
                _local6 = (((_local5.zodiac >> 1) - 1) % COUNT);
                (_local3[_local6] = ((_local3[_local6]) || (new Vector.<DexMoga>()))).push(_local5);
                _local4++;
            };
            _local4 = COUNT;
            while (_local4--) {
                this.grid[_local4].mogas = _local3[_local4];
            };
        }
        public function get selected():ISignal{
            return (this._selected);
        }
        public function get isEnabled():Boolean{
            return (this._isEnabled);
        }
        public function set isEnabled(_arg1:Boolean):void{
            this._isEnabled = _arg1;
            var _local2:int = COLUMNS;
            while (_local2--) {
                this.grid[_local2].isEnabled = this._isEnabled;
            };
            if (this._isEnabled){
                this.clearBlack();
            } else {
                this.showBlack();
            };
        }
        private function generateGrid(_arg1:MovieClip, _arg2:MovieClip):Vector.<DexUIGridZodiac>{
            var _local5:Vector.<MovieClip>;
            var _local6:DexUIGridZodiac;
            var _local3:Vector.<DexUIGridZodiac> = new Vector.<DexUIGridZodiac>(COUNT, true);
            var _local4:int;
            while (_local4 < COUNT) {
                _local5 = this.generateRow(_arg2, _local4);
                _local6 = new DexUIGridZodiac(_local5, _arg1[("count_" + _local4)]);
                _local3[_local4] = _local6;
                _local6.click.add(this.onItemClick);
                _local6.over.add(this.onItemOver);
                _local6.out.add(this.onItemOut);
                _local4++;
            };
            return (_local3);
        }
        private function onItemClick(_arg1:DexUIItem):void{
            this.isEnabled = false;
            this._selected.dispatch(_arg1);
        }
        private function onItemOver(_arg1:DexUIItem):void{
            this._itemOver = true;
            this.showBlack();
            this.bubble.show(_arg1.moga, _arg1.x, _arg1.y);
        }
        private function showBlack():void{
            this.blackTween.setValue("alpha", ALPHA);
        }
        private function onItemOut(_arg1:DexUIItem):void{
            this.clearBlack();
        }
        private function clearBlack():void{
            this.blackTween.setValue("alpha", 0);
            this.bubble.hide();
        }
        private function generateRow(_arg1:MovieClip, _arg2:int):Vector.<MovieClip>{
            var _local6:String;
            var _local3:String = ("item_" + _arg2);
            var _local4:Vector.<MovieClip> = new Vector.<MovieClip>(COLUMNS, true);
            var _local5:int;
            while (_local5 < COLUMNS) {
                _local6 = ((_local3 + "_") + _local5);
                _local4[_local5] = _arg1[_local6];
                _local5++;
            };
            return (_local4);
        }

    }
}//package gaia.moga.dex.view.ui 
