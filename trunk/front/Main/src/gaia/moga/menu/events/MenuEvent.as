//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.menu.events {
    import flash.events.*;
    import gaia.moga.menu.view.ui.*;

    public class MenuEvent extends Event {

        public var id:String;
        public var data:Object;

        public static const TRAVEL:String = Menu.TRAVEL;
        public static const DEX:String = Menu.DEX;
        public static const QUEST:String = Menu.QUEST;
        public static const SETTINGS:String = Menu.SETTINGS;
        public static const COLLECTIONS:String = Menu.COLLECTIONS;
        public static const ENABLE:String = "ENABLE";
        public static const DISABLE:String = "DISABLE";
        public static const SHOW_ARROW:String = "MenuEvent.SHOW_ARROW";
        public static const HIDE_ARROW:String = "MenuEvent.HIDE_ARROW";

        public function MenuEvent(_arg1:String, _arg2:Object=null){
            this.data = _arg2;
            super(_arg1);
        }
    }
}//package gaia.moga.menu.events 
