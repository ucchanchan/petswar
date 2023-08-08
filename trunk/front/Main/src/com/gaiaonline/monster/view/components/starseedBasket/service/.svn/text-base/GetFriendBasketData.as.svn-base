//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.starseedBasket.service {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.view.components.starseedBasket.model.*;
    import com.gaiaonline.monster.service.process.*;
    import com.gaiaonline.monster.service.*;

    public class GetFriendBasketData extends GSIProcess {

        public var gsi:GSIDataService;
        public var basketModel:StarseedBasketModel;
        public var friendRanch:FriendRanchModel;
        public var friendID:String;

        public function GetFriendBasketData(){
            super("GetFriendBasketData");
        }
        override protected function onInit():void{
            this.gsi.getFriendBasketData(this);
        }
        override protected function parse(_arg1:Object):Boolean{
            this.friendRanch.update(_arg1.friend_detail.ranch);
            this.friendRanch.friendID = String(_arg1.friend_detail.user.user_id);
            this.basketModel.initFriend(_arg1.friend_detail.seed_basket);
            return (true);
        }

    }
}//package com.gaiaonline.monster.view.components.starseedBasket.service 
