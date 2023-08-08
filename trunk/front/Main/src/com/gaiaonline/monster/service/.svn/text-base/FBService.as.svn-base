//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service {
    import com.gaiaonline.monster.model.vo.*;
    import com.gaiaonline.monster.model.*;
    import gaia.moga.assets.*;
    import flash.external.*;

    public class FBService extends ExternalInterfaceService {

		[Inject]
        public var model:PlayerModel;
		[Inject]
        public var appModel:ApplicationModel;
		[Inject]
        public var assetService:AssetService;
        private var pendingCoinPurchase:int;
        private var pendingPostMonsterId:uint;

        public function publishCapture(_arg1:String, _arg2:uint, _arg3:String, _arg4:String, _arg5:String, _arg6:CreateUGCEventVO, _arg7:String):void{
            var _local14:String;
            var _local8:String = ("capture_" + _arg2);
            var _local9:String = _arg1;
            var _local10:String = ((((((this.appModel.appUrl + "?ugc_event_host_id=") + this.model.id) + "&ugc_event_time=") + _arg6.timestamp) + "&ugc_monster_id=") + _arg7);
            this.pendingPostMonsterId = _arg2;
            var _local11:StreamAttachment = this.createBasicStreamAttachment(_local10, _arg4, _arg5, _local9);
            var _local12 = "";
            var _local13:Array = [new ActionLink("Get Free Whistle!", _local10)];
            var _local15 = "Tell your friends!";
            this.publishStream(_local12, _local11, _local13, _local14, _local15, _local8);
        }
        public function publishQuestHelpRequest(_arg1:uint, _arg2:String, _arg3:String, _arg4:String):void{
            var _local11:String;
            var _local5:String = ("requestQuestHelp_" + _arg1);
            var _local6:String = ((((((this.appModel.appUrl + "?ugc_event_host_id=") + this.model.id) + "&ugc_event_time=") + _arg4) + "&ugc_quest_id=") + _arg1);
            var _local7:String = this.assetService.questHelpIconString(_arg1);
            var _local8:StreamAttachment = this.createBasicStreamAttachment(_local6, _arg2, _arg3, _local7);
            var _local9 = "";
            var _local10:Array = [new ActionLink("Help And Get Free Whistle!", _local6)];
            var _local12 = "Tell your friends!";
            this.publishStream(_local9, _local8, _local10, _local11, _local12, _local5);
        }
        public function publishQuestCompleteShare(_arg1:uint, _arg2:String, _arg3:String, _arg4:String):void{
            var _local11:String;
            var _local5:String = ("completeQuestShare_" + _arg1);
            var _local6:String = ((((((this.appModel.appUrl + "?ugc_event_host_id=") + this.model.id) + "&ugc_event_time=") + _arg4) + "&ugc_quest_id=") + _arg1);
            var _local7:String = this.assetService.questCompleteIconString(_arg1);
            var _local8:Object = {href:_local6, name:_arg2, caption:_arg3, media:[{type:"image", src:_local7, href:_local6}]};
            var _local9 = "";
            var _local10:Array = [{text:"Click For Free Whistle!", href:_local6}];
            var _local12 = "Tell your friends!";
            ExternalInterface.addCallback("onPublish", this.onPublish);
            pauseGame();
            ExternalInterface.call("showStreamPublishDialog", _local9, _local8, _local10, _local11, _local12, _local5, "onPublish");
        }
        public function publishSpecialEvent(_arg1:String, _arg2:String):void{
            var _local8:String;
            var _local3:String = this.appModel.appUrl;
            var _local4:String = this.assetService.aprilStreamUrl();
            var _local5:Object = {href:_local3, name:_arg1, caption:_arg2, media:[{type:"image", src:_local4, href:_local3}]};
            var _local6 = "";
            var _local7:Array = [{text:"Check it out!", href:_local3}];
            var _local9 = "Tell your friends!";
            ExternalInterface.addCallback("onPublish", this.onPublish);
            pauseGame();
            ExternalInterface.call("showStreamPublishDialog", _local6, _local5, _local7, _local8, _local9, "april_fools", "onPublish");
        }
        public function publishLevelUp(_arg1:String, _arg2:uint, _arg3:String, _arg4:String, _arg5:String, _arg6:CreateUGCEventVO, _arg7:String, _arg8:uint):void{
            var _local15:String;
            var _local9:String = ("levelUp_" + _arg8);
            var _local10:String = _arg1;
            var _local11:String = ((((((this.appModel.appUrl + "?ugc_event_host_id=") + this.model.id) + "&ugc_event_time=") + _arg6.timestamp) + "&ugc_monster_id=") + _arg7);
            this.pendingPostMonsterId = _arg2;
            var _local12:StreamAttachment = this.createBasicStreamAttachment(_local11, _arg4, _arg5, _local10);
            var _local13 = "";
            var _local14:Array = [new ActionLink("Get Free Whistle!", _local11)];
            var _local16 = "Tell your friends!";
            this.publishStream(_local13, _local12, _local14, _local15, _local16, _local9);
        }
        public function publishStarseedRequest(_arg1:String, _arg2:String, _arg3:String, _arg4:String):void{
            var _local5 = (((this.appModel.appUrl + "?id=") + _arg1) + "&basket=1");
            var _local6:StreamAttachment = this.createBasicStreamAttachment(_local5, _arg3, _arg4, _arg2);
            var _local7:Array = [new ActionLink("Gift Free Starseed!", _local5)];
            var _local8 = "Tell your friends!";
            this.publishStream("", _local6, _local7, "", _local8, "starseedStreamRequest");
        }
        public function publishWallToWallStarseedRequest(_arg1:String, _arg2:String, _arg3:String, _arg4:String, _arg5:String):void{
            var _local6 = (((this.appModel.appUrl + "?id=") + _arg1) + "&basket=1");
            var _local7:StreamAttachment = this.createBasicStreamAttachment(_local6, _arg4, _arg5, _arg3);
            var _local8:Array = [new ActionLink("Gift Free Starseed!", _local6)];
            var _local9 = "Tell your friends!";
            this.publishStream("", _local7, _local8, _arg2, _local9, "starseedWallToWallRequest");
        }
        public function publishStarseedGiftNotice(_arg1:String, _arg2:String, _arg3:String, _arg4:String):void{
            var _local5 = (((this.appModel.appUrl + "?id=") + _arg1) + "&basket=1");
            var _local6:StreamAttachment = this.createBasicStreamAttachment(_local5, _arg3, _arg4, _arg2);
            var _local7:Array = [new ActionLink("See Starseeds!", _local5)];
            var _local8 = "Tell your friend!";
            this.publishStream("", _local6, _local7, _arg1, _local8, "starseedGiftNotice");
        }
        public function createBasicStreamAttachment(_arg1:String, _arg2:String, _arg3:String, _arg4:String=""):StreamAttachment{
            var _local5:StreamAttachment = new StreamAttachment();
            _local5.href = _arg1;
            _local5.name = _arg2;
            _local5.caption = _arg3;
            if (_arg4 == ""){
                _local5.media = [];
            } else {
                _local5.media[0].type = "image";
                _local5.media[0].src = _arg4;
                _local5.media[0].href = _arg1;
            };
            return (_local5);
        }
        public function publishStream(_arg1:String, _arg2:StreamAttachment, _arg3:Array, _arg4:String, _arg5:String, _arg6:String):void{
            ExternalInterface.addCallback("onPublish", this.onPublish);
            pauseGame();
            ExternalInterface.call("showStreamPublishDialog", _arg1, _arg2, _arg3, _arg4, _arg5, _arg6, "onPublish");
        }
        public function premiumCoinPurchase(_arg1:StoreItemVO):void{
            var _local2:Object = {};
            _local2.item_id = ((_arg1.type + "_") + _arg1.id);
            this.pendingCoinPurchase = _arg1.quantity;
            ExternalInterface.addCallback("onPlaceOrder", this.onPlaceOrder);
            ExternalInterface.call("placeOrder", _local2, null);
        }
        private function onPlaceOrder(_arg1=null):void{
            if (((_arg1) && ((_arg1.status == "settled")))){
                this.model.premiumCurrency = (this.model.premiumCurrency + this.pendingCoinPurchase);
            };
        }
        public function showPromoPopup(_arg1:Object):void{
            var _local2 = "Give your friends an Icevia";
            ExternalInterface.addCallback("onClosePopup", onClosePopup);
            var _local3 = (this.appModel.appUrl + "?ugc_event_host_id=100000539574765&ugc_event_time=1301343002");
            pauseGame();
            ExternalInterface.call("openPromoPicker", _local2, "onClosePopup", _local3);
        }
        public function showInvitePopup(_arg1:Object):void{
            var _local2 = "Invite Friends";
            ExternalInterface.addCallback("onClosePopup", onClosePopup);
            pauseGame();
            ExternalInterface.call("openInvitePicker", _local2, "onClosePopup");
        }
        public function showWhistleTreeReminderPopup(_arg1:Object):void{
            var _local2:String = (_arg1.popupTitle) ? _arg1.popupTitle : "Send Reminder";
            ExternalInterface.addCallback("onClosePopup", onClosePopup);
            pauseGame();
            ExternalInterface.call("openTreeReminderPicker", _local2, "onClosePopup", _arg1.friendId);
        }
        public function showWhistleReportThankYouPopup(_arg1:Object):void{
            var _local2 = "Thank you for calling my Moga";
            ExternalInterface.addCallback("onClosePopup", onClosePopup);
            var _local3:String = ((((this.appModel.appUrl + "?ugc_event_host_id=") + this.model.id) + "&ugc_event_time=") + _arg1.eventTime);
            pauseGame();
            ExternalInterface.call("openWhistleReportThankYouPicker", _local2, "onClosePopup", _arg1.selectedFriend, _local3);
        }
        public function showSharePopup():void{
            var _local1 = (this.appModel.destUrl + "share");
            ExternalInterface.call("openShare", _local1, this.appModel.version);
        }
        private function onPublish(_arg1=null):void{
            unpause.dispatch();
        }

    }
}//package com.gaiaonline.monster.service 

class ActionLink {

    public var text:String;
    public var href:String;

    public function ActionLink(_arg1:String, _arg2:String){
        this.text = _arg1;
        this.href = _arg2;
    }
}
class StreamAttachment {

    public var href:String;
    public var name:String;
    public var caption:String;
    public var media:Array;

    public function StreamAttachment(){
        this.media = [new StreamAttachmentMedia()];
    }
}
class StreamAttachmentMedia {

    public var type:String;
    public var src:String;
    public var href:String;

    public function StreamAttachmentMedia(){
    }
}
