//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.newuser.view.ui {
    import flash.display.*;
    import flash.events.*;
    import com.gskinner.motion.*;
    import org.osflash.signals.*;
    import __AS3__.vec.*;
    import gaia.moga.newuser.view.ui.*;
    import com.gskinner.motion.easing.*;

    class ZodiacList {

        private var ui:MovieClip;
        private var _selected:Signal;
        private var buttons:Vector.<MovieClip>;
        private var tweens:Vector.<GTween>;
        private var zodiacs:Vector.<uint>;
        private var overIndex:int;
        private var selectedIndex:int;

        private static const X_OUT:int = -300;
        private static const X_IN:int = -10;
        private static const OVER:String = "over";
        private static const OUT:int = 1;
        private static const DOWN:String = "down";

        function ZodiacList(_arg1:MovieClip){
            var _local3:MovieClip;
            var _local4:String;
            super();
            this.ui = _arg1;
            this._selected = new Signal(int);
            this.buttons = new Vector.<MovieClip>(12, true);
            this.tweens = new Vector.<GTween>(12, true);
            this.zodiacs = new Vector.<uint>(12, true);
            var _local2:int;
            for each (_local3 in _arg1) {
                _local4 = _local3.name;
                this.buttons[_local2] = _local3;
                this.zodiacs[_local2] = _local4.match(/zodiac_(.+)/)[1];
                _local3.x = X_OUT;
                _local2++;
            };
            this.overIndex = -1;
            this.selectedIndex = -1;
        }
        public function enable():void{
            var _local2:Number;
            var _local1 = 12;
            while (_local1--) {
                _local2 = (0.3 + ((_local1 * 0.05) * 0.5));
                if (this.tweens[_local1]){
                    this.tweens[_local1].paused = true;
                };
                this.tweens[_local1] = new GTween(this.buttons[_local1], _local2, {x:X_IN, rotation:0}, {ease:Quadratic.easeOut});
            };
            this.tweens[0].onComplete = this.onInComplete;
        }
        private function onInComplete(_arg1:GTween):void{
            this.addEventListeners();
            this.addAppleMagnification();
        }
        public function disable():void{
            var _local2:Number;
            var _local1 = 12;
            while (_local1--) {
                _local2 = (0.3 + ((_local1 * 0.05) * 0.5));
                if (this.tweens[_local1]){
                    this.tweens[_local1].paused = true;
                };
                this.tweens[_local1] = new GTween(this.buttons[_local1], _local2, {x:X_OUT, rotation:0}, {ease:Quadratic.easeIn});
            };
            this.tweens[0].onComplete = this.onOutComplete;
        }
        private function onOutComplete(_arg1:GTween):void{
            this.removeEventListeners();
            this.removeAppleMagnification();
        }
        private function addEventListeners():void{
            var _local2:MovieClip;
            var _local1 = 12;
            while (_local1--) {
                _local2 = this.buttons[_local1].hitBox;
                _local2.addEventListener(MouseEvent.ROLL_OVER, this.onOver);
                _local2.addEventListener(MouseEvent.ROLL_OUT, this.onOut);
                _local2.addEventListener(MouseEvent.CLICK, this.onClick);
            };
        }
        private function removeEventListeners():void{
            var _local2:MovieClip;
            var _local1 = 12;
            while (_local1--) {
                _local2 = this.buttons[_local1].hitBox;
                _local2.removeEventListener(MouseEvent.ROLL_OVER, this.onOver);
                _local2.removeEventListener(MouseEvent.ROLL_OUT, this.onOut);
                _local2.removeEventListener(MouseEvent.CLICK, this.onClick);
            };
        }
        private function onOver(_arg1:MouseEvent):void{
            if (((!((this.overIndex == -1))) && (!((this.overIndex == this.selectedIndex))))){
                this.ui.setChildIndex(this.buttons[this.overIndex], this.overIndex);
                this.overIndex = -1;
            };
            var _local2:MovieClip = _arg1.currentTarget.parent;
            this.overIndex = this.buttons.indexOf(_local2);
            if (this.overIndex != this.selectedIndex){
                _local2.bg.gotoAndPlay(OVER);
            };
            this.ui.setChildIndex(_local2, 11);
        }
        private function onOut(_arg1:MouseEvent):void{
            if (((!((this.overIndex == -1))) && (!((this.overIndex == this.selectedIndex))))){
                this.ui.setChildIndex(this.buttons[this.overIndex], this.overIndex);
                this.overIndex = -1;
            };
            var _local2:MovieClip = _arg1.currentTarget.parent;
            if (this.buttons.indexOf(_local2) != this.selectedIndex){
                _local2.bg.gotoAndStop(OUT);
            };
        }
        private function onClick(_arg1:MouseEvent):void{
            var _local2:MovieClip = _arg1.currentTarget.parent;
            var _local3:int = this.buttons.indexOf(_local2);
            this.selectIndex(_local3);
        }
        private function selectIndex(_arg1:uint):void{
            if (_arg1 == this.selectedIndex){
                return;
            };
            if (this.selectedIndex != -1){
                this.buttons[this.selectedIndex].bg.gotoAndStop(OUT);
            };
            this.selectedIndex = _arg1;
            this.buttons[this.selectedIndex].bg.gotoAndPlay(DOWN);
            this._selected.dispatch(this.zodiacs[this.selectedIndex]);
        }
        public function showZodiacSelected(_arg1:uint):void{
            var _local2:uint = this.zodiacs.indexOf(_arg1);
            this.selectedIndex = _local2;
            this.buttons[_local2].bg.gotoAndPlay(DOWN);
        }
        private function addAppleMagnification():void{
            this.ui.addEventListener(Event.ENTER_FRAME, this.appleMagnification);
        }
        private function removeAppleMagnification():void{
            this.ui.removeEventListener(Event.ENTER_FRAME, this.appleMagnification);
        }
        private function appleMagnification(_arg1:Event):void{
            var _local3:MovieClip;
            var _local4:Number;
            var _local5:Number;
            var _local6:Number;
            var _local7:Number;
            var _local2 = 12;
            while (_local2--) {
                _local3 = this.buttons[_local2];
                _local4 = Math.max((this.ui.mouseX - 250), 0);
                _local5 = (this.ui.mouseY - _local3.y);
                _local6 = ((_local4 * _local4) + (_local5 * _local5));
                if (_local6 < 22500){
                    _local6 = (150 - Math.sqrt(_local6));
                    _local6 = Math.pow(_local6, 4);
                    _local6 = (_local6 * 4E-10);
                    _local7 = (1 + _local6);
                } else {
                    _local7 = 1;
                };
                _local3.scaleX = (_local3.scaleY = _local7);
            };
        }
        public function get selected():ISignal{
            return (this._selected);
        }

    }
}//package gaia.moga.newuser.view.ui 
