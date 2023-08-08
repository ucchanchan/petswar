//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.application {
    import alecmce.ui.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.view.components.home.*;
    import com.gaiaonline.monster.controller.*;

    public class InvokeMogaStorageCommand extends AsyncCommand {

		[Inject]
        public var assets:AssetService;
        private var storageAsset:AssetBase;

        private static const MOGA_STORAGE:String = "assets/ui/homeStorage.swf";

        override public function execute():void{
            this.storageAsset = (this.assets.createWrapper(MOGA_STORAGE) as AssetBase);
            hook(this.storageAsset, this.onComplete, this.onError);
        }
        private function onComplete(_arg1:Async):void{
            var _local2:MogaStorage = new MogaStorage(this.storageAsset);
            dispatch(new PanelsEvent(PanelsEvent.ADD_OVERLAY, _local2));
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 110));
        }

    }
}//package com.gaiaonline.monster.controller.application 
