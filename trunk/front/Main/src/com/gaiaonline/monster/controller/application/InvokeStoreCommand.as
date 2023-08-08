//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.application {
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.process.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.view.components.store.*;
    import com.gaiaonline.monster.controller.*;

    public class InvokeStoreCommand extends AsyncCommand {

		[Inject]
        public var setupStoreData:SetupStoreData;
		[Inject]
        public var assets:AssetService;
		[Inject]
        public var store:StoreModel;
        private var storeAsset:Asset;

        private static const STORE_LOCATION:String = "assets/ui/store.swf";

        override public function execute():void{
            if (this.store.open){
                return;
            };
            var _local1:AsyncCollection = new AsyncCollection();
            _local1.add((this.storeAsset = this.assets.createWrapper(STORE_LOCATION)));
            _local1.add(this.setupStoreData);
            hook(_local1, this.onComplete, this.onError);
        }
        private function onComplete(_arg1:Async):void{
            dispatch(new ApplicationEvent(ApplicationEvent.NOT_LOADING));
            var _local2:Store = new Store(this.storeAsset, this.assets.storeTileLocation);
            dispatch(new PanelsEvent(PanelsEvent.ADD_OVERLAY, _local2));
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 112));
        }

    }
}//package com.gaiaonline.monster.controller.application 
