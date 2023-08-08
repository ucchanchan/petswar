//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.lib.gsi {
    import flash.events.*;

    public class GSIEvent extends Event {

        private var _gsiMethod:int;
        private var _gsiData:Object;

        public static const ERROR:String = "error";
        public static const LOADED:String = "loaded";
        public static const SERIALIZED:String = "serialized";
        public static const RAW_LOADED:String = "raw_loaded";

        public function GSIEvent(_arg1:String="loaded", _arg2:int=0, _arg3:Object=null){
            super(_arg1);
            this._gsiMethod = _arg2;
            this._gsiData = _arg3;
        }
        public function get gsiMethod():int{
            return (this._gsiMethod);
        }
        public function get gsiData():Object{
            return (this._gsiData);
        }
        override public function clone():Event{
            return (new GSIEvent(type, this._gsiMethod, this._gsiData));
        }

    }
}//package gaia.lib.gsi 
