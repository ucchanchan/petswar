//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.assets.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.model.tracking.*;
    import flash.external.*;

    public class PartnerPixelService extends Actor implements TrackingService {

		[Inject]
        public var asset:AssetService;
		[Inject]
        public var model:ApplicationModel;

        private static const TRACK_PIXEL:String = "trackPartnerPixel";

        public function track(_arg1:TrackingEvent):void{
            if (_arg1.data == PartnerPixelType.SOMETRICS){
                ExternalInterface.call(TRACK_PIXEL, "http://v.sometrics.com/19/mpixel.gif");
            };
            if (_arg1.data == PartnerPixelType.NANIGANS){
                ExternalInterface.call(TRACK_PIXEL, (((("http://api.nanigans.com/event.php?user_id=" + this.model.thirdPartyId) + "&app_id=") + this.model.nanniganAppId) + "&type=user&name=tutorialcomplete"));
            };
            if (_arg1.data == PartnerPixelType.DOUBLE_CLICK){
                ExternalInterface.call(TRACK_PIXEL, ("http://ad.doubleclick.net/activity;src=3058425;type=GAIA_C2E;cat=gaia_748;ord=" + this.model.currentTime));
            };
            if (_arg1.data == PartnerPixelType.LIFESTREET){
                ExternalInterface.call(TRACK_PIXEL, "http://pix.lfstmedia.com/_tracker/455?__noscript=true&propname=|advertiser_offer_id&propvalue=59042");
            };
        }

    }
}//package com.gaiaonline.monster.service 
