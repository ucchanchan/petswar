//Created by Action Script Viewer - http://www.buraks.com/asv
package com.omniture {
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.external.*;

    public dynamic class ActionSource_Module_ClickMap {

        private var s:Object;

        private static var isExternalSet:Boolean = false;

        public function ActionSource_Module_ClickMap(_arg1:Object){
            var m:Object;
            var e:Object;
            var s = _arg1;
            super();
            m = this;
            m.s = s;
            m.s.addEventListener(Event.ADDED_TO_STAGE, m.onAddedToStage, false, 0, true);
            if (((ExternalInterface.available) && (!(m.isExternalSet)))){
                m.isExternalSet = true;
                try {
                    ExternalInterface.addCallback("s_getDOMIndex", m.getDOMIndex);
                    ExternalInterface.addCallback("s_getTrackClickMap", m.getTrackClickMap);
                    ExternalInterface.addCallback("s_getAccount", m.getAccount);
                    ExternalInterface.addCallback("s_getPageName", m.getPageName);
                    ExternalInterface.addCallback("s_getPageURL", m.getPageURL);
                    ExternalInterface.addCallback("s_getMovieID", m.getMovieID);
                    ExternalInterface.addCallback("s_getVersion", m.getVersion);
                    ExternalInterface.addCallback("s_getCharSet", m.getCharSet);
                    ExternalInterface.addCallback("s_getSWFURL", m.getSWFURL);
                } catch(e) {
                };
            };
        }
        public function getSWFURL(){
            var _local1:Object;
            _local1 = this;
            if (_local1.s.isSet(s.movie)){
                if (((_local1.s.isSet(_local1.s.movie.loaderInfo)) && (_local1.s.isSet(_local1.s.movie.loaderInfo.loaderURL)))){
                    return (_local1.s.movie.loaderInfo.loaderURL);
                };
                if (_local1.s.isSet(_local1.s.movie._url)){
                    return (_local1.s.movie._url);
                };
            };
            return ("");
        }
        public function getVersion(){
            var _local1:Object;
            _local1 = this;
            return (_local1.s.version);
        }
        private function parentLocalToGlobal(_arg1:DisplayObject, _arg2:Object){
            var _local3:*;
            _local3 = new Point(_arg2.x, _arg2.y);
            _arg1.parent.localToGlobal(_local3);
            _arg2.x = _local3.x;
            _arg2.y = _local3.y;
        }
        private function getFullPath(_arg1:DisplayObject){
            var _local2:String;
            var _local3:String;
            var _local4:Array;
            _local4 = new Array();
            do  {
                _local4.splice(0, 0, _arg1.name);
                _arg1 = _arg1.parent;
            } while (_arg1.parent != null);
            _local2 = _local4.join(".");
            _local3 = _local2.substr((_local2.length - 4), 4);
            if ((((_local3 == ".frs")) || ((_local3 == ".fds")))){
                _local2 = _local2.substr(0, (_local2.length - 4));
            };
            return (_local2);
        }
        public function getObjectID(_arg1:Object){
            var _local2:Object;
            var _local3:String;
            var _local4:String;
            _local2 = this;
            _local3 = _local2.getMovieID();
            _local4 = "";
            _local4 = _local2.getFullPath(_arg1);
            if (_local2.s.isSet(_local4)){
                _local4 = (((_local2.s.isSet(_local3)) ? _local3 : "" + ":") + _local4);
            };
            return (_local4);
        }
        public function getMovieID(){
            var _local1:Object;
            var _local2:String;
            var _local3:String;
            var _local4:Number;
            var _local5:Number;
            _local1 = this;
            _local2 = _local1.getSWFURL();
            _local3 = s.movieID;
            if (((!(_local1.s.isSet(_local3))) && (_local1.s.isSet(_local2)))){
                _local4 = _local2.lastIndexOf("/");
                _local5 = _local2.lastIndexOf(".");
                if (_local4 >= 0){
                    _local4++;
                } else {
                    _local4 = 0;
                };
                if (_local5 >= 0){
                    _local5 = (_local5 - _local4);
                } else {
                    _local5 = _local2.length;
                };
                _local3 = _local2.substr(_local4, _local5);
            };
            if (!_local1.s.isSet(_local3)){
                _local3 = "movieID undefined";
            };
            return (_local3);
        }
        public function getIndex(){
            var _local1:Object;
            var _local2:String;
            _local1 = this;
            if (_local1.s.isSet(_local1.s.movie)){
                _local2 = (((_local1.s.movie.stage.stageWidth + ",") + _local1.s.movie.stage.stageHeight) + _local1.indexChildren(_local1.s.movie));
                return (_local2);
            };
            return ("");
        }
        private function sendClickMapEvent(_arg1:Object){
            var _local2:Object;
            var _local3:String;
            var _local4:String;
            var _local5:String;
            var _local6:Number;
            _local2 = this;
            _local3 = _local2.s.getMovieURL();
            _local4 = _local2.getMovieID();
            if (_local2.s.isSet(_local2.s.trackClickMap)){
                _local2.s.objectID = _local2.getObjectID(_arg1);
            };
            if (_local2.s.autoTrack){
                _local5 = _local3;
                _local6 = _local5.indexOf("?");
                if (_local6 >= 0){
                    _local5 = _local5.substr(0, _local6);
                };
                if (_local5.length > (100 - 23)){
                    _local5 = _local5.substr(-((100 - 23)));
                };
                _local2.s.trackLink(_local3, "o", ("ActionSource.AutoTrack:" + _local5));
            };
        }
        private function nodeShift(_arg1:DisplayObject, _arg2:Number, _arg3:Number){
            _arg1.x = _arg2;
            _arg1.y = _arg3;
        }
        private function parentGetBounds(_arg1:DisplayObject){
            var _local2:*;
            var _local3:*;
            _local2 = _arg1.parent.getBounds(_arg1.parent);
            _local3 = new Object();
            _local3.xMin = _local2.x;
            _local3.yMin = _local2.y;
            _local3.xMax = (_local2.x + _local2.width);
            _local3.yMax = (_local2.y + _local2.height);
            return (_local3);
        }
        private function onAddedToStage(_arg1:Event):void{
            var _local2:Object;
            _local2 = this;
            _local2.s.root.addEventListener(MouseEvent.CLICK, _local2.onMouseClick, true, 0, true);
        }
        private function getDOMID(_arg1:Object){
            var _local2:Object;
            var _local3:Object;
            _local2 = this;
            if (_local2.s.isSet(_arg1)){
                _local3 = _local2.getGeom(_arg1);
                return (((((((((_local2.getFullPath(_arg1) + ",") + _local3.x) + ",") + _local3.y) + ",") + _local3.w) + ",") + _local3.h));
            };
            return ("");
        }
        private function onMouseClick(_arg1:MouseEvent):void{
            var m:Object;
            var e:Object;
            var event = _arg1;
            m = this;
            try {
                m.sendClickMapEvent(InteractiveObject(event.target));
            } catch(e) {
            };
        }
        public function getPageURL(){
            var _local1:Object;
            _local1 = this;
            return (_local1.s.pageURL);
        }
        public function getDOMIndex(){
            var _local1:Object;
            _local1 = this;
            return (_local1.getIndex());
        }
        public function getTrackClickMap(){
            var _local1:Object;
            _local1 = this;
            return (_local1.s.trackClickMap.toString());
        }
        private function indexChildren(_arg1:DisplayObjectContainer):String{
            var _local2:Object;
            var _local3:String;
            var _local4:Number;
            var _local5:DisplayObject;
            _local2 = this;
            _local3 = new String();
            _local4 = 0;
            while (_local4 < _arg1.numChildren) {
                _local5 = _arg1.getChildAt(_local4);
                if (_local2.s.isSet(_local5)){
                    _local3 = (_local3 + ("|" + _local2.getDOMID(_local5)));
                    if ((_local5 is DisplayObjectContainer)){
                        _local3 = (_local3 + _local2.indexChildren(DisplayObjectContainer(_local5)));
                    };
                };
                _local4++;
            };
            return (_local3);
        }
        private function nodePos(_arg1:DisplayObject){
            var _local2:*;
            _local2 = new Object();
            _local2.x = _arg1.x;
            _local2.y = _arg1.y;
            return (_local2);
        }
        public function getCharSet(){
            var _local1:Object;
            _local1 = this;
            return (_local1.s.charSet);
        }
        public function getAccount(){
            var _local1:Object;
            _local1 = this;
            return (_local1.s.account);
        }
        private function getGeom(_arg1:Object){
            var _local2:Object;
            var _local3:Object;
            var _local4:Object;
            var _local5:Object;
            var _local6:Object;
            var _local7:Object;
            var _local8:Object;
            var _local9:Object;
            _local2 = this;
            _local3 = new Object();
            _local4 = null;
            _local3.x = 0;
            _local3.y = 0;
            _local3.w = 0;
            _local3.h = 0;
            if (((_local2.s.isSet(_arg1)) && (((_local2.s.isSet(_arg1, "_parent")) || (_local2.s.isSet(_arg1, "parent")))))){
                if (s.isSet(_arg1, "_parent")){
                    _local4 = _local2.getGeom(_arg1._parent);
                } else {
                    if (s.isSet(_arg1, "parent")){
                        _local4 = _local2.getGeom(_arg1.parent);
                    };
                };
                if (((((((((((_local2.s.isSet(_arg1, "size")) && ((typeof(_arg1.size) == "function")))) && (_local2.s.isSet(_arg1, "__width")))) && (_local2.s.isSet(_arg1, "__height")))) && (!((_arg1.__width == _arg1._width))))) && (!((_arg1.__height == _arg1._height))))){
                    _arg1.size();
                };
                if (((_local2.s.isSet(_arg1, "width")) && (_local2.s.isSet(_arg1, "height")))){
                    _local3.x = _arg1.x;
                    _local3.y = _arg1.y;
                    _local2.parentLocalToGlobal(_arg1, _local3);
                    _local3.w = _arg1.width;
                    _local3.h = _arg1.height;
                } else {
                    _local7 = _local2.parentGetBounds(_arg1);
                    _local5 = _local2.nodePos(_arg1);
                    _local6 = _local2.nodePos(_arg1);
                    _local2.nodeShift(_arg1, _local7.xMin, _local7.yMin);
                    _local8 = _local2.parentGetBounds(_arg1);
                    _local2.nodeShift(_arg1, _local7.xMax, _local7.yMax);
                    _local9 = _local2.parentGetBounds(_arg1);
                    _local2.nodeShift(_arg1, _local5.x, _local5.y);
                    _local5.x = (_local5.x + (_local8.xMin - _local7.xMin));
                    _local5.y = (_local5.y + (_local8.yMin - _local7.yMin));
                    _local6.x = (_local6.x + (_local9.xMax - _local7.xMax));
                    _local6.y = (_local6.y + (_local9.yMax - _local7.yMax));
                    _local2.parentLocalToGlobal(_arg1, _local5);
                    _local2.parentLocalToGlobal(_arg1, _local6);
                    _local3.x = _local5.x;
                    _local3.y = _local5.y;
                    _local3.w = (_local6.x - _local5.x);
                    _local3.h = (_local6.y - _local5.y);
                };
                if (((((_local2.s.isSet(_local4)) && (_local2.s.isSet(_local4.x)))) && (_local2.s.isSet(_local4.y)))){
                    _local3.x = (_local3.x + _local4.x);
                    _local3.y = (_local3.y + _local4.y);
                };
                _local3.x = Math.round(_local3.x);
                _local3.y = Math.round(_local3.y);
                _local3.w = Math.ceil(_local3.w);
                _local3.h = Math.ceil(_local3.h);
            };
            return (_local3);
        }
        public function getPageName(){
            var _local1:Object;
            _local1 = this;
            return (_local1.s.pageName);
        }

    }
}//package com.omniture 
