//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.dialog.vo {

    public class DialogVO {

        public var message:String;
        public var buttons:String;
        public var yes:Class;
        public var no:Class;
        public var ok:Class;
        public var cancel:Class;
        public var data;

        public static const YES_NO:String = "YES_NO";
        public static const OK_ONLY:String = "OK_ONLY";
        public static const OK_CANCEL:String = "OK_CANCEL";

        public function DialogVO(_arg1:String, _arg2:String){
            this.message = _arg1;
            this.buttons = _arg2;
        }
    }
}//package com.gaiaonline.monster.view.dialog.vo 
