//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.ui {
    import __AS3__.vec.*;

    public class AssetCollection extends AssetBase {

        private var _name:String;
        private var map:Object;
        private var list:Vector.<Asset>;
        private var pending:Vector.<Asset>;
        public var failOnError:Boolean;

        public function AssetCollection(_arg1:String, _arg2:Boolean=true){
            this._name = _arg1;
            this.failOnError = _arg2;
            this.list = new Vector.<Asset>();
            this.pending = new Vector.<Asset>();
            this.map = new Object();
        }
        public function add(_arg1:Asset, _arg2:String=""):void{
            if (!_arg1){
                return;
            };
            var _local3:int = this.list.indexOf(_arg1);
            if (_local3 != -1){
                return;
            };
            this.list.push(_arg1);
            this.pending.push(_arg1);
            if (_arg2){
                this.map[_arg2] = _arg1;
            };
        }
        public function getAsset(_arg1:String):Asset{
            return (this.map[_arg1]);
        }
        override protected function onInit():void{
            var _local2:Asset;
            var _local1:int = this.pending.length;
            if (_local1 == 0){
                assetComplete();
                return;
            };
            while (_local1--) {
                _local2 = this.pending[_local1];
                if (_local2.isComplete){
                    this.onComplete(_local2);
                } else {
                    if (_local2.isError){
                        this.onError(_local2);
                    } else {
                        _local2.complete.addOnce(this.onComplete);
                        _local2.error.addOnce(this.onError);
                        _local2.init();
                    };
                };
            };
        }
        public function remove(_arg1:Asset):void{
            var _local3:String;
            var _local2:int = this.list.indexOf(_arg1);
            if (_local2 == -1){
                return;
            };
            for (_local3 in this.map) {
                if (this.map[_local3] == _arg1){
                    delete this.map[_local3];
                };
            };
            this.list.splice(_local2, 1);
            this.removeFromPending(_arg1);
            if (this.pending.length == 0){
                assetComplete();
            };
        }
        private function onComplete(_arg1:Asset):void{
            this.removeListeners(_arg1);
            this.removeFromPending(_arg1);
            if (this.pending.length == 0){
                assetComplete();
            };
        }
        private function onError(_arg1:Asset, _arg2:String=""):void{
            this.removeListeners(_arg1);
            this.removeFromPending(_arg1);
            if (((!(this.failOnError)) && ((this.pending.length == 0)))){
                assetComplete();
            } else {
                if (this.failOnError){
                    assetError(_arg2);
                };
            };
        }
        private function removeListeners(_arg1:Asset):void{
            _arg1.error.remove(this.onError);
            _arg1.complete.remove(this.onComplete);
        }
        private function removeFromPending(_arg1:Asset):void{
            var _local2:int = this.pending.indexOf(_arg1);
            if (_local2 == -1){
                return;
            };
            this.removeListeners(_arg1);
            this.pending.splice(_local2, 1);
        }
        override public function dispose(_arg1:Boolean=true):void{
            var _local2:int;
            this.map = new Object();
            _local2 = this.list.length;
            while (_local2--) {
                this.list[_local2].dispose(_arg1);
            };
        }
        override public function get name():String{
            return (this._name);
        }

    }
}//package alecmce.ui 
