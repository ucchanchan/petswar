//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import flash.external.*;

    public class MonetizationService extends ExternalInterfaceService {

        public var ranch:HomeRanchModel;

        public function MonetizationService(){
            ExternalInterface.addCallback("openPremiumStore", this.openPremiumStore);
        }
        public function showOffersPopup(_arg1:Object):void{
            var _local2:String = (_arg1.popupTitle) ? _arg1.popupTitle : "&nbsp;";
            ExternalInterface.addCallback("onClosePopup", onClosePopup);
            pauseGame();
            ExternalInterface.call("openOffers", _local2, "onClosePopup");
        }
        private function openPremiumStore():void{
            if (this.ranch.mogas.length > 0){
                dispatch(new ApplicationEvent(ApplicationEvent.INVOKE_PREMIUM_BUNDLE));
            };
        }

    }
}//package com.gaiaonline.monster.service 
