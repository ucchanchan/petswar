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
    import com.gaiaonline.monster.service.*;
    import gaia.moga.inventory.model.*;
    import com.gaiaonline.monster.controller.*;
    import com.gaiaonline.monster.view.components.itemGrant.*;

    public class RetrieveItemGrantCommand extends AsyncCommand {

        public var retrieveItem:RetrieveItemGrantProcess;
        public var model:ApplicationModel;
        public var world:WorldModel;
        public var assets:AssetService;
        public var grantModel:ItemGrantModel;
        public var factory:MonsterAssetsFactory;
        public var text:TextService;
        public var inventoryModel:InventoryModel;
        private var grantAsset:Asset;

        private static const ITEM_GRANT_SCREEN:String = "assets/ui/itemGrant.swf";
        private static const GRANT_MSG:String = "GRANT_MSG";
        private static const GRANT_FAILED:String = "GRANT_FAILED";

        override public function execute():void{
            this.grantAsset = this.assets.createWrapper(ITEM_GRANT_SCREEN);
            var _local1:AsyncCollection = new AsyncCollection();
            _local1.add(this.retrieveItem);
            _local1.add(this.grantAsset);
            hook(_local1, this.onComplete, this.onError);
        }
        private function onComplete(_arg1:Async):void{
            var _local2:Asset;
            var _local3:String;
            var _local5:String;
            var _local6:int;
            if (!this.grantModel.id){
                _local3 = this.text.getText(GRANT_FAILED);
            } else {
                if (this.grantModel.type == ItemGrantType.MONSTER){
                    _local2 = this.factory.monsterFightByID(this.grantModel.id);
                    _local3 = (((this.text.getText(GRANT_MSG) + " ") + this.grantModel.name) + ":");
                } else {
                    _local2 = this.assets.itemIcon(this.grantModel.id);
                    _local5 = "";
                    if (this.grantModel.quantity > 1){
                        _local5 = "s";
                    };
                    _local3 = ((((((this.text.getText(GRANT_MSG) + " ") + this.grantModel.quantity) + " ") + this.grantModel.name) + _local5) + ":");
                    _local6 = this.inventoryModel.getItem(this.grantModel.id).quantity;
                    _local6 = (_local6 + int(this.grantModel.quantity));
                    this.inventoryModel.setItem(this.grantModel.id, _local6);
                };
            };
            var _local4:ItemGrant = new ItemGrant(this.grantAsset, _local3, this.grantModel.type, this.grantModel.id, _local2);
            dispatch(new PanelsEvent(PanelsEvent.ADD_OVERLAY, _local4));
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 201));
        }

    }
}//package com.gaiaonline.monster.controller.application 
