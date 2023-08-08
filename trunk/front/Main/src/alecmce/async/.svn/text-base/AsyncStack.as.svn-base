//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.async {
    import __AS3__.vec.*;

    public class AsyncStack extends AsyncBase implements Async {

        private var stack:Vector.<Async>;
        private var current:Async;
        private var _name:String;

        public function AsyncStack(_arg1:String){
            this._name = _arg1;
            this.stack = new Vector.<Async>();
        }
        public function push(_arg1:Async):Boolean{
            if (_arg1 == null){
                return (false);
            };
            var _local2:int = this.stack.indexOf(_arg1);
            if (_local2 != -1){
                return (false);
            };
            this.stack.push(_arg1);
            return (true);
        }
        public function remove(_arg1:Async):Boolean{
            if (_arg1 == null){
                return (false);
            };
            if (this.current == _arg1){
                this.removeCurrentListeners();
                this.onComplete(_arg1);
                return (true);
            };
            var _local2:int = this.stack.indexOf(_arg1);
            if (_local2 == -1){
                return (false);
            };
            this.stack.splice(_local2, 1);
            return (true);
        }
        override protected function onInit():void{
            if (!this.stack.length){
                asyncComplete();
                return;
            };
            this.initAsCurrent(this.stack.shift());
        }
        private function initAsCurrent(_arg1:Async):void{
            this.current = _arg1;
            if (this.current.isComplete){
                this.onComplete(_arg1);
            } else {
                if (this.current.isError){
                    this.onError(_arg1, "AsyncStack cannot init async that isError");
                } else {
                    this.current.complete.addOnce(this.onComplete);
                    this.current.error.addOnce(this.onError);
                    this.current.init();
                };
            };
        }
        private function onComplete(_arg1:Async):void{
            this.removeCurrentListeners();
            if (this.stack.length){
                this.initAsCurrent(this.stack.shift());
            } else {
                asyncComplete();
            };
        }
        private function onError(_arg1:Async, _arg2:String):void{
            this.removeCurrentListeners();
            asyncError(_arg2);
        }
        private function removeCurrentListeners():void{
            this.current.complete.removeAll();
            this.current.error.removeAll();
        }
        override public function get name():String{
            return (this._name);
        }

    }
}//package alecmce.async 
