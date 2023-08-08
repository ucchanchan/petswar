//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.events {
    import flash.display.*;
    import flash.events.*;

    public class ToolTipEvent extends Event {

        public var object:DisplayObject;
        public var tip:String;
        public var autoRemove:Boolean;

        public static const ADD_TOOLTIP:String = "ToolTipEvent.ADD_TOOLTIP";
        public static const REMOVE_TOOLTIP:String = "ToolTipEvent.REMOVE_TOOLTIP";

        public function ToolTipEvent(_arg1:String, _arg2:DisplayObject, _arg3:String="", _arg4:Boolean=true){
            super(_arg1);
            this.object = _arg2;
            this.tip = _arg3;
            this.autoRemove = _arg4;
        }
    }
}//package com.gaiaonline.monster.events 
