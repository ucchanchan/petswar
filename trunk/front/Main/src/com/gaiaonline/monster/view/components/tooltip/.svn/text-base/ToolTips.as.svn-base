//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.tooltip {
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import alecmce.ui.*;
    import __AS3__.vec.*;

    public class ToolTips extends Sprite {

        private var _list:Vector.<DisplayObject>;
        private var _map:Dictionary;
        private var _timer:Timer;
        private var _target:DisplayObject;
        private var _tip:ToolTipDisplay;

        private static const DELAY:uint = 500;

        public function ToolTips(_arg1:Asset){
            mouseEnabled = false;
            mouseChildren = false;
            this._list = new Vector.<DisplayObject>();
            this._map = new Dictionary();
            this._timer = new Timer(DELAY, 1);
            this._timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
            this._tip = new ToolTipDisplay(this, _arg1);
        }
        public function add(_arg1:DisplayObject, _arg2:String, _arg3:Boolean):void{
            if (_arg1 == null){
                return;
            };
            var _local4:int = this._list.indexOf(_arg1);
            if (_local4 == -1){
                this.hook(_arg1, _arg3);
            };
            this._map[_arg1] = _arg2;
        }
        public function remove(_arg1:DisplayObject):void{
            if (_arg1 == null){
                return;
            };
            var _local2:int = this._list.indexOf(_arg1);
            if (_local2 != -1){
                this.unhook(_arg1);
            };
            delete this._map[_arg1];
        }
        public function removeAll():void{
            var _local1:int = this._list.length;
            while (_local1--) {
                this.unhook(this._list[_local1]);
            };
            this._map = new Dictionary();
        }
        private function hook(_arg1:DisplayObject, _arg2:Boolean):void{
            this._list.push(_arg1);
            _arg1.addEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
            _arg1.addEventListener(MouseEvent.MOUSE_DOWN, this.onRollOut);
            _arg1.addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
            if (_arg2){
                _arg1.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            };
        }
        private function unhook(_arg1:DisplayObject):void{
            var _local2:int = this._list.indexOf(_arg1);
            this._list.splice(_local2, 1);
            _arg1.removeEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
            _arg1.removeEventListener(MouseEvent.MOUSE_DOWN, this.onRollOut);
            _arg1.removeEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
            _arg1.removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        }
        private function onRollOver(_arg1:MouseEvent):void{
            this._target = DisplayObject(_arg1.currentTarget);
            this._timer.start();
        }
        private function onRollOut(_arg1:MouseEvent):void{
            this._timer.reset();
            this._timer.stop();
        }
        private function onRemovedFromStage(_arg1:Event):void{
            var _local2:DisplayObject = DisplayObject(_arg1.target);
            this.remove(_local2);
            if (this._target == _local2){
                this._tip.hide();
            };
        }
        private function onTimerComplete(_arg1:TimerEvent):void{
            this._timer.reset();
            this._timer.stop();
            var _local2:String = this._map[this._target];
            if (_local2){
                this._tip.show(this._target, _local2);
            };
        }

    }
}//package com.gaiaonline.monster.view.components.tooltip 
