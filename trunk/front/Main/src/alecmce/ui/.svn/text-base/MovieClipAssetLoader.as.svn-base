//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.ui {
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;

    public class MovieClipAssetLoader extends AssetBase {

        private var _retries:uint;
        private var _url:String;
        private var _name:String;
        private var _loader:Loader;
        private var _content:MovieClip;

        private static const ASSETS:String = "assets";
        private static const QSTRING:String = "?";
        private static const UNABLE_TO_INIT:String = "Attempting to init() a MovieClipAssetLoader with no url";
        private static const IO_ERROR_LOADING:String = "IO Error loading ";
        private static const SECURITY_ERROR_LOADING:String = "Security Error loading ";

        public function MovieClipAssetLoader(_arg1:String, _arg2:Sprite=null, _arg3:int=3){
            this._url = _arg1;
            this._name = this._url.substr((this._url.indexOf(ASSETS) + 7));
            if (this._name.indexOf(QSTRING) != -1){
                this._name = this._name.substr(0, this._name.indexOf(QSTRING));
            };
            this._retries = _arg3;
            if (_arg2){
                addChild(_arg2);
            };
        }
        override protected function onInit():void{
            if (((!(this._url)) || ((this._url == "")))){
                throw (new Error(UNABLE_TO_INIT));
            };
            this._loader = new Loader();
            this._loader.contentLoaderInfo.addEventListener(Event.INIT, this.onLoadInit);
            this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoadInit);
            this._loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
            this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
            this._loader.load(new URLRequest(this._url));
        }
        override public function get content():DisplayObject{
            return (this._content);
        }
        private function onIOError(_arg1:IOErrorEvent):void{
            if (this._retries--){
                this._loader.load(new URLRequest(this._url));
            } else {
                this.removeEventListeners();
                assetError((IO_ERROR_LOADING + this._url));
            };
        }
        private function onSecurityError(_arg1:SecurityErrorEvent):void{
            this.removeEventListeners();
            assetError((SECURITY_ERROR_LOADING + this._url));
        }
        private function onLoadInit(_arg1:Event):void{
            this.removeEventListeners();
            if (numChildren){
                removeChildAt(0);
            };
            this._content = MovieClip(this._loader.content);
            addChild(this._loader);
            assetComplete();
        }
        private function removeEventListeners():void{
            this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onLoadInit);
            this._loader.contentLoaderInfo.removeEventListener(Event.INIT, this.onLoadInit);
            this._loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
            this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
        }
        override public function get name():String{
            return (this._name);
        }
        override public function dispose(_arg1:Boolean=true):void{
            if (parent){
                parent.removeChild(this);
            };
            if (this._content){
                this._content = null;
            };
            if (this._loader){
                this.removeEventListeners();
                if (this._loader.parent == this){
                    removeChild(this._loader);
                };
                this._loader.unloadAndStop(_arg1);
                this._loader = null;
            };
        }

    }
}//package alecmce.ui 
