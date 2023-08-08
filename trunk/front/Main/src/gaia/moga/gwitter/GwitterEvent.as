//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.gwitter {
    import flash.events.*;
    import com.gaiaonline.monster.model.*;

    public class GwitterEvent extends Event {

        public var moga:MonsterModel;

        public static const POST_TO_GWITTER:String = "GwitterEvent.POST_TO_GWITTER";

        public function GwitterEvent(_arg1:String, _arg2:MonsterModel){
            super(_arg1);
            this.moga = _arg2;
        }
    }
}//package gaia.moga.gwitter 
