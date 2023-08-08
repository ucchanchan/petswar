//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.whistletree.controller {
    import com.gaiaonline.monster.model.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.friendlist.model.*;
    import com.gaiaonline.monster.service.process.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.inventory.model.*;
    import gaia.moga.items.model.*;
    import gaia.moga.whistletree.event.*;
    import com.gaiaonline.monster.controller.*;
    import gaia.moga.*;

    public class HarvestWhistleTreeCommand extends AsyncCommand {

		[Inject]
        public var server:GSIDataService;
		[Inject]
        public var process:HarvestWhistleTree;
		[Inject]
        public var home:HomeRanchModel;
		[Inject]
        public var timer:TimerService;
		[Inject]
        public var event:WhistleTreeEvent;
		[Inject]
        public var inventory:InventoryModel;
		[Inject]
        public var friends:FriendsModel;

        override public function execute():void{
            dispatch(new WhistleTreeEvent(WhistleTreeEvent.DISABLE));
            this.process.friend = this.event.friend;
            hook(this.process, this.onComplete, this.onError);
        }
        private function onComplete(_arg1:Async):void{
            var _local2:InventoryItem = this.inventory.getItem(ItemEnum.WHISTLE);
            _local2.quantity = (_local2.quantity + this.process.whistlesHarvested);
            var _local3:MonsterRanchModel = (this.event.friend) ? this.event.friend : this.home;
            _local3.numWhistles = 0;
            _local3.lastHarvested = this.timer.currentTime;
            if (this.event.friend){
                this.event.friend.numWhistles = 0;
                this.friends.onWhistleHarvested(this.process.whistlesHarvested);
            } else {
                this.home.numWhistles = 0;
            };
            dispatch(new WhistleTreeEvent(WhistleTreeEvent.UPDATE));
            dispatch(new WhistleTreeEvent(WhistleTreeEvent.ENABLE));
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, Errors.UNABLE_TO_HARVEST_WHISTLES));
        }

    }
}//package gaia.moga.whistletree.controller 
