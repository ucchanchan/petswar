//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.collections.control {
    import alecmce.ui.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.assets.*;
    import gaia.moga.collections.view.*;
    import gaia.moga.collections.event.*;
    import com.gaiaonline.monster.controller.*;

    public class ShowTradeInRewardCommand extends AsyncCommand {

		[Inject]
        public var assetService:AssetService;
		[Inject]
        public var event:MogaCollectionEvent;
        private var asset:Asset;

        private static const ASSET_PATH:String = "assets/ui/collectionTradeConfirmation.swf";

        override public function execute():void{
            this.asset = this.assetService.createWrapper(ASSET_PATH);
            hook(this.asset, this.onComplete, this.onError);
        }
        private function onComplete(_arg1:Asset):void{
            var _local2:TradeInConfirmation = new TradeInConfirmation(_arg1, this.event.collections[0].reward);
            dispatch(new PanelsEvent(PanelsEvent.ADD_OVERLAY, _local2));
        }
        private function onError(_arg1:Asset, _arg2:String=""):void{
        }

    }
}//package gaia.moga.collections.control 
