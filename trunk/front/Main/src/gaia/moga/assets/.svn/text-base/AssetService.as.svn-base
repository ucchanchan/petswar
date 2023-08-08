//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.assets {
    import com.gaiaonline.monster.model.vo.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.view.components.battle.background.*;
    import gaia.moga.collections.model.*;
    import gaia.moga.friendlist.view.ui.*;
    import gaia.moga.friendlist.model.*;
    import gaia.moga.data.*;
    import com.gaiaonline.monster.model.zodiac.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.app.*;
    import org.robotlegs.mvcs.*;
    import alecmce.ui.pool.*;
    import com.gaiaonline.monster.model.tracking.*;

    public class AssetService extends Actor {

        private const TOKEN:String = "@TOKEN@";
        private const SUBTOKEN:String = "@SUB@";
        private const FG:String = "FG";
        private const MG:String = "MG";
        private const BG:String = "BG";

		[Inject]
        public var config:AppConfig;
		[Inject]
        public var appModel:ApplicationModel;
		[Inject]
        public var icons:IconService;
		[Inject]
        public var zodiacs:ZodiacModel;
		[Inject]
        public var text:TextService;
		[Inject]
        public var data:DataBundle;
        private var pool:AssetPool;
        private var singletons:AssetSingletons;
        private var friendListSingleton:FriendList;
        private var url:String;

        private static const CAPTURE_ASSET_POSITION_HACK:int = -42;

        public function AssetService(){
            this.pool = new AssetPool();
            this.singletons = new AssetSingletons();
        }
        public function get currentLocationMarkerUI():Asset{
            return (this.createWrapper("assets/world/currentLocationMarker.swf"));
        }
        public function get locationInfoUI():Asset{
            return (this.createWrapper("assets/world/locationInfo.swf"));
        }
        public function get monsterCard():Asset{
            return (this.createWrapper("assets/ui/monsterCard.swf"));
        }
        public function get friendTabAsset():Asset{
            return (this.createWrapper("assets/ui/friendtab.swf"));
        }
        public function get topUI():Asset{
            return (this.createWrapper("assets/ui/top.swf"));
        }
        public function get whistleAlert():Asset{
            return (this.createWrapper("assets/ui/whistleAlert.swf"));
        }
        public function get whistleAlertPrompt():Asset{
            return (this.createWrapper("assets/ui/whistleAlertPrompt.swf"));
        }
        public function get menuUI():Asset{
            return (this.createWrapper("assets/ui/menu.swf"));
        }
        public function get monsterDexUI():Asset{
            return (this.createWrapper("assets/ui/monsterDex.swf"));
        }
        public function get smallTeamUI():Asset{
            return (this.createWrapper("assets/ui/smallteam.swf"));
        }
        public function get npcTeamUI():Asset{
            return (this.createWrapper("assets/ui/npcteam.swf"));
        }
        public function get winAsset():Asset{
            return (this.createWrapper("assets/battle/win.swf"));
        }
        public function get winItemsAsset():Asset{
            return (this.createWrapper("assets/battle/winItems.swf"));
        }
        public function get winItemAsset():Asset{
            return (this.createWrapper("assets/battle/winItemAnim.swf"));
        }
        public function getTutorialSwf(_arg1:String):Asset{
            return (this.createWrapper("assets/tutorial/@TOKEN@.swf".replace(this.TOKEN, _arg1)));
        }
        public function itemIcon(_arg1:uint):Asset{
            var _local2:String = "assets/inventory/@TOKEN@.swf".replace(this.TOKEN, _arg1);
            return (this.createWrapper(_local2));
        }
        public function collectionIcon(_arg1:uint):Asset{
            var _local2:uint = (_arg1 - 1000);
            var _local3 = (("images/monster_thumb/card_thumb/card_" + _local2) + ".png");
            return (this.createWrapper(_local3));
        }
        public function get loseAsset():Asset{
            return (this.createWrapper("assets/battle/lose.swf"));
        }
        public function get shareInterstitial():Asset{
            return (this.createWrapper("assets/ui/shareInterstitial.swf"));
        }
        public function get inviteInterstitial():Asset{
            return (this.createWrapper("assets/ui/inviteInterstitial.swf"));
        }
        public function get dailyPrizeSwf():Asset{
            return (this.createWrapper("assets/ui/dailyPrize.swf"));
        }
        public function get whistleTreeReminder():Asset{
            return (this.createWrapper("assets/ui/whistleTreeInterstitial.swf"));
        }
        public function get prizeTimer():Asset{
            return (this.createWrapper("assets/ui/prizeTimer.swf"));
        }
        public function get recurringPrizePrompt():Asset{
            return (this.createWrapper("assets/ui/recurringPrizePrompt.swf"));
        }
        public function friendHelpInAsset():Asset{
            return (this.createWrapper("assets/battle/friend_in.swf"));
        }
        public function friendHelpOutAsset():Asset{
            return (this.createWrapper("assets/battle/friend_out.swf"));
        }
        public function surpriseAttackAsset():Asset{
            return (this.createWrapper("assets/battle/surprise_attack.swf"));
        }
        public function autoHarvester():Asset{
            return (this.createWrapper("assets/autoHarvester/autoHarvester.swf"));
        }
        public function autoHarvesterPrompt():Asset{
            return (this.createWrapper("assets/autoHarvester/autoHarvesterPrompt.swf"));
        }
        public function get tryCaptureAsset():Asset{
            var _local1:Asset;
            _local1 = this.createWrapper("assets/battle/captureTry.swf");
            _local1.self.y = CAPTURE_ASSET_POSITION_HACK;
            return (_local1);
        }
        public function get captureYesAsset():Asset{
            var _local1:Asset = this.createWrapper("assets/battle/captureYes.swf");
            _local1.self.y = CAPTURE_ASSET_POSITION_HACK;
            return (_local1);
        }
        public function get captureNoAsset():Asset{
            var _local1:Asset = this.createWrapper("assets/battle/captureNo.swf");
            _local1.self.y = CAPTURE_ASSET_POSITION_HACK;
            return (_local1);
        }
        public function get captureResultAsset():Asset{
            return (this.createWrapper("assets/battle/capture.swf"));
        }
        public function get battleUI():Asset{
            return (this.createWrapper("assets/ui/battle.swf"));
        }
        public function storyLocation(_arg1:String):Asset{
            return (this.createWrapper("assets/locations/story/@TOKEN@.swf".replace(this.TOKEN, _arg1)));
        }
        public function monsterEmoteAsset(_arg1:String):String{
            return (this.config.parseURL("assets/emotes/@TOKEN@.swf".replace(this.TOKEN, _arg1)));
        }
        public function worldUIPath(_arg1:String):Asset{
            var _local2:String = "assets/ui/world/@TOKEN@.swf".replace(this.TOKEN, _arg1);
            return (this.createWrapper(_local2));
        }
        public function buffIcon(_arg1:uint):Asset{
            var _local2:String = this.icons.mapBuffIcon(_arg1);
            var _local3:String = "assets/buffs/@TOKEN@.swf".replace(this.TOKEN, _local2);
            return (this.createWrapper(_local3));
        }
        public function buffAnim():Asset{
            return (this.createWrapper("assets/effects/buff.swf"));
        }
        public function debuffAnim():Asset{
            return (this.createWrapper("assets/effects/debuff.swf"));
        }
        public function stunnedAnim():Asset{
            return (this.createWrapper("assets/effects/stunned.swf"));
        }
        public function criticalSCT():Asset{
            return (this.createWrapper("assets/battle/sct_damage_critical.swf"));
        }
        public function damageSCT():Asset{
            return (this.createWrapper("assets/battle/sct_damage.swf"));
        }
        public function missSCT():Asset{
            return (this.createWrapper("assets/battle/sct_miss.swf"));
        }
        public function failSCT():Asset{
            return (this.createWrapper("assets/battle/sct_fail.swf"));
        }
        public function healSCT():Asset{
            return (this.createWrapper("assets/battle/sct_heal.swf"));
        }
        public function loseTurnSCT():Asset{
            return (this.createWrapper("assets/battle/sct_loseturn.swf"));
        }
        public function gainTurnSCT():Asset{
            return (this.createWrapper("assets/battle/sct_gainturn.swf"));
        }
        public function loadingAsset():Asset{
            return (this.createWrapper("assets/ui/loading.swf"));
        }
        public function effectAsset(_arg1:String):Asset{
            return (this.createWrapper("assets/effects/@TOKEN@.swf".replace(this.TOKEN, _arg1)));
        }
        public function videoPlayer():Asset{
            return (this.createWrapper("assets/videoAds/tremor.swf"));
        }
        public function getWhistleReportLevelUpAsset():Asset{
            return (this.createWrapper("assets/ui/whistleReportLevelUp.swf"));
        }
        public function getWhistleReportItemBonusAsset():Asset{
            return (this.createWrapper("assets/ui/mogaFriendBonuses.swf"));
        }
        public function generateBackground(_arg1:uint):Background{
            var _local2:Asset = this.backgroundAsset(_arg1, this.BG);
            var _local3:Asset = this.backgroundAsset(_arg1, this.MG);
            var _local4:Asset = this.backgroundAsset(_arg1, this.FG);
            return (new Background(_local2, _local3, _local4));
        }
        public function backgroundAsset(_arg1:uint, _arg2:String):Asset{
            var _local3 = "assets/locations/@TOKEN@@SUB@.swf";
            _local3 = _local3.replace(this.TOKEN, _arg1);
            _local3 = _local3.replace(this.SUBTOKEN, _arg2);
            return (this.createWrapper(_local3));
        }
        public function backgroundThumbnail(_arg1:uint):Asset{
            var _local2 = "images/location_thumb/@TOKEN@_BG.jpg";
            _local2 = _local2.replace(this.TOKEN, _arg1);
            return (this.createWrapper(_local2));
        }
        public function get storeTileLocation():String{
            return (this.config.parseURL("assets/ui/storeTile.swf"));
        }
        public function get callOut():Asset{
            return (this.createWrapper("assets/battle/call_out.swf"));
        }
        public function get callOutAfter():Asset{
            return (this.createWrapper("assets/battle/call_out_after.swf"));
        }
        public function get teamFightAnim():Asset{
            return (this.createWrapper("assets/battle/teamFightAnim.swf"));
        }
        public function get specialEventBattleAnim():Asset{
            return (this.createWrapper("assets/battle/specialEventAnim.swf"));
        }
        public function zodiacIcon(_arg1:uint):Asset{
            var _local2:String = "assets/horoscope/@TOKEN@.swf".replace(this.TOKEN, _arg1);
            return (this.createWrapper(_local2));
        }
        public function zodiacBackground(_arg1:MonsterModel):Asset{
            var _local2:ZodiacVO = this.zodiacs.getZodiacByID(_arg1.zodiac);
            var _local3 = (("assets/ui/battle/portrait_background/" + _local2.elementID) + ".swf");
            return (this.createWrapper(_local3));
        }
        public function weather(_arg1:String):Asset{
            var _local2:Asset;
            if (_arg1 == ApplicationModel.SNOWING){
                _local2 = this.createSingleton("assets/special/snow.swf");
            };
            return (_local2);
        }
        public function createSingleton(_arg1:String):Asset{
            _arg1 = this.config.parseURL(_arg1);
            return (this.singletons.require(_arg1));
        }
        public function getCollectionItemAsset(_arg1:MogaCollectionItem):Asset{
            var _local2:uint = (uint(_arg1.id) - 1000);
            var _local3 = (("images/monster_thumb/card_thumb/card_" + _local2) + ".png");
            return (this.createWrapper(_local3));
        }
        public function get miniCollectionAsset():Asset{
            return (this.createWrapper("assets/ui/miniCollection.swf"));
        }
        public function get collectionManagementAsset():Asset{
            return (this.createWrapper("assets/ui/collectionManager.swf"));
        }
        public function createWrapper(_arg1:String, _arg2:Boolean=true):Asset{
            var _local3:Asset;
            _arg1 = this.config.parseURL(_arg1);
            if (_arg1.indexOf(".swf") != -1){
                _local3 = new MovieClipAssetLoader(_arg1);
            } else {
                if (_arg1.indexOf(".png") != -1){
                    _local3 = new BitmapAssetLoader(_arg1);
                } else {
                    if (_arg1.indexOf(".jpg") != -1){
                        _local3 = new BitmapAssetLoader(_arg1);
                    } else {
                        if (_arg1.indexOf(".gif") != -1){
                            _local3 = new BitmapAssetLoader(_arg1);
                        } else {
                            throw (new Error("unsupported asset type"));
                        };
                    };
                };
            };
            if (_arg2){
                _local3.init();
            };
            return (_local3);
        }
        public function uiPath(_arg1:String):String{
            return (this.config.parseURL("assets/ui/@TOKEN@.swf".replace(this.TOKEN, _arg1)));
        }
        public function rewardCount():Asset{
            return (this.createWrapper("assets/items/multiplier.swf"));
        }
        public function nameMonster():Asset{
            return (this.createWrapper("assets/ui/nameMonster.swf"));
        }
        public function captureConfirm():Asset{
            return (this.createWrapper("assets/ui/captureConfirm.swf"));
        }
        public function currencyIcon():Asset{
            return (this.createWrapper("assets/items/currency.swf"));
        }
        public function xpIcon():Asset{
            return (this.createWrapper("assets/items/xp.swf"));
        }
        public function captureStreamIcon(_arg1:uint):Asset{
            var _local2:String = this.config.parseURL("images/feed_icons/icon_@TOKEN@.png".replace(this.TOKEN, _arg1));
            return (this.createWrapper(_local2));
        }
        public function captureStreamIconString(_arg1:uint):String{
            var _local2:String = this.config.parseURL("images/feed_icons/icon_@TOKEN@.png".replace(this.TOKEN, _arg1));
            return (_local2);
        }
        public function levelupIconString(_arg1:uint, _arg2:uint):String{
            var _local3:String = this.config.parseURL("images/levelup_icons/mon_@TOKEN@_level_@SUB@.png".replace(this.TOKEN, _arg1).replace(this.SUBTOKEN, _arg2));
            return (_local3);
        }
        public function aprilStreamUrl():String{
            var _local1:String = this.config.parseURL("images/april_stream.png");
            return (_local1);
        }
        public function questHelpIconString(_arg1:uint):String{
            var _local2:String = this.config.parseURL("images/quest_icons/quest_help_@TOKEN@.png".replace(this.TOKEN, _arg1));
            return (_local2);
        }
        public function questCompleteIconString(_arg1:uint):String{
            var _local2:String = this.config.parseURL("images/quest_icons/quest_complete_@TOKEN@.png".replace(this.TOKEN, _arg1));
            return (_local2);
        }
        public function get starseedRequestIconString():String{
            return (this.config.parseURL("images/one_off_feed_icons/seedBasketRequest.png"));
        }
        public function getStarseedBasketShareLink(_arg1:String):String{
            return ((((this.appModel.appUrl + "?id=") + _arg1) + "&basket=1"));
        }
        public function generateFriendList(_arg1:Vector.<Friend>):FriendList{
            if (this.friendListSingleton){
                return (this.friendListSingleton);
            };
            var _local2:Asset = this.createWrapper("assets/ui/friends.swf");
            this.friendListSingleton = new FriendList(_local2, _arg1);
            return (this.friendListSingleton);
        }
        public function partnerPixel(_arg1:String):Asset{
            var _local2:Asset;
            switch (_arg1){
                case PartnerPixelType.SOMETRICS:
                    _local2 = this.createWrapper("http://v.sometrics.com/19/mpixel.gif");
                    break;
                default:
                    break;
            };
            return (_local2);
        }
        public function npcPortrait(_arg1:uint):Asset{
            return (this.createWrapper("assets/npcs/portrait/@TOKEN@.swf".replace(this.TOKEN, _arg1)));
        }

    }
}//package gaia.moga.assets 
