//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.async {
    import org.osflash.signals.*;
    import __AS3__.vec.*;

    public class AutoAsyncStack {

        private var stack:Vector.<Async>;
        private var current:Async;
        private var _complete:Signal;
        private var _error:Signal;

        public function AutoAsyncStack(){
            this.stack = new Vector.<Async>();
            this._complete = new Signal(AutoAsyncStack);
            this._error = new Signal(AutoAsyncStack, String);
        }
        public function push(_arg1:Async):void{
            if (!this.current){
                this.initAsCurrent(_arg1);
            } else {
                this.stack.push(_arg1);
            };
        }
        public function get complete():Signal{
            return (this._complete);
        }
        public function get error():Signal{
            return (this._error);
        }
        private function initAsCurrent(_arg1:Async):void{
            this.current = _arg1;
            if (this.current.isComplete){
                this.onComplete(_arg1);
            } else {
                if (this.current.isError){
                    this.onError(_arg1, "AsyncService cannot init async that isError");
                } else {
                    this.current.complete.addOnce(this.onComplete);
                    if (this.current.error.numListeners == 0){
                        this.current.error.addOnce(this.onError);
                    } else {
                        this.current.error.addOnce(this.ignoreError);
                    };
                    this.current.init();
                };
            };
        }
        private function onComplete(_arg1:Async):void{
            this.cleanupCurrent();
            if (this.stack.length){
                this.initAsCurrent(this.stack.shift());
            } else {
                this._complete.dispatch(this);
            };
        }
        private function onError(_arg1:Async, _arg2:String):void{
            this.cleanupCurrent();
            this._error.dispatch(_arg1, _arg2);
        }
        private function ignoreError(_arg1:Async, _arg2:String):void{
            this.onComplete(_arg1);
        }
        private function cleanupCurrent():void{
            this.current.complete.removeAll();
            this.current.error.removeAll();
            this.current = null;
        }

    }
}//package alecmce.async 
