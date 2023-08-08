//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.lib.gsi {
    import flash.events.*;
    import flash.utils.*;
    import flash.net.*;
    import mx.utils.*;

    public class GSIGateway extends EventDispatcher {

        public const GATEWAY_URL:String = "gaiaonline.com/chat/gsi/gateway.php";
        public const GATEWAY_NONENCODED_URL:String = "gaiaonline.com/chat/gsi/index.php";
        private const RETRIES:uint = 3;
        private const DELAY:uint = 1500;

        public var subdomain:String;
        public var serializerClass:Object;
        public var userName:String;
        public var password:String;
        private var aQueuedMethods:Array;
        private var _useNonEncodedURL:Boolean;// = false
        private var _loaders:Dictionary;// = null

        public function GSIGateway(_arg1:String="www"){
            this.serializerClass = SushiSerializer;
            super();
			if(_arg1==null)
				this.subdomain = "www";
			else
				this.subdomain = _arg1;
            this.aQueuedMethods = new Array();
            this._loaders = new Dictionary(true);
        }
        public function set useNonEncodedURL(_arg1:Boolean):void{
            this._useNonEncodedURL = _arg1;
        }
        public function get useNonEncodedURL():Boolean{
            return (this._useNonEncodedURL);
        }
        public function queue(_arg1:uint, ... _args):void{
            this.aQueuedMethods.push([_arg1, _args]);
        }
        public function invoke(_arg1:uint, ... _args):void{
            this.aQueuedMethods.push([_arg1, _args]);
            this.send();
        }
        public function invokeArray(_arg1:uint, _arg2:Array):void{
            this.aQueuedMethods.push([_arg1, _arg2]);
            this.send();
        }
        protected function createURL():String{
            var _local1:String = (this._useNonEncodedURL) ? this.GATEWAY_NONENCODED_URL : this.GATEWAY_URL;
            return (((("http://" + this.subdomain) + ".") + _local1));
        }
        private function createURLLoader():URLLoader{
            var _local1:URLLoader = new URLLoader();
            _local1.addEventListener(Event.COMPLETE, this.onComplete);
            _local1.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
            return (_local1);
        }
        public function send():void{
            var _local5:Base64Encoder;
            var _local6:String;
            var _local7:URLRequestHeader;
            this.dTrace((":send()" + this.aQueuedMethods));
            if (!this.aQueuedMethods.length){
                return;
            };
            var _local1:String = this.createURL();
            var _local2:URLRequest = new URLRequest(_local1);
            _local2.method = URLRequestMethod.POST;
            var _local3:URLVariables = new URLVariables();
            _local3.m = unescape(this.serializerClass.serialize(this.aQueuedMethods));
            if (hasEventListener(GSIEvent.SERIALIZED)){
                dispatchEvent(new GSIEvent(GSIEvent.SERIALIZED, this.aQueuedMethods[0], _local3.m));
            };
            _local3.v = this.serializerClass.encodeName;
            _local3.X = new Date().getTime();
            _local2.data = _local3;
            if (((!((this.userName == null))) && (!((this.password == null))))){
                _local5 = new Base64Encoder();
                _local5.encode(((this.userName + ":") + this.password));
                _local6 = _local5.flush();
                _local7 = new URLRequestHeader("Authorization", ("Basic " + _local6));
                _local2.requestHeaders.push(_local7);
            };
            var _local4:URLLoader = this.createURLLoader();
            this._loaders[_local4] = new RequestRetry(_local2, _local4, this.RETRIES, this.DELAY);
            _local4.load(_local2);
            this.reset();
        }
        public function reset():void{
            this.aQueuedMethods.length = 0;
        }
        private function clearLoader(_arg1:URLLoader):void{
            _arg1.removeEventListener(Event.COMPLETE, this.onComplete);
            _arg1.removeEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
            delete this._loaders[_arg1];
        }
        private function onComplete(_arg1:Event):void{
            var raw:String;
            var unserialized:Array;
            var pack:Array;
            var method:int;
            var success:Boolean;
            var data:Object;
            var event = _arg1;
            var loader:URLLoader = URLLoader(event.target);
            this.clearLoader(loader);
            raw = unescape(loader.data.toString());
            if (hasEventListener(GSIEvent.RAW_LOADED)){
                dispatchEvent(new GSIEvent(GSIEvent.RAW_LOADED, 0, raw));
            };
            try {
                unserialized = this.serializerClass.unserialize(raw);
            } catch(e:Error) {
                dTrace(((("onComplete() unserialize Error:" + e.message) + " : ") + raw));
                this.dispatchEvent(new GSIEvent(GSIEvent.ERROR));
            };
            if (((!(unserialized)) || (!(unserialized.length)))){
                this.dispatchEvent(new GSIEvent(GSIEvent.ERROR));
                return;
            };
            var aReturnMethods:Array = new Array();
            var totalMethods:uint = unserialized.length;
            var x:uint;
            while (x < totalMethods) {
                pack = unserialized[x];
                method = pack[0];
                success = pack[1];
                data = pack[2];
                aReturnMethods.push({id:method, data:data, success:success});
                if (success){
                    this.dispatchEvent(new GSIEvent(GSIEvent.LOADED, method, data));
                } else {
                    this.dispatchEvent(new GSIEvent(GSIEvent.ERROR, method, data));
                };
                x = (x + 1);
            };
            this.dispatchEvent(new GSICompleteEvent(GSICompleteEvent.COMPLETE, aReturnMethods));
        }
        private function onIOError(_arg1:IOErrorEvent):void{
            var _local2:URLLoader = URLLoader(_arg1.target);
            if (!(this._loaders[_local2] as RequestRetry).doRetry()){
                this.clearLoader(_local2);
                dispatchEvent(_arg1);
            };
        }
        private function dTrace(_arg1:String):void{
        }

    }
}//package gaia.lib.gsi 

import flash.utils.*;
import flash.net.*;

class RequestRetry {

    private var _request:URLRequest;// = null
    private var _retriesAllowed:uint;// = 1
    private var _urlLoader:URLLoader;// = null
    private var _delay:uint;// = 1

    public function RequestRetry(_arg1:URLRequest, _arg2:URLLoader, _arg3:uint, _arg4:uint=2000){
        this._request = _arg1;
        this._urlLoader = _arg2;
        this._retriesAllowed = _arg3;
        this._delay = _arg4;
    }
    public function doRetry():Boolean{
        this._retriesAllowed--;
        if (this._retriesAllowed > 0){
            setTimeout(this.handleRetry, this._delay);
            return (true);
        };
        return (false);
    }
    private function handleRetry():void{
        this._urlLoader.load(this._request);
    }

}
