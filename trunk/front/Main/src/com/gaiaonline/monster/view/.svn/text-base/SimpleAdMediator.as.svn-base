//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.view.components.ads.*;

    public class SimpleAdMediator extends Mediator {

		[Inject]
        public var view:SimpleAd;
		[Inject]
        public var fb:FBService;
		[Inject]
        public var text:TextService;

        override public function onRegister():void{
            this.view.complete.add(this.onComplete);
        }
        override public function onRemove():void{
            this.view.dispose();
        }
        private function onComplete(_arg1:String, _arg2:String):void{
            var _local3:Object = {};
            _local3.inviteType = this.text.getText("APPLICATION_NAME");
            _local3.popupTitle = "Your friends will help you in battle!";
            _local3.friendSelectorActionText = "Select the people you want to add as your friend";
            _local3.trackingType = "friend_tile";
            _local3.friendSelectorExcludeIds = null;
            if (_arg1 == "share"){
                this.fb.showSharePopup();
            } else {
                if (_arg1 == "invite"){
                    this.fb.showInvitePopup(_local3);
                };
            };
            dispatch(new TrackingEvent(TrackingEvent.TRACK, ((("ad_click_" + _arg1) + "_") + _arg2)));
            dispatch(new PanelsEvent(PanelsEvent.REMOVE_OVERLAY, this.view));
        }

    }
}//package com.gaiaonline.monster.view 
