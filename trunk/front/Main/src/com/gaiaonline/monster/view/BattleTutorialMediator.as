//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.sound.*;
    import gaia.moga.assets.*;
    import gaia.moga.monster.model.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.view.components.feeds.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.view.components.tutorial.*;
    import com.gaiaonline.monster.model.tracking.*;

    public class BattleTutorialMediator extends Mediator {

		[Inject]
        public var view:BattleTutorial;
		[Inject]
        public var tracking:OmnitureService;
		[Inject]
        public var sounds:SoundService;
		[Inject]
        public var music:MusicService;
		[Inject]
        public var ranch:HomeRanchModel;
		[Inject]
        public var mogas:MogaFactory;
		[Inject]
        public var fb:FBService;
		[Inject]
        public var text:TextService;
		[Inject]
        public var assets:AssetService;
        private var _feedStoryConfirm:PublishCaptureFeedConfirm;

        override public function onRegister():void{
            dispatch(new TrackingEvent(TrackingEvent.TRACK, TrackingType.START_TUTORIAL));
            this.view.complete.addOnce(this.onComplete);
            this.view.track.add(this.onTrack);
            this.view.nameMonster.add(this.onNameMonster);
            this.view.inviteClick.add(this.onInviteClick);
            this.view.inviteCancel.add(this.onInviteCancel);
            this.view.captureShare.add(this.onCaptureShare);
            this.setSounds();
        }
        private function setSounds():void{
            this.music.loadAndPlay("sounds/basic_tutorial.mp3", true);
        }
        private function onTrack(_arg1:String):void{
            dispatch(new TrackingEvent(TrackingEvent.TRACK, ("tut_" + _arg1)));
        }
        private function onNameMonster(_arg1:String):void{
            var _local2:String = this.ranch.mogas[1].id;
            dispatch(new TeamEvent(TeamEvent.NAME_MONSTER, {id:_local2, monsterName:_arg1}));
        }
        private function onComplete():void{
			//调用js 暂时注释掉
            //dispatch(new TrackingEvent(TrackingEvent.PARTNER_PIXEL, PartnerPixelType.SOMETRICS));
            //dispatch(new TrackingEvent(TrackingEvent.PARTNER_PIXEL, PartnerPixelType.DOUBLE_CLICK));
            //dispatch(new TrackingEvent(TrackingEvent.PARTNER_PIXEL, PartnerPixelType.NANIGANS));
            //dispatch(new TrackingEvent(TrackingEvent.PARTNER_PIXEL, PartnerPixelType.LIFESTREET));
            dispatch(new TrackingEvent(TrackingEvent.TRACK, TrackingType.END_TUTORIAL));
            dispatch(new ApplicationEvent(ApplicationEvent.SET_STATE, ApplicationState.WORLD));
        }
        private function onInviteClick():void{
            var _local1:Object = {};
            _local1.inviteType = this.text.getText("APPLICATION_NAME");
            _local1.popupTitle = "Your friends will help you in battle!";
            _local1.friendSelectorActionText = "Select the people you want to add as your friend";
            _local1.trackingType = "friend_tile";
            _local1.friendSelectorExcludeIds = null;
            this.fb.showInvitePopup(_local1);
        }
        private function onInviteCancel():void{
        }
        private function onCaptureShare():void{
            var _local1:MonsterModel = this.ranch.mogas[1];
            var _local2:Asset = this.assets.captureConfirm();
            var _local3:Asset = this.assets.captureStreamIcon(_local1.monsterID);
            var _local4 = (((this.text.getText("CAPTURE_STREAM_CONFIRM_MSG") + " ") + _local1.name) + "!");
            this._feedStoryConfirm = new PublishCaptureFeedConfirm(_local2, _local4, _local3, _local1);
            this._feedStoryConfirm.close.add(this.onShareClose);
            this._feedStoryConfirm.confirmed.add(this.onShareClose);
            dispatch(new PanelsEvent(PanelsEvent.ADD_OVERLAY, this._feedStoryConfirm));
        }
        private function onShareClose(_arg1=null):void{
            dispatch(new PanelsEvent(PanelsEvent.REMOVE_OVERLAY, this._feedStoryConfirm));
            this.view.continueAfterShare();
        }

    }
}//package com.gaiaonline.monster.view 
