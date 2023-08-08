//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.ugc.controller {
    import com.gaiaonline.monster.model.vo.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.model.world.*;
    import gaia.moga.ugc.model.*;
    import gaia.moga.friendlist.model.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.inventory.model.*;
    import gaia.moga.items.model.*;
    import com.gaiaonline.monster.controller.*;
    import gaia.moga.ugc.service.*;
    import com.gaiaonline.monster.view.components.itemGrant.*;

    public class AttendUGCEventCommand extends AsyncCommand {

        public var server:GSIDataService;
        public var event:UGCEvent;
        public var model:ApplicationModel;
        public var world:WorldModel;
        public var assets:AssetService;
        public var factory:MonsterAssetsFactory;
        public var text:TextService;
        public var process:AttendUGCEventProcess;
        public var friends:FriendsModel;
        public var inventoryModel:InventoryModel;
        private var asset:Asset;

        override public function execute():void{
            this.asset = this.assets.createWrapper("assets/ui/itemGrant.swf");
            var _local1:AsyncCollection = new AsyncCollection();
            _local1.add(this.process);
            _local1.add(this.asset);
            hook(_local1, this.onComplete, this.onError);
        }
        private function onComplete(_arg1:Async):void{
            _arg1.error.removeAll();
            var _local2:UGCGrants = this.process.grants;
            var _local3:uint = _local2.count;
            if (_local3){
                this.describeGrants(_local2.get(0));
            } else {
                this.describeFail();
            };
        }
        private function describeGrants(_arg1:GrantVO):void{
            var _local7:ItemGrantType;
            if (_arg1.isMonster){
                this.addOverlay("You get 1 Icevia", ItemGrantType.MONSTER, 238, this.factory.monsterFightByID(238));
                return;
            };
            var _local2:Item = _arg1.type;
            var _local3:uint = _local2.id;
            var _local4:Asset = this.assets.itemIcon(_local3);
            var _local5:Friend = this.friends.getFriendByID(_arg1.host);
            var _local6:String = this.text.getText("ATTEND_UGC_EVENT_MSG", {PRIZE:_local2.name, QUANT:_arg1.quantity, FRIEND:_local5.name});
            if (_local3 == ItemEnum.DAILY_PRIZE){
                _local7 = ItemGrantType.RIG_ITEM;
            } else {
                _local7 = ItemGrantType.BASIC_ITEM;
            };
            this.addOverlay(_local6, _local7, _local3, _local4);
        }
        private function describeFail():void{
            var _local1:String = this.text.getText("UGC_EVENT_FAILED");
            var _local2:ItemGrantType = ItemGrantType.UNKNOWN_ITEM;
            this.addOverlay(_local1, _local2, -1, null);
        }
        private function addOverlay(_arg1:String, _arg2:ItemGrantType, _arg3:int, _arg4:Asset):void{
            var _local5:ItemGrant = new ItemGrant(this.asset, _arg1, _arg2, -1, _arg4);
            dispatch(new PanelsEvent(PanelsEvent.ADD_OVERLAY, _local5));
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 401));
        }

    }
}//package gaia.moga.ugc.controller 
