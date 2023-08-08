//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.io {
    import flash.events.*;
    import alecmce.async.*;
    import flash.net.*;

    public final class DataLoader extends AsyncBase implements Data {

        private var _retries:uint;
        private var _url:String;
        private var _loader:URLLoader;
        private var _data;

        public function DataLoader(_arg1:String, _arg2:int=3){
            this._url = _arg1;
            this._retries = _arg2;
            this._loader = new URLLoader();
            this._loader.addEventListener(Event.INIT, this.onLoadInit);
            this._loader.addEventListener(Event.COMPLETE, this.onLoadInit);
            this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
            this._loader.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
        }
        override public function get name():String{
            return (this._url);
        }
        override protected function onInit():void{
            if (((!(this._url)) || ((this._url == "")))){
                throw (new Error("Attempting to init() a DataLoader with no url"));
            };
            this._loader.load(new URLRequest(this._url));
        }
        public function get data(){
            return (this._data);
        }
        private function onIOError(_arg1:IOErrorEvent):void{
            if (this._retries--){
                this._loader.load(new URLRequest(this._url));
            } else {
                asyncError(("IO Error loading " + this._url));
            };
        }
        private function onSecurityError(_arg1:SecurityErrorEvent):void{
            asyncError(("Security Error loading " + this._url));
        }
        private function onLoadInit(_arg1:Event):void{
            this._data = this._loader.data;
            asyncComplete();
        }
        override public function dispose(_arg1:Boolean=true):void{
            this.removeEventListeners();
            this._data = null;
        }
        private function removeEventListeners():void{
            if (!this._loader){
                return;
            };
            this._loader.removeEventListener(Event.INIT, this.onLoadInit);
            this._loader.removeEventListener(Event.COMPLETE, this.onLoadInit);
            this._loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
            this._loader.removeEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
        }

    }
}//package alecmce.io 
