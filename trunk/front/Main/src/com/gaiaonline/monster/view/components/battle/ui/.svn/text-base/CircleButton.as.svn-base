//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.ui {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;

    public class CircleButton {

        private var _clicked:Signal;
        private var _ui:MovieClip;
        private var _inner:MovieClip;
        private var target:Asset;

        public function CircleButton(_arg1:MovieClip, _arg2:Asset){
            this._clicked = new Signal();
            this._ui = _arg1;
            this._ui.mouseChildren = true;
            this._inner = _arg1.inner;
            this._inner.addChild(_arg2.self);
        }
        public function showButton(_arg1:Asset, _arg2:Boolean):void{
            var _local3:MovieClip;
            if (this.target != _arg1){
                if (this.target){
                    _local3 = MovieClip(this.target.content).button;
                    _local3.removeEventListener(MouseEvent.CLICK, this.onClick);
                };
                this.target = _arg1;
                if (this._inner.numChildren > 0){
                    this._inner.removeChildAt(0);
                };
                this._inner.addChild(this.target.self);
                this._ui.gotoAndPlay(2);
            };
            this._ui.useHandCursor = _arg2;
            this._ui.mouseEnabled = _arg2;
            this._ui.buttonMode = _arg2;
            _local3 = MovieClip(this.target.content).button;
            _local3.useHandCursor = _arg2;
            _local3.mouseEnabled = _arg2;
            if (_arg2){
                _local3.addEventListener(MouseEvent.CLICK, this.onClick);
            };
        }
        public function dispose():void{
            var _local1:MovieClip;
            if (this.target){
                _local1 = MovieClip(this.target.content).button;
                _local1.removeEventListener(MouseEvent.CLICK, this.onClick);
            };
            if (this._inner.numChildren > 0){
                this._inner.removeChildAt(0);
            };
        }
        private function onClick(_arg1:MouseEvent):void{
            this._clicked.dispatch();
        }
        public function get clicked():ISignal{
            return (this._clicked);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.ui 
