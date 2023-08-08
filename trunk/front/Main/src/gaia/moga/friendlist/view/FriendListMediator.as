//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.friendlist.view {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.travel.events.*;
    import gaia.moga.friendlist.view.ui.*;
    import gaia.moga.friendlist.model.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.service.*;
    import org.robotlegs.mvcs.*;

    public class FriendListMediator extends Mediator {

		[Inject]
        public var friendsModel:FriendsModel;
		[Inject]
        public var model:ApplicationModel;
		[Inject]
        public var view:FriendList;
		[Inject]
        public var assets:AssetService;
		[Inject]
        public var gateway:GSIDataService;
		[Inject]
        public var fb:FBService;
		[Inject]
        public var text:TextService;

        override public function onRegister():void{
            eventDispatcher.addEventListener(TravelHomeEvent.TRAVEL_HOME, this.clearFriendSelection);
            this.view.selected.add(this.onSelected);
            this.view.invite.add(this.inviteFriends);
            this.view.home.add(this.goHome);
            this.view.isSelected = this.model.friendRanchID;
        }
        override public function onRemove():void{
            eventDispatcher.removeEventListener(TravelHomeEvent.TRAVEL_HOME, this.clearFriendSelection);
            this.view.selected.add(this.onSelected);
            this.view.selected.removeAll();
            this.view.invite.removeAll();
            this.view.home.removeAll();
            this.view.dispose();
        }
        private function clearFriendSelection(_arg1:TravelHomeEvent):void{
            this.model.friendRanchID = this.model.userID;
            this.view.isSelected = "";
        }
        private function onSelected(_arg1:Friend):void{
            var _local2:String = _arg1.id;
            if (_local2 == this.model.userID){
                this.goHome();
            } else {
                if (_local2 != ""){
                    this.visitFriend(_local2);
                } else {
                    this.inviteFriends();
                };
            };
        }
        private function goHome():void{
            var _local1:String = this.model.userID;
            this.model.friendRanchID = _local1;
            this.view.isSelected = _local1;
            dispatch(new ApplicationEvent(ApplicationEvent.SET_STATE, ApplicationState.HOME));
        }
        private function visitFriend(_arg1:String):void{
            this.model.friendRanchID = _arg1;
            this.view.isSelected = _arg1;
            dispatch(new ApplicationEvent(ApplicationEvent.SET_STATE, ApplicationState.FRIEND_RANCH));
        }
        private function inviteFriends():void{
            this.view.isSelected = null;
            var _local1:Object = {};
            _local1.inviteType = this.text.getText("APPLICATION_NAME");
            _local1.popupTitle = "Your friends will help you in battle!";
            _local1.friendSelectorActionText = "Select the people you want to add as your friend";
            _local1.trackingType = "friend_tile";
            _local1.friendSelectorExcludeIds = null;
            this.fb.showInvitePopup(_local1);
        }

    }
}//package gaia.moga.friendlist.view 
