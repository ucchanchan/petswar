//Created by Action Script Viewer - http://www.buraks.com/asv
package com.omniture {
    import flash.events.*;
    import flash.net.*;

    public dynamic class ActionSource_XML {

        public var data:Object;
        public var loaded:Boolean;// = true
        public var onDataReady:String;// = ""
        private var _url:String;
        private var loader:URLLoader;

        public function ActionSource_XML(_arg1:Object){
            loaded = true;
            onDataReady = "";
            super();
            this.s = _arg1;
            this.loader = new URLLoader();
            this.loader.addEventListener(Event.COMPLETE, this.onComplete);
        }
        private function handleNode(_arg1:XML, _arg2:Object){
            var _local3:String;
            var _local4:XMLList;
            var _local5:Number;
            _local3 = _arg1.name();
            if (((this.s.isSet(_local3)) && ((_arg1.nodeKind() == "element")))){
                _local4 = _arg1.children();
                if (((this.s.isSet(_local4)) && ((_local4.length() > 0)))){
                    if (_local4[0].nodeKind() == "text"){
                        _arg2[_local3] = ("" + _local4[0]);
                    } else {
                        _arg2[_local3] = new Object();
                        _local5 = 0;
                        while (_local5 < _local4.length()) {
                            this.handleNode(_local4[_local5], _arg2[_local3]);
                            _local5++;
                        };
                    };
                };
            };
        }
        public function get url():String{
            return (this._url);
        }
        private function loadXML(){
            this.loaded = false;
            this.loader.load(new URLRequest(this._url));
        }
        private function onComplete(_arg1:Event){
            var _local2:Object;
            var _local3:XML;
            _local2 = XML.settings();
            XML.ignoreWhitespace = true;
            XML.ignoreProcessingInstructions = true;
            XML.ignoreComments = true;
            _local3 = new XML(this.loader.data);
            this.data = new Object();
            if ((((_local3.name() == "config")) && ((_local3.nodeKind() == "element")))){
                this.handleNode(_local3, this.data);
            };
            XML.setSettings(_local2);
            if (this.s.isSet(this.onDataReady)){
                var _local4 = this.s;
                _local4[onDataReady](this.data);
            };
            this.loaded = true;
        }
        public function set url(_arg1:String){
            var _local2:String;
            this._url = _arg1;
            if (this.s.isSet(this._url)){
                _local2 = this._url.toLowerCase();
                if (this.s.isSet(this.s.ssl)){
                    if (_local2.substr(0, 7) == "http://"){
                        this._url = this._url.substr(7);
                        _local2 = this._url.toLowerCase();
                    };
                    if (_local2.substr(0, 8) != "https://"){
                        this._url = ("https://" + this._url);
                    };
                } else {
                    if (((!((_local2.substr(0, 7) == "http://"))) && (!((_local2.substr(0, 8) == "https://"))))){
                        this._url = ("http://" + this._url);
                    };
                };
                this.loadXML();
            };
        }

    }
}//package com.omniture 
