//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import flash.events.*;
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.friendlist.model.*;
    import com.gaiaonline.monster.view.components.home.*;
    import com.gaiaonline.monster.service.*;
    import org.robotlegs.mvcs.*;

    public class WhistleReminderMediator extends Mediator {

        private const WHISTLE_REMINDER_TITLE:String = "WHISTLE_REMINDER_TITLE";
        private const WHISTLE_REMINDER_MSG:String = "WHISTLE_REMINDER_MSG";
        private const WHISTLE_REMINDER_BUTTON:String = "WHISTLE_REMINDER_BUTTON";

        public var view:WhistleReminder;
        public var text:TextService;
        public var ranch:FriendRanchModel;
        public var friends:FriendsModel;
        private var friendName:String;
        private var friendId:String;

        override public function onRegister():void{
            this.view.confirm.add(this.onConfirm);
            this.view.cancel.add(this.onCancel);
            this.view.ready.add(this.onReady);
            eventDispatcher.addEventListener(ApplicationEvent.SET_STATE, this.onSetState);
        }
        override public function onRemove():void{
            this.view.dispose();
            this.view.confirm.remove(this.onConfirm);
            this.view.cancel.remove(this.onCancel);
            this.view.ready.remove(this.onReady);
        }
        private function onSetState(_arg1:Event):void{
            dispatch(new PanelsEvent(PanelsEvent.REMOVE_OVERLAY, this.view));
        }
        private function onConfirm():void{
            dispatch(new HomeEvent(HomeEvent.WHISTLE_TREE_REMINDER, {friendName:this.friendName, friendId:this.friendId}));
            dispatch(new PanelsEvent(PanelsEvent.REMOVE_OVERLAY, this.view));
        }
        private function onCancel():void{
            dispatch(new PanelsEvent(PanelsEvent.REMOVE_OVERLAY, this.view));
        }
        private function onReady():void{
            this.friendId = this.ranch.friendID;
            this.friendName = this.friends.getFriendByID(this.ranch.friendID).firstName;
            var _local1:String = this.text.getText(this.WHISTLE_REMINDER_TITLE).replace("FRIEND", this.friendName);
            var _local2:String = this.text.getText(this.WHISTLE_REMINDER_MSG).replace("FRIEND", this.friendName);
            this.view.setText(_local1, _local2);
        }

    }
}//package com.gaiaonline.monster.view 
