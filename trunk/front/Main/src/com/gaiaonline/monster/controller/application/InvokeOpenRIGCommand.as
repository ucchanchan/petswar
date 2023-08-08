//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.application {
    import com.gaiaonline.monster.model.vo.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.model.world.*;
    import com.gaiaonline.monster.service.process.*;
    import gaia.moga.assets.*;
    import gaia.moga.monster.model.*;
    import com.gaiaonline.monster.service.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.view.components.itemGrant.*;

    public class InvokeOpenRIGCommand extends Command {

        public var retrieveItem:RetrieveRIGItemProcess;
        public var model:ApplicationModel;
        public var world:WorldModel;
        public var assets:AssetService;
        public var grantModel:ItemGrantModel;
        public var factory:MonsterAssetsFactory;
        public var text:TextService;
        public var ranch:HomeRanchModel;
        public var mogas:MogaFactory;
        private var grantAsset:Asset;

        private static const ITEM_GRANT_SCREEN:String = "assets/ui/itemGrant.swf";
        private static const GRANT_MSG:String = "GRANT_MSG";
        private static const GRANT_FAILED:String = "GRANT_FAILED";

        override public function execute():void{
            this.grantAsset = this.assets.createWrapper(ITEM_GRANT_SCREEN);
            var _local1:AsyncCollection = new AsyncCollection();
            _local1.add(this.retrieveItem);
            _local1.add(this.grantAsset);
            if (_local1.isError){
                this.onError(_local1);
            } else {
                _local1.error.addOnce(this.onError);
            };
            if (_local1.isComplete){
                this.onComplete(_local1);
            } else {
                _local1.complete.addOnce(this.onComplete);
            };
            _local1.init();
            commandMap.detain(this);
        }
        private function onComplete(_arg1:Async):void{
            var _local2:Asset;
            var _local3:String;
            _arg1.error.removeAll();
            var _local4 = "";
            if (this.grantModel.quantity > 1){
                _local4 = "s";
            };
            if (!this.grantModel.id){
                _local3 = this.text.getText(GRANT_FAILED);
            } else {
                _local3 = ((((((this.text.getText(GRANT_MSG) + " ") + this.grantModel.quantity) + " ") + this.grantModel.name) + _local4) + ":");
            };
            if (this.grantModel.type == ItemGrantType.MONSTER){
                _local2 = this.factory.monsterFightByID(this.grantModel.id);
                dispatch(new TeamEvent(TeamEvent.ADD_TO_RANCH, this.mogas.read(String(this.grantModel.id))));
            } else {
                _local2 = this.assets.itemIcon(this.grantModel.id);
            };
            var _local5:ItemGrant = new ItemGrant(this.grantAsset, _local3, this.grantModel.type, this.grantModel.id, _local2);
            dispatch(new PanelsEvent(PanelsEvent.ADD_OVERLAY, _local5));
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 204));
        }

    }
}//package com.gaiaonline.monster.controller.application 
