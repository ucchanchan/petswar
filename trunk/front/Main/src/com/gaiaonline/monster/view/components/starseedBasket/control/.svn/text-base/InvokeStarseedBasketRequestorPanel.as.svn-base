//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.starseedBasket.control {
    import alecmce.ui.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.controller.*;
    import com.gaiaonline.monster.view.components.starseedBasket.view.ui.receiver.*;
    import gaia.moga.*;

    public class InvokeStarseedBasketRequestorPanel extends AsyncCommand {

		[Inject]
        public var assetService:AssetService;
        public var asset:Asset;

        private static const REQUESTOR_PANEL:String = "assets/ui/starseedBasketRequesterPanel.swf";

        override public function execute():void{
            this.asset = this.assetService.createWrapper(REQUESTOR_PANEL);
            hook(this.asset, this.onComplete, this.onError);
        }
        private function onComplete(_arg1:Async):void{
            var _local2:StarseedBasketRequesterPanel = new StarseedBasketRequesterPanel(this.asset);
            dispatch(new PanelsEvent(PanelsEvent.ADD_OVERLAY, _local2));
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, Errors.UNABLE_TO_LOAD_STARSEED_BASKET_REQUESTOR_ASSET));
        }

    }
}//package com.gaiaonline.monster.view.components.starseedBasket.control 
