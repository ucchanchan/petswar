//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.travel.events {
    import flash.events.*;

    public class TravelEvent extends Event {

        public static const TRIGGER:String = "TravelEvent.TRIGGER";
        public static const CANCEL:String = "TravelEvent.CANCEL";

        public function TravelEvent(_arg1:String){
            super(_arg1);
        }
    }
}//package gaia.moga.travel.events 
