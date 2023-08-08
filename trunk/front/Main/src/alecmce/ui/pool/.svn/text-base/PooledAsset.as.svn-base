//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.ui.pool {
    import org.osflash.signals.*;
    import alecmce.ui.*;

    class PooledAsset extends AssetWrapper {

        private var _released:Signal;
        private var _destroyed:Signal;
        private var _isDestroyed:Boolean;
        private var _url:String;

        function PooledAsset(_arg1:Asset, _arg2:String){
            super(_arg1);
            addChild(_arg1.self);
            this._url = _arg2;
            this._released = new Signal(PooledAsset);
            this._destroyed = new Signal(PooledAsset);
            this._isDestroyed = false;
        }
        override public function dispose(_arg1:Boolean=true):void{
            if (parent){
                parent.removeChild(this);
            };
            if (this._isDestroyed){
                super.dispose(_arg1);
            } else {
                this._released.dispatch(this);
            };
        }
        public function destroy(_arg1:Boolean=true):void{
            this._destroyed.dispatch(this);
            this._released.removeAll();
            this._released = null;
            this._destroyed.removeAll();
            this._destroyed = null;
            this._isDestroyed = true;
            super.dispose(_arg1);
        }
        public function get released():ISignal{
            return (this._released);
        }
        public function get destroyed():ISignal{
            return (this._destroyed);
        }
        public function get url():String{
            return (this._url);
        }

    }
}//package alecmce.ui.pool 
