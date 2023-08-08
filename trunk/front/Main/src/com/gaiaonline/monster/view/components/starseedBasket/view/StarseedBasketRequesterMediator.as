//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.starseedBasket.view {
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.friendlist.model.*;
    import com.gaiaonline.monster.view.components.starseedBasket.model.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.service.*;
    import alecmce.list.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.view.components.starseedBasket.event.*;
    import com.gaiaonline.monster.view.components.starseedBasket.view.ui.receiver.*;
    import flash.desktop.*;

    public class StarseedBasketRequesterMediator extends Mediator {

		[Inject]
        public var view:StarseedBasketRequesterPanel;
		[Inject]
        public var basketModel:StarseedBasketModel;
		[Inject]
        public var textService:TextService;
		[Inject]
        public var assetService:AssetService;
		[Inject]
        public var fb:FBService;
		[Inject]
        public var friends:FriendsModel;
		[Inject]
        public var appModel:ApplicationModel;
		[Inject]
        public var timer:TimerService;

        private static const NOVA_FB_ID:String = "100001591722543";

        override public function onRegister():void{
            this.view.closeClick.addOnce(this.onCloseClick);
            this.view.moreFriendsClick.add(this.onMoreFriendsClick);
            this.view.getStarseedsClick.add(this.onGetStarseedsClick);
            this.view.collectGiftsClick.add(this.onCollectGiftsClick);
            this.view.inviteFriendsClick.add(this.onInviteFriendsClick);
            this.view.askForStarseedsClick.add(this.onAskForStarseedsClick);
            this.view.collectSeedsClick.add(this.onCollectSeedsClick);
            this.view.visitSkyShopClick.add(this.onVisitSkyShopClick);
            this.view.copyToClipboardClick.add(this.onCopyToClipboardClick);
            var _local1 = (this.appModel.state == ApplicationState.HOME);
            var _local2:String = this.textService.getStarseedsToCollectText(this.basketModel.receivedCount, _local1);
            this.view.setToCollectCount(this.basketModel.receivedCount, _local2, _local1);
            this.view.setLinkText(this.assetService.getStarseedBasketShareLink(this.friends.me.id));
            this.setHistory();
            this.setFriendsWithSeeds();
            this.basketModel.updated.add(this.onBasketUpdated);
            if ((((0 < this.basketModel.receivedCount)) && (_local1))){
                this.view.showCollectGiftsView();
            };
            addContextListener(ApplicationEvent.SET_STATE, this.onApplicationStateChange, ApplicationEvent, false, 0, true);
        }
        override public function onRemove():void{
            this.view.closeClick.remove(this.onCloseClick);
            this.view.moreFriendsClick.remove(this.onMoreFriendsClick);
            this.view.getStarseedsClick.remove(this.onGetStarseedsClick);
            this.view.collectGiftsClick.remove(this.onCollectGiftsClick);
            this.view.inviteFriendsClick.remove(this.onInviteFriendsClick);
            this.view.askForStarseedsClick.remove(this.onAskForStarseedsClick);
            this.view.visitSkyShopClick.remove(this.onVisitSkyShopClick);
            this.view.dispose();
            this.basketModel.updated.remove(this.onBasketUpdated);
        }
        private function onApplicationStateChange(_arg1:ApplicationEvent):void{
            dispatch(new PanelsEvent(PanelsEvent.REMOVE_OVERLAY, this.view));
        }
        private function onBasketUpdated():void{
            var _local1 = (this.appModel.state == ApplicationState.HOME);
            var _local2:String = this.textService.getStarseedsToCollectText(this.basketModel.receivedCount, _local1);
            this.view.setToCollectCount(this.basketModel.receivedCount, _local2, _local1);
        }
        private function setHistory():void{
            var _local3:String;
            var _local4:Friend;
            var _local5:uint;
            var _local6:uint;
            var _local7:FriendGiftEntry;
            var _local1:Object = this.basketModel.received;
            var _local2:Vector.<ListDatum> = new Vector.<ListDatum>();
            FriendGiftEntry.textService = this.textService;
            for (_local3 in _local1) {
                _local4 = this.friends.getFriendByID(_local3);
                if (_local4){
                    _local5 = uint(_local1[_local3].activity_bundle.avail);
                    _local6 = (this.timer.currentTime - uint(_local1[_local3].last_updated));
                    _local7 = new FriendGiftEntry(_local4, _local5, _local6);
                    _local2.push(_local7);
                };
            };
            this.view.setHistory(_local2);
        }
        private function setFriendsWithSeeds():void{
            var _local2:Friend;
            var _local3:FriendWithSeedEntry;
            var _local1:Vector.<ListDatum> = new Vector.<ListDatum>();
            for each (_local2 in this.friends.friends) {
                if ((((0 < _local2.availableGiftCount)) && (!((_local2.id == NOVA_FB_ID))))){
                    _local3 = new FriendWithSeedEntry(_local2);
                    _local3.postOnWallClick.add(this.onGetStarseedsFriendPostOnWallClick);
                    _local1.push(_local3);
                };
            };
            this.view.setFriendsWithSeeds(_local1, this.basketModel.grantLimit);
        }
        private function onGetStarseedsFriendPostOnWallClick(_arg1:Friend):void{
            var _local2:String = this.textService.getStarseedRequestMainMessage(this.appModel.firstName);
            var _local3:String = this.textService.getStarseedRequestSecondaryMessage(this.appModel.firstName);
            var _local4:String = this.assetService.starseedRequestIconString;
            this.fb.publishWallToWallStarseedRequest(this.appModel.userID, _arg1.id, _local4, _local2, _local3);
        }
        private function onCloseClick():void{
            dispatch(new PanelsEvent(PanelsEvent.REMOVE_OVERLAY, this.view));
        }
        private function onMoreFriendsClick():void{
            this.view.showMoreFriendsView();
        }
        private function onGetStarseedsClick():void{
            this.view.showGetStarseedsView();
        }
        private function onCollectGiftsClick():void{
            this.view.showCollectGiftsView();
        }
        private function onCollectSeedsClick():void{
            var _local2:String;
            var _local3:StarseedBasketEvent;
            var _local4:Object;
            var _local5:uint;
            var _local1:Object = {};
            for (_local2 in this.basketModel.received) {
                _local4 = this.basketModel.received[_local2];
                _local5 = uint(_local4.activity_bundle.avail);
                if (0 < _local5){
                    _local1[_local2] = _local5;
                };
            };
            _local3 = new StarseedBasketEvent(StarseedBasketEvent.COLLECT_STARSEEDS);
            _local3.data = _local1;
            dispatch(_local3);
        }
        private function onInviteFriendsClick():void{
            this.fb.showInvitePopup(null);
        }
        private function onAskForStarseedsClick():void{
            var _local1:String = this.textService.getStarseedRequestMainMessage(this.appModel.firstName);
            var _local2:String = this.textService.getStarseedRequestSecondaryMessage(this.appModel.firstName);
            var _local3:String = this.assetService.starseedRequestIconString;
            this.fb.publishStarseedRequest(this.appModel.userID, _local3, _local1, _local2);
        }
        private function onVisitSkyShopClick():void{
            dispatch(new ApplicationEvent(ApplicationEvent.INVOKE_STORE));
        }
        private function onCopyToClipboardClick():void{
            var _local1:String = this.assetService.getStarseedBasketShareLink(this.friends.me.id);
            Clipboard.generalClipboard.clear();
            Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, _local1, false);
        }

    }
}//package com.gaiaonline.monster.view.components.starseedBasket.view 
