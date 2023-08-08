//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.starseedBasket.view.ui.receiver {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;
    import com.gaiaonline.monster.view.components.starseedBasket.view.ui.*;

    public class MoreFriendsView extends InnerPanel {

        private var _inviteFriendsClick:Signal;

        public function MoreFriendsView(_arg1:MovieClip){
            super(_arg1);
            this._inviteFriendsClick = new Signal();
            _asset.inviteFriendsButton.addEventListener(MouseEvent.CLICK, this.onInviteClick, false, 0, true);
        }
        public function get inviteFriendsClick():ISignal{
            return (this._inviteFriendsClick);
        }
        override public function dispose(_arg1:Boolean=true):void{
            _asset.inviteFriendsButton.removeEventListener(MouseEvent.CLICK, this.onInviteClick, false);
            this._inviteFriendsClick.removeAll();
        }
        private function onInviteClick(_arg1:MouseEvent):void{
            this._inviteFriendsClick.dispatch();
        }

    }
}//package com.gaiaonline.monster.view.components.starseedBasket.view.ui.receiver 
