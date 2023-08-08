//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.app.controller {
    import flash.display.*;
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.app.*;
    import com.adobe.serialization.json.*;
    import org.robotlegs.mvcs.*;

    public class ConfigureCommand extends Command {

		[Inject]
        public var view:DisplayObjectContainer;
		[Inject]
        public var config:AppConfig;
		[Inject]
        public var model:ApplicationModel;
		[Inject]
        public var player:PlayerModel;
		[Inject]
        public var gsi:GSIDataService;
		[Inject]
        public var videoAdModel:VideoAdModel;

        private static const MAIN_SWF:String = "Main.swf";

        override public function execute():void{
            var _local5:Object;
            var _local1:LoaderInfo = this.view.root.loaderInfo;
            //var _local2:String = _local1.loaderURL;
			var _local2:String = "http://s.cdn.gaiaonline.com/images/Gaia_Flash/social/fbapps/monsterpets/Main.swf";
            //var _local3:String = _local1.parameters.v;
			var _local3:String = "184";
            var _local4:String = _local2.substring(0, _local2.indexOf(MAIN_SWF));
            //_local5 = JSON.decode(_local1.parameters.appVars);
			var _local5:Object = _local1.parameters;
            this.config.init(_local3, _local4);
            this.model.userID = _local5.user_id;
            this.model.openBattleID = this.retrieveOpenBattle(_local5);
            this.model.version = this.retrieveVersion(_local5);
            this.model.email = _local5.user_email;
            this.model.firstName = _local5.first_name;
            this.model.picture = _local5.picture;
            this.model.setSpecial((_local5.special = ((_local5.special) || (""))));
            this.model.appUrl = _local5.app_url;
            this.model.destUrl = _local5.dest_url;
            this.model.gsiUrl = _local5.gsi_url;
            this.model.thirdPartyId = _local5.third_party_id;
            this.model.nanniganAppId = _local5.nanigan_id;
            this.model.gender = _local5.user_gender;
            this.model.locale = _local5.user_locale;
            this.model.birthday = _local5.user_birthday;
            this.model.partnerID = _local5.partnerId;
            this.model.friendReferral = _local5.friendReferral;
            if (_local5.default_zodiac){
                this.model.defaultZodiacId = uint(_local5.default_zodiac);
            };
            if (_local5.default_monster){
                this.model.defaultMonsterId = uint(_local5.default_monster);
            };
            if (((_local5.friendRanchID) && (!((_local5.friendRanchID == this.model.userID))))){
                this.model.defaultFriendID = String(_local5.friendRanchID);
                this.model.friendRanchID = String(_local5.friendRanchID);
            };
            if (_local5.one_time_announcement){
                this.model.oneTimeAnnouncements = _local5.one_time_announcement.split(",");
            };
            if (_local5.promo){
                this.model.promo = _local5.promo;
            };
            if (_local5.basket){
                this.model.showBasketPanel = Boolean(_local5.basket);
            };
            this.model.ugcEventHost = _local5.ugc_event_host_id;
            this.model.ugcEventTime = _local5.ugc_event_time;
            this.model.ugcMonsterId = _local5.ugc_monster_id;
            this.videoAdModel.isEnabled = Boolean(_local5.ad_enable);
            this.videoAdModel.minPurchaseInterval = int(_local5.ad_min_purch_int);
            this.videoAdModel.minPurchaseAmount = int(_local5.ad_min_purch);
            this.videoAdModel.videoAdInterval = int(_local5.ad_interval);
            this.videoAdModel.dormantInterval = int(_local5.ad_dormant_interval);
            this.videoAdModel.progId = String(_local5.ad_prog_id);
            if (_local5.grant_code){
                this.model.grantCode = _local5.grant_code;
            } else {
                if (_local5.daily_grant_code){
                    this.model.grantCode = _local5.daily_grant_code;
                };
            };
            this.player.id = _local5.user_id;
            this.player.userBirthday = _local5.user_birthday;
            this.player.email = _local5.user_email;
            this.gsi.init(this.model.gsiUrl);
        }
        private function retrieveOpenBattle(_arg1:Object):String{
            return (_arg1.open_battle_id);
        }
        private function retrieveVersion(_arg1:Object):String{
            return (String("3.31 v2"));
        }

    }
}//package gaia.moga.app.controller 
