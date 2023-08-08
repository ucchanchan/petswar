//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.application {
    import com.gaiaonline.monster.model.vo.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.inventory.model.*;
    import gaia.moga.items.model.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.view.components.itemGrant.*;

    public class OpenExistingRIGCommand extends Command {

        public var assets:AssetService;
        public var text:TextService;
        public var inventory:InventoryModel;
        private var grantAsset:Asset;

        private static const GRANT_MSG:String = "GRANT_MSG";
        private static const ITEM_GRANT_SCREEN:String = "assets/ui/itemGrant.swf";

        override public function execute():void{
            this.grantAsset = this.assets.createWrapper(ITEM_GRANT_SCREEN);
            var _local1:InventoryItem = this.inventory.getItem(ItemEnum.DAILY_PRIZE);
            var _local2:Asset = new MovieClipAssetLoader(_local1.type.vector);
            var _local3 = (((this.text.getText(GRANT_MSG) + " ") + _local1.type.name) + ":");
            var _local4:ItemGrant = new ItemGrant(this.grantAsset, _local3, ItemGrantType.RIG_ITEM, ItemEnum.DAILY_PRIZE, _local2);
            dispatch(new PanelsEvent(PanelsEvent.ADD_OVERLAY, _local4));
        }

    }
}//package com.gaiaonline.monster.controller.application 
