//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.events {
    import flash.events.*;

    public class DialogEvent extends Event {

        private var _data;

        public static const ACTION:String = "DialogEvent.ACTION";
        public static const SHOW_DIALOG:String = "SHOW_DIALOG";

        public function DialogEvent(_arg1:String, _arg2=null){
            super(_arg1);
            this._data = _arg2;
        }
        public function get data(){
            return (this._data);
        }

    }
}//package com.gaiaonline.monster.events 
