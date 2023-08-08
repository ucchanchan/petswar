//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.async {
    import __AS3__.vec.*;

    public class ParallelAsyncs extends AsyncBase implements Async {

        private var _name:String;
        private var list:Vector.<Async>;
        private var pending:Vector.<Async>;
        public var failOnError:Boolean;

        public function ParallelAsyncs(_arg1:String, _arg2:Boolean=true){
            this._name = _arg1;
            this.failOnError = _arg2;
            this.list = new Vector.<Async>();
            this.pending = new Vector.<Async>();
        }
        public function add(_arg1:Async):void{
            if (_arg1 == null){
                return;
            };
            var _local2:int = this.list.indexOf(_arg1);
            if (_local2 != -1){
                return;
            };
            this.list.push(_arg1);
            this.pending.push(_arg1);
        }
        override protected function onInit():void{
            var _local2:Async;
            var _local1:int = this.pending.length;
            if (_local1 == 0){
                asyncComplete();
                return;
            };
            while (_local1--) {
                _local2 = this.pending[_local1];
                if (_local2.isError){
                    this.onError(_local2);
                } else {
                    _local2.error.addOnce(this.onError);
                };
                if (_local2.isComplete){
                    this.onComplete(_local2);
                } else {
                    _local2.complete.addOnce(this.onComplete);
                };
                _local2.init();
            };
        }
        public function remove(_arg1:Async):void{
            var _local2:int = this.list.indexOf(_arg1);
            if (_local2 == -1){
                return;
            };
            this.list.splice(_local2, 1);
            this.removeFromPending(_arg1);
            if (this.pending.length == 0){
                asyncComplete();
            };
        }
        private function onComplete(_arg1:Async):void{
            this.removeListeners(_arg1);
            this.removeFromPending(_arg1);
            if (this.pending.length == 0){
                asyncComplete();
            };
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            this.removeListeners(_arg1);
            this.removeFromPending(_arg1);
            if (((!(this.failOnError)) && ((this.pending.length == 0)))){
                asyncComplete();
            } else {
                if (this.failOnError){
                    asyncError(_arg2);
                };
            };
        }
        override public function get name():String{
            return (this._name);
        }
        private function removeListeners(_arg1:Async):void{
            _arg1.error.remove(this.onError);
            _arg1.complete.remove(this.onComplete);
        }
        private function removeFromPending(_arg1:Async):void{
            var _local2:int = this.pending.indexOf(_arg1);
            if (_local2 == -1){
                return;
            };
            this.removeListeners(_arg1);
            this.pending.splice(_local2, 1);
        }

    }
}//package alecmce.async 
