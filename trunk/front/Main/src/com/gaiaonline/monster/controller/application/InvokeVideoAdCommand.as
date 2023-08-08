//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.application {
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.assets.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.view.components.videoAd.*;

    public class InvokeVideoAdCommand extends Command {

        public var assets:AssetService;
        public var model:ApplicationModel;
        private var asset:Asset;

        override public function execute():void{
            this.asset = this.assets.videoPlayer();
            var _local1:VideoAdBlueNoodle = new VideoAdBlueNoodle(this.model.thirdPartyId);
            dispatch(new PanelsEvent(PanelsEvent.ADD_OVERLAY, _local1));
        }

    }
}//package com.gaiaonline.monster.controller.application 
