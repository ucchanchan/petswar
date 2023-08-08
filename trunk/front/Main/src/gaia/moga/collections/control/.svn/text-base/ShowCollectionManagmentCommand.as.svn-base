//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.collections.control {
    import alecmce.ui.*;
    import gaia.moga.dex.model.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.collections.service.*;
    import gaia.moga.assets.*;
    import gaia.moga.collections.view.*;
    import com.gaiaonline.monster.controller.*;
    import gaia.moga.*;

    public class ShowCollectionManagmentCommand extends AsyncCommand {

		[Inject]
        public var assetService:AssetService;
		[Inject]
        public var collectionDataProcess:CollectionDataProcess;
		[Inject]
        public var dexSetupProcess:CollectionDexSetupProcess;
		[Inject]
        public var dexModel:DexModel;
        private var asset:Asset;

        override public function execute():void{
            var _local1:AsyncStack = new AsyncStack("showCollectionManagementAsyncStack");
            _local1.push(this.collectionDataProcess);
            _local1.push((this.asset = this.assetService.collectionManagementAsset));
            if (!this.dexModel.isSetup){
                _local1.push(this.dexSetupProcess);
            };
            hook(_local1, this.onComplete, this.onError);
        }
        private function onComplete(_arg1:Async):void{
            var _local2:CollectionsManagementPanel = new CollectionsManagementPanel(this.asset);
            dispatch(new PanelsEvent(PanelsEvent.ADD_OVERLAY, _local2));
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, Errors.UNABLE_TO_OPEN_COLLECTIONS_MANAGER));
        }

    }
}//package gaia.moga.collections.control 
