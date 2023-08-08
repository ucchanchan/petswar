//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.async {
    import __AS3__.vec.*;

    public class AsyncCollection extends AsyncBase implements Async {

        private var list:Vector.<Async>;
        private var pending:uint;
        public var failOnError:Boolean;

        public function AsyncCollection(_arg1:Boolean=true){
            this.failOnError = _arg1;
            this.list = new Vector.<Async>();
            this.pending = 0;
        }
        override public function get name():String{
            return ("(async collection)");
        }
        override protected function onInit():void{
            var _local2:Vector.<Async>;
            var _local1:int = this.list.length;
            if (_local1 == 0){
                asyncComplete();
            } else {
                _local2 = this.list.concat();
                while (_local1--) {
                    _local2[_local1].init();
                };
            };
        }
        public function add(_arg1:Async):void{
            var _local2:int = this.list.indexOf(_arg1);
            if (_local2 != -1){
                return;
            };
            if (_arg1.isError){
                this.onError(_arg1);
                return;
            };
            if (_arg1.isComplete){
                return;
            };
            this.list.push(_arg1);
            _arg1.error.addOnce(this.onError);
            _arg1.complete.addOnce(this.onComplete);
            this.pending++;
        }
        public function remove(_arg1:Async):void{
            var _local2:int = this.list.indexOf(_arg1);
            if (_local2 == -1){
                return;
            };
            this.list.splice(_local2, 1);
            _arg1.error.remove(this.onError);
            _arg1.complete.remove(this.onComplete);
            if (!--this.pending){
                asyncComplete();
            };
        }
        private function onComplete(_arg1:Async):void{
            _arg1.error.remove(this.onError);
            this.remove(_arg1);
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            var _local4:Async;
            _arg1.complete.remove(this.onComplete);
            _arg1.error.remove(this.onError);
            if (!this.failOnError){
                this.remove(_arg1);
                return;
            };
            var _local3:int = this.list.length;
            while (_local3--) {
                _local4 = this.list[_local3];
                _local4.complete.remove(this.onComplete);
                _local4.error.remove(this.onError);
            };
            asyncError(("(async collection error) " + _arg2));
        }

    }
}//package alecmce.async 
