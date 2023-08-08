//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.story.model {
    import flash.events.*;
    import alecmce.async.*;
    import flash.net.*;

    public class WebStoryLoader extends AsyncBase implements StoryLoader {

        private var _url:String;
        private var loader:URLLoader;
        private var retries:uint;
        private var _data:String;

        private static const RETRIES:uint = 3;

        public function set url(_arg1:String):void{
            this._url = _arg1;
            this.retries = 0;
        }
        public function get data():String{
            return (this._data);
        }
        override protected function onInit():void{
            var _local1:URLRequest = new URLRequest(this._url);
            this.loader = new URLLoader();
            this.loader.addEventListener(Event.COMPLETE, this.onComplete);
            this.loader.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
            this.loader.load(_local1);
        }
        private function onComplete(_arg1:Event):void{
            this.removeListeners();
            this._data = this.loader.data;
            asyncComplete();
        }
        private function onError(_arg1:IOErrorEvent):void{
            this.removeListeners();
            if (this.retries++ == RETRIES){
                asyncError(("Unable to load story at " + this._url));
            } else {
                this.onInit();
            };
        }
        private function removeListeners():void{
            this.loader.removeEventListener(Event.COMPLETE, this.onComplete);
            this.loader.removeEventListener(IOErrorEvent.IO_ERROR, this.onError);
        }
        override public function dispose(_arg1:Boolean=true):void{
            if (!this.loader){
                return;
            };
            super.dispose(_arg1);
            this.removeListeners();
            this.loader.close();
            this.loader = null;
        }

    }
}//package gaia.moga.story.model 
