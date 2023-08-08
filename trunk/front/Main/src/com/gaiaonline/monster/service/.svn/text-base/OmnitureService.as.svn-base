//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service {
    import com.gaiaonline.monster.events.*;
    import org.robotlegs.mvcs.*;
    import com.omniture.*;

    public class OmnitureService extends Actor implements TrackingService {

        private var _trackingObject:ActionSource;

        public function OmnitureService(){
            this._trackingObject = new ActionSource();
            this._trackingObject.debugTracking = false;
            this._trackingObject.trackLocal = false;
            this._trackingObject.account = "gaiainteractiveprod";
            this._trackingObject.charSet = "UTF-8";
        }
        public function track(_arg1:TrackingEvent):void{
            var _local2:String = String(_arg1.data);
            this._trackingObject.pageName = ("moga_" + _local2);
            this._trackingObject.track();
        }

    }
}//package com.gaiaonline.monster.service 
