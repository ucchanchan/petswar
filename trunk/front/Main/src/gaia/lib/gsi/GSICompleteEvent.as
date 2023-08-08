//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.lib.gsi {
    import flash.events.*;

    public class GSICompleteEvent extends Event {

        private var _methods:Array;

        public static const COMPLETE:String = "complete";

        public function GSICompleteEvent(_arg1:String="complete", _arg2:Array=null){
            super(_arg1);
            this._methods = _arg2;
        }
        public function get methods():Array{
            return (this._methods);
        }

    }
}//package gaia.lib.gsi 
