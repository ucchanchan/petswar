//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.application {
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.process.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.view.components.store.*;
    import com.gaiaonline.monster.controller.*;

    public class InvokePremiumBundleCommand extends AsyncCommand {

		[Inject]
        public var setupStoreData:SetupStoreData;
		[Inject]
        public var assets:AssetService;
		[Inject]
        public var text:TextService;
		[Inject]
        public var store:StoreModel;
        public var asset:Asset;

        private static const BUNDLE_ASSET:String = "assets/ui/premiumBundle.swf";

        override public function execute():void{
            if (this.store.premiumStoreOpen){
                return;
            };
            var _local1:AsyncCollection = new AsyncCollection();
            _local1.add((this.asset = this.assets.createWrapper(BUNDLE_ASSET)));
            _local1.add(this.setupStoreData);
            hook(_local1, this.onComplete, this.onError);
        }
        private function onComplete(_arg1:Async):void{
            var _local2:PremiumBundle = new PremiumBundle(this.asset);
            dispatch(new PanelsEvent(PanelsEvent.ADD_OVERLAY, _local2));
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 116));
        }

    }
}//package com.gaiaonline.monster.controller.application 
