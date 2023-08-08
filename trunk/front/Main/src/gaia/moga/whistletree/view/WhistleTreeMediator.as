//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.whistletree.view {
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.sound.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.view.components.home.*;
    import gaia.moga.whistletree.model.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.inventory.model.*;
    import gaia.moga.whistletree.event.*;
    import gaia.moga.whistletree.view.ui.*;
    import org.robotlegs.mvcs.*;

    public class WhistleTreeMediator extends Mediator {

		[Inject]
        public var view:WhistleTree;
		[Inject]
        public var app:ApplicationModel;
		[Inject]
        public var homeRanch:HomeRanchModel;
		[Inject]
        public var friendRanch:FriendRanchModel;
		[Inject]
        public var inventory:InventoryModel;
		[Inject]
        public var timer:TimerService;
		[Inject]
        public var text:TextService;
		[Inject]
        public var sounds:SoundService;
		[Inject]
        public var assets:AssetService;
        private var atFriends:Boolean;
        private var isNova:Boolean;
        private var ranch:MonsterRanchModel;
        private var isActive:Boolean;
        private var hasShownAd:Boolean;

        private static const MINUTES:uint = 60;
        private static const HOURS:uint = 3600;
        private static const INV_MINUTES:Number = 0.0166666666666667;
        private static const INV_HOURS:Number = 0.000277777777777778;
        private static const FRIEND_TREE_LADEN:String = "FRIEND_TREE_LADEN";
        private static const MY_TREE_LADEN:String = "MY_TREE_LADEN";
        private static const MY_TREE_HEALTHY:String = "MY_TREE_HEALTHY";
        private static const MY_TREE_WITHERED:String = "MY_TREE_WITHERED";
        private static const FRIEND_TREE_HEALTHY:String = "FRIEND_TREE_HEALTHY";
        private static const FRIEND_TREE_WITHERED:String = "FRIEND_TREE_WITHERED";
        private static const NEVER:String = "NEVER";

        override public function onRegister():void{
            eventDispatcher.addEventListener(WhistleTreeEvent.UPDATE, this.onUpdate);
            eventDispatcher.addEventListener(WhistleTreeEvent.ENABLE, this.onEnable);
            eventDispatcher.addEventListener(WhistleTreeEvent.DISABLE, this.onDisable);
            this.atFriends = (this.app.state == ApplicationState.FRIEND_RANCH);
            this.ranch = (this.atFriends) ? this.friendRanch : this.homeRanch;
            this.isNova = ((this.atFriends) && ((((this.friendRanch.friendID == "100001591722543")) || ((this.friendRanch.friendID == "123")))));
            if (this.atFriends){
                this.view.clicked.add(this.onFriendTreeClicked);
            } else {
                this.view.clicked.add(this.onOwnTreeClicked);
            };
            this.view.over.add(this.onWhistleTreeOver);
            this.view.out.add(this.onWhistleTreeOut);
            this.isActive = true;
            this.updateState();
        }
        override public function onRemove():void{
            eventDispatcher.removeEventListener(WhistleTreeEvent.UPDATE, this.onUpdate);
            eventDispatcher.removeEventListener(WhistleTreeEvent.ENABLE, this.onEnable);
            eventDispatcher.removeEventListener(WhistleTreeEvent.DISABLE, this.onDisable);
            this.isActive = false;
            this.view.clicked.removeAll();
            this.view.over.removeAll();
            this.view.out.removeAll();
            this.view.dispose();
        }
        private function onUpdate(_arg1:WhistleTreeEvent):void{
            this.updateState();
        }
        private function onEnable(_arg1:WhistleTreeEvent):void{
            this.view.enabled = true;
        }
        private function onDisable(_arg1:WhistleTreeEvent):void{
            this.view.enabled = false;
        }
        private function updateState():void{
            var _local1:uint = this.timer.currentTime;
            var _local2:int = (this.ranch.witherOn - _local1);
            var _local3:Boolean = ((this.isNova) || ((_local2 > 0)));
            var _local4:Boolean = ((_local3) && ((this.ranch.numWhistles > 0)));
            if (_local4){
                this.view.state = WhistleTreeState.LADEN;
                this.view.hideCTA();
            } else {
                if (_local3){
                    this.view.state = WhistleTreeState.HEALTHY;
                    this.view.hideCTA();
                } else {
                    this.view.state = WhistleTreeState.WITHERED;
                    if (this.atFriends){
                        this.view.hideCTA();
                        if (!this.hasShownAd){
                            this.showWhistleTreeReminder();
                        };
                    } else {
                        this.view.showCTA();
                    };
                };
            };
            if (((this.isActive) && (!(this.atFriends)))){
                this.timer.callIn(60, this.updateState);
            };
        }
        private function showWhistleTreeReminder():void{
            this.hasShownAd = true;
            var _local1:Asset = this.assets.whistleTreeReminder;
            var _local2:WhistleReminder = new WhistleReminder(_local1);
            dispatch(new PanelsEvent(PanelsEvent.ADD_OVERLAY, _local2));
        }
        private function onFriendTreeClicked(_arg1:WhistleTree):void{
            if (this.view.state != WhistleTreeState.LADEN){
                return;
            };
            this.harvest();
            this.view.state = WhistleTreeState.HEALTHY;
        }
        private function onOwnTreeClicked(_arg1:WhistleTree):void{
            if (this.view.state == WhistleTreeState.LADEN){
                this.harvest();
            } else {
                this.water();
            };
        }
        private function onWhistleTreeOver():void{
            var _local2:String;
            this.updateState();
            var _local1:WhistleTreeState = this.view.state;
            switch (_local1){
                case WhistleTreeState.LADEN:
                    _local2 = this.text.getText((this.atFriends) ? FRIEND_TREE_LADEN : MY_TREE_LADEN);
                    break;
                case WhistleTreeState.HEALTHY:
                    _local2 = this.text.getText((this.atFriends) ? FRIEND_TREE_HEALTHY : MY_TREE_HEALTHY);
                    break;
                case WhistleTreeState.WITHERED:
                    _local2 = this.text.getText((this.atFriends) ? FRIEND_TREE_WITHERED : MY_TREE_WITHERED);
                    break;
            };
            var _local3:String = this.lastWateredDescription();
            var _local4:String = this.moreWhistlesIn();
            this.view.showDialog(_local2, _local3, _local4);
        }
        private function onWhistleTreeOut():void{
            this.view.hideDialog();
        }
        private function lastWateredDescription():String{
            var _local1:uint = this.ranch.lastWatered;
            var _local2:int = (this.timer.currentTime - _local1);
            if (this.isNova){
                _local2 = 0;
            } else {
                if (_local1 == 0){
                    return (this.text.getText(NEVER));
                };
            };
            var _local3:int = (_local2 * INV_HOURS);
            if (_local3 > 48){
                return (this.text.describeTime((_local3 / 24), -1, -1, -1, false));
            };
            var _local4:int = ((_local2 - (HOURS * _local3)) * INV_MINUTES);
            return (this.text.describeTime(-1, _local3, _local4, -1, true));
        }
        private function moreWhistlesIn():String{
            if (this.view.state == WhistleTreeState.LADEN){
                return (this.text.describeNow());
            };
            var _local1:uint = this.timer.currentTime;
            var _local2:int = (this.ranch.witherOn - _local1);
            if (_local2 < 0){
                return (this.text.getText("NEEDS_TO_WATER"));
            };
            var _local3:int = (this.ranch.nextHarvestable - _local1);
            var _local4:int = (_local3 * INV_HOURS);
            var _local5:int = ((_local3 - (HOURS * _local4)) * INV_MINUTES);
            return (this.text.describeTime(-1, _local4, _local5, -1, true));
        }
        private function water():void{
            this.view.hideDialog();
            this.view.water();
            dispatch(new WhistleTreeEvent(WhistleTreeEvent.WATER));
            var _local1:SoundProxy = this.sounds.getFX("sounds/whistle_watering.mp3");
            _local1.play();
        }
        private function harvest():void{
            this.view.hideDialog();
            dispatch(new WhistleTreeEvent(WhistleTreeEvent.HARVEST, (this.atFriends) ? this.friendRanch : null));
            dispatch(new WhistleTreeEvent(WhistleTreeEvent.WATER));
            var _local1:SoundProxy = this.sounds.getFX("sounds/whistle_harvesting.mp3");
            _local1.play();
        }

    }
}//package gaia.moga.whistletree.view 
