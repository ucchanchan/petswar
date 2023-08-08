//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.ui {
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.net.*;

    public class BitmapAssetLoader extends AssetBase {

        private var _retries:uint;
        private var _url:String;
        private var _loader:Loader;
        private var _context:LoaderContext;
        private var _content:Bitmap;

        public function BitmapAssetLoader(_arg1:String, _arg2:Sprite=null, _arg3:int=3){
            this._url = _arg1;
            this._retries = _arg3;
            if (_arg2){
                addChild(_arg2);
            };
            this._loader = new Loader();
            this._loader.contentLoaderInfo.addEventListener(Event.INIT, this.onLoadInit);
            this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoadInit);
            this._loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
            this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
            this._context = new LoaderContext();
            this._context.checkPolicyFile = true;
        }
        override public function get name():String{
            return (this._url);
        }
        override protected function onInit():void{
            if (((!(this._url)) || ((this._url == "")))){
                throw (new Error("Attempting to init() a BitmapAssetLoader with no url"));
            };
            this._loader.load(new URLRequest(this._url), this._context);
        }
        override public function get content():DisplayObject{
            return (this._content);
        }
        private function onIOError(_arg1:IOErrorEvent):void{
            if (this._retries--){
                this._loader.load(new URLRequest(this._url), this._context);
            } else {
                assetError(("IO Error loading " + this._url));
            };
        }
        private function onSecurityError(_arg1:SecurityErrorEvent):void{
            assetError(("Security Error loading " + this._url));
        }
        private function onLoadInit(_arg1:Event):void{
            if (numChildren){
                removeChildAt(0);
            };
            this._content = Bitmap(this._loader.content);
            addChild(this._loader);
            assetComplete();
        }
        override public function dispose(_arg1:Boolean=true):void{
            this.removeEventListeners();
            if (((this._content) && (this._content.bitmapData))){
                this._content.bitmapData.dispose();
            };
            this._content = null;
            removeChild(this._loader);
            this._loader.unloadAndStop(_arg1);
            this._loader = null;
        }
        private function removeEventListeners():void{
            if (!this._loader){
                return;
            };
            this._loader.contentLoaderInfo.removeEventListener(Event.INIT, this.onLoadInit);
            this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onLoadInit);
            this._loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
            this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
        }

    }
}//package alecmce.ui 
