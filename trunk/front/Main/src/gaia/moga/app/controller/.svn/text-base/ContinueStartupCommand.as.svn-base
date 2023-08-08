//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.app.controller {
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.model.world.*;
    import com.gaiaonline.monster.service.sound.*;
    import gaia.moga.data.*;
    import com.gaiaonline.monster.service.process.*;
    import gaia.moga.assets.*;
    import gaia.moga.assets.bundle.*;
    import gaia.moga.inventory.model.*;
    import gaia.moga.items.model.*;
    import gaia.lib.*;
    import gaia.moga.app.view.ui.*;
    import com.gaiaonline.monster.controller.*;
    import gaia.moga.items.service.*;
    import gaia.moga.friendlist.service.*;

    public class ContinueStartupCommand extends AsyncCommand {

		[Inject]
        public var model:ApplicationModel;
		[Inject]
        public var assets:AssetService;
		[Inject]
        public var cookie:Cookie;
		[Inject]
        public var bundle:AppAssetsBundle;
		[Inject]
        public var data:DataBundle;
		[Inject]
        public var updateFriends:UpdateFriends;
		[Inject]
        public var userData:UpdateUserData;
		[Inject]
        public var worldData:SetupWorldData;
		[Inject]
        public var music:MusicService;
		[Inject]
        public var world:WorldModel;
		[Inject]
        public var inventoryModel:InventoryModel;
		[Inject]
        public var setupItems:SetupItems;
		[Inject]
        public var questData:QuestDataProcess;

        override public function execute():void{
            var _local3:Number;
            var _local4:Splash;
            var _local1:ParallelAsyncs = new ParallelAsyncs("ContinueStartupCommandParallel");
            _local1.add(this.bundle);
            _local1.add(this.updateFriends);
            _local1.add(this.setupItems);
            var _local2:AsyncStack = new AsyncStack("ContinueStartupCommand-questsAndWorldData");
            _local2.push(this.userData);
            _local2.push(this.worldData);
            _local1.add(_local2);
            if (!this.model.hideSplash){
                _local3 = this.cookie.getValue("alwaysSkipIntro", false);
				_local3 = 1;
                _local4 = (_local3) ? this.skipIntroSplash() : this.introSplash();
                dispatch(new PanelsEvent(PanelsEvent.SET_PANEL, _local4));
                _local1.add(_local4);
            };
            hook(_local1, this.onComplete, this.onError);
        }
        private function skipIntroSplash():Splash{
            var _local1:Asset = this.assets.createWrapper("assets/ui/splash_noIntro.swf");
            var _local2:String = this.model.version;
            return (new Splash(_local1, _local2, null));
        }
        private function introSplash():Splash{
            var _local1:Asset = this.assets.createWrapper("assets/ui/splash.swf");
            var _local2:String = this.model.version;
            var _local3:MusicProxy = this.music.load("sounds/splash.mp3", false);
            return (new Splash(_local1, _local2, _local3));
        }
        private function onComplete(_arg1:Async):void{
            dispatch(new ApplicationEvent(ApplicationEvent.LOAD_FONTS));
            if (this.userData.isNewUser){
                dispatch(new ApplicationEvent(ApplicationEvent.SET_STATE, ApplicationState.NEW_USER_ZODIAC));
            } else {
                if (((this.model.openBattleID) && (!((this.world.currentLocation.id == 0))))){
                    dispatch(new ApplicationEvent(ApplicationEvent.RETRIEVE_BATTLE));
                } else {
                    if (((!((this.model.defaultFriendID == ""))) && (this.world.currentLocation.isHome))){
                        dispatch(new ApplicationEvent(ApplicationEvent.SET_STATE, ApplicationState.FRIEND_RANCH));
                    } else {
                        if (this.world.currentLocation.isHome){
                            dispatch(new ApplicationEvent(ApplicationEvent.SET_STATE, ApplicationState.HOME));
                        } else {
                            dispatch(new ApplicationEvent(ApplicationEvent.SET_STATE, ApplicationState.WORLD));
                        };
                    };
                };
            };
            if (this.model.grantCode){
                dispatch(new ApplicationEvent(ApplicationEvent.RETRIEVE_ITEM_GRANT));
            } else {
                if (this.model.ugcEventHost){
                    dispatch(new UGCEvent(UGCEvent.ATTEND_EVENT, {hostId:this.model.ugcEventHost, timestamp:this.model.ugcEventTime}));
                } else {
                    if (((this.hasItemToOpen()) && (!(this.model.grantCode)))){
                        dispatch(new ApplicationEvent(ApplicationEvent.OPEN_EXISTING_RIG));
                    };
                };
            };
        }
        private function hasItemToOpen():Boolean{
            return (this.inventoryModel.hasItem(ItemEnum.DAILY_PRIZE));
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
        }

    }
}//package gaia.moga.app.controller 
