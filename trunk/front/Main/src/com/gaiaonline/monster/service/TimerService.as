//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service {
    import flash.events.*;
    import flash.utils.*;
    import org.osflash.signals.*;
    import org.robotlegs.mvcs.*;

    public class TimerService extends Actor {

        private var _timer:Timer;
        private var _timeChanged:Signal;
        private var _currentTime:uint;
        private var head:MethodVO;

        public static const MINUTE:uint = 60;
        public static const HOUR:uint = 3600;
        public static const DAY:uint = 86400;

        public function TimerService(){
            this._timeChanged = new Signal(uint);
            this._timer = new Timer(1000);
            this._timer.addEventListener(TimerEvent.TIMER, this.onTimer);
            this._timer.start();
        }
        public function init(_arg1:uint):void{
            this._currentTime = _arg1;
        }
        public function get timeChanged():ISignal{
            return (this._timeChanged);
        }
        public function get currentTime():uint{
            return (this._currentTime);
        }
        public function callIn(_arg1:uint, _arg2:Function, ... _args):void{
            var _local4:MethodVO = new MethodVO((_arg1 + this._currentTime), _arg2, _args);
            this.stack(_local4);
        }
        public function callAt(_arg1:uint, _arg2:Function, ... _args):void{
            var _local4:MethodVO = new MethodVO(_arg1, _arg2, _args);
            this.stack(_local4);
        }
        private function onTimer(_arg1:TimerEvent):void{
            this._currentTime++;
            while (((this.head) && ((this.head.t == this._currentTime)))) {
                this.head.call();
                this.head = this.head.next;
            };
            this._timeChanged.dispatch(this._currentTime);
        }
        private function stack(_arg1:MethodVO):void{
            var _local3:MethodVO;
            var _local2:uint = _arg1.t;
            if (this.head){
                if (_local2 < this.head.t){
                    _arg1.next = this.head;
                    this.head = _arg1;
                    return;
                };
                _local3 = this.head;
                while (((_local3.next) && ((_local3.next.t <= _local2)))) {
                    _local3 = _local3.next;
                };
                _arg1.next = _local3.next;
                _local3.next = _arg1;
            } else {
                this.head = _arg1;
            };
        }

    }
}//package com.gaiaonline.monster.service 

class MethodVO {

    public var t:uint;
    public var method:Function;
    public var params:Array;
    public var next:MethodVO;

    public function MethodVO(_arg1:uint, _arg2:Function, _arg3:Array){
        this.t = _arg1;
        this.method = _arg2;
        this.params = _arg3;
    }
    public function call():void{
        this.method.apply(null, this.params);
    }

}
