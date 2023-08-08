//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.videoAd {
    import flash.events.*;
    import com.gaiaonline.monster.view.components.app.panel.*;

    public class VideoAdBlueNoodle extends Panel {

        private var __noodleBar:NoodleBarIntegration;
        private var thirdPartyId:String;

        public function VideoAdBlueNoodle(_arg1:String){
            if (this.stage){
                this.__init();
            } else {
                addEventListener(Event.ADDED_TO_STAGE, this.__init);
            };
            this.thirdPartyId = _arg1;
        }
        protected function __init(_arg1:Event=null):void{
            this.removeEventListener(Event.ADDED_TO_STAGE, this.__init);
            var _local2:String = ((this.loaderInfo.parameters.groupConfigId) || (null));
            this.__noodleBar = new NoodleBarIntegration(this.thirdPartyId, _local2);
        }

    }
}//package com.gaiaonline.monster.view.components.videoAd 
