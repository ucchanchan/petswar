//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service {
    import com.gaiaonline.monster.events.*;
    import org.robotlegs.mvcs.*;
    import flash.external.*;

    public class KontagentService extends Actor implements TrackingService {

        public function track(_arg1:TrackingEvent):void{
            var _local2:String = String(_arg1.data);
            ExternalInterface.call("kt.track_event", _local2, null, null, null, null, null);
        }

    }
}//package com.gaiaonline.monster.service 
