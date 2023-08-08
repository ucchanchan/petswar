//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.async {
    import flash.utils.*;
    import org.osflash.signals.*;

    public class AsyncBase implements Async {

        private var _complete:Signal;
        private var _error:Signal;
        private var _isComplete:Boolean;
        private var _isError:Boolean;
        private var _isInited:Boolean;

        public function AsyncBase(){
            this._complete = new Signal(Async);
            this._error = new Signal(Async, String);
        }
        final public function init():void{
            if (this._isInited){
                return;
            };
            this._isInited = true;
            this.onInit();
        }
        protected function onInit():void{
        }
        public function get isComplete():Boolean{
            return (this._isComplete);
        }
        public function get isError():Boolean{
            return (this._isError);
        }
        public function get complete():Signal{
            return (this._complete);
        }
        public function get error():Signal{
            return (this._error);
        }
        public function get name():String{
            return (getQualifiedClassName(this));
        }
        protected function asyncComplete():void{
            if (this._isComplete){
                return;
            };
            this._isComplete = true;
            this._complete.dispatch(this);
        }
        protected function asyncError(_arg1:String):void{
            if (this._isError){
                return;
            };
            this._isError = true;
            this._error.dispatch(this, _arg1);
        }
        public function dispose(_arg1:Boolean=true):void{
            this._complete.removeAll();
            this._error.removeAll();
        }

    }
}//package alecmce.async 
