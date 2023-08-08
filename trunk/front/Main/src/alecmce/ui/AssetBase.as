//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.ui {
    import flash.display.*;
    import org.osflash.signals.*;
    import alecmce.async.*;

    public class AssetBase extends Sprite implements Asset {

        private var _complete:Signal;
        private var _error:Signal;
        private var _isError:Boolean;
        private var _isComplete:Boolean;
        private var _isInited:Boolean;

        public function AssetBase(){
            this._complete = new Signal(Async);
            this._error = new Signal(Async, String);
            this._isComplete = false;
            this._isError = false;
            this._isInited = false;
        }
        public function get self():DisplayObject{
            return (this);
        }
        public function init():void{
            if (this._isInited){
                return;
            };
            this._isInited = true;
            this.onInit();
        }
        protected function onInit():void{
        }
        public function get complete():Signal{
            return (this._complete);
        }
        public function get error():Signal{
            return (this._error);
        }
        public function get isComplete():Boolean{
            return (this._isComplete);
        }
        public function get isError():Boolean{
            return (this._isError);
        }
        public function get content():DisplayObject{
            return (null);
        }
        protected function assetComplete():void{
            this._isComplete = true;
            this._complete.dispatch(this);
        }
        protected function assetError(_arg1:String):void{
            this._isError = true;
            this._error.dispatch(this, _arg1);
        }
        public function dispose(_arg1:Boolean=true):void{
            if (parent){
                parent.removeChild(this);
            };
            this._complete.removeAll();
            this._error.removeAll();
        }

    }
}//package alecmce.ui 
