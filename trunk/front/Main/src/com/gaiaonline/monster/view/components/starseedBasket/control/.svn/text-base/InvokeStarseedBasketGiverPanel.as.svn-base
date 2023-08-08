//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.starseedBasket.control {
    import alecmce.ui.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.controller.*;
    import com.gaiaonline.monster.view.components.starseedBasket.view.ui.giver.*;
    import gaia.moga.*;

    public class InvokeStarseedBasketGiverPanel extends AsyncCommand {

        public var assetService:AssetService;
        public var asset:Asset;

        private static const GIVER_PANEL:String = "assets/ui/starseedBasketGiverPanel.swf";

        override public function execute():void{
            this.asset = this.assetService.createWrapper(GIVER_PANEL);
            hook(this.asset, this.onComplete, this.onError);
        }
        private function onComplete(_arg1:Async):void{
            var _local2:StarseedBasketGiverPanel = new StarseedBasketGiverPanel(this.asset);
            dispatch(new PanelsEvent(PanelsEvent.ADD_OVERLAY, _local2));
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, Errors.UNABLE_TO_LOAD_STARSEED_BASKET_GIVER_ASSET));
        }

    }
}//package com.gaiaonline.monster.view.components.starseedBasket.control 
