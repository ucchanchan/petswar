//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.application {
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.friendlist.model.*;
    import gaia.moga.assets.*;
    import gaia.lib.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.view.components.ads.*;

    public class InvokeSimpleAdCommand extends Command {

		[Inject]
        public var appModel:ApplicationModel;
		[Inject]
        public var cookie:Cookie;
		[Inject]
        public var player:PlayerModel;
		[Inject]
        public var assets:AssetService;
		[Inject]
        public var friends:FriendsModel;
        private var shareChance:Number;// = 0.1
        private var test:String;// = "testOff"

        private static const AD_TIME:Number = 900;
        private static const MIN_FRIENDS:int = 20;

        override public function execute():void{
            var _local1:Number = Math.random();
            var _local2:Number = this.cookie.getValue("lastTimeShownAd", 0);
            var _local3:Number = (this.appModel.currentTime - _local2);
            if ((((_local2 == 0)) || ((_local3 > AD_TIME)))){
                this.showAd();
                this.cookie.setValue("lastTimeShownAd", this.appModel.currentTime);
            };
        }
        private function showAd():void{
            var _local1:Number;
            if (((!(this.player.hasShared)) && ((this.friends.friends.length < MIN_FRIENDS)))){
                this.test = "testOn";
                _local1 = Math.random();
                if (_local1 < this.shareChance){
                    this.showShare();
                } else {
                    this.showInvite();
                };
                return;
            };
            if (!this.player.hasShared){
                this.showShare();
            } else {
                if (this.friends.friends.length < MIN_FRIENDS){
                    this.showInvite();
                };
            };
        }
        private function showInvite():void{
            var _local1:Asset = this.assets.inviteInterstitial;
            var _local2:SimpleAd = new SimpleAd(_local1, this.test, this.friends.friends.length);
            dispatch(new PanelsEvent(PanelsEvent.ADD_OVERLAY, _local2));
            dispatch(new TrackingEvent(TrackingEvent.TRACK, ("ad_open_invite_" + this.test)));
        }
        private function showShare():void{
            var _local1:Asset = this.assets.shareInterstitial;
            var _local2:SimpleAd = new SimpleAd(_local1, this.test);
            dispatch(new PanelsEvent(PanelsEvent.ADD_OVERLAY, _local2));
            dispatch(new TrackingEvent(TrackingEvent.TRACK, ("ad_open_share_" + this.test)));
        }

    }
}//package com.gaiaonline.monster.controller.application 
