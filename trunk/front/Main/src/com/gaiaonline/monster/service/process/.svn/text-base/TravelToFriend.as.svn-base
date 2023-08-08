//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service.process {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.view.components.starseedBasket.model.*;
    import com.gaiaonline.monster.service.*;

    public class TravelToFriend extends GSIProcess {

		[Inject]
        public var server:GSIDataService;
		[Inject]
        public var model:ApplicationModel;
		[Inject]
        public var friendRanch:FriendRanchModel;
		[Inject]
        public var basketModel:StarseedBasketModel;

        public function TravelToFriend(){
            super("TravelToFriend");
        }
        override protected function onInit():void{
            this.server.visitFriend(this, this.model.friendRanchID);
        }
        override protected function parse(_arg1:Object):Boolean{
            this.friendRanch.update(_arg1.success.friend_detail.ranch);
            this.friendRanch.friendID = String(_arg1.success.friend_detail.user.user_id);
            this.basketModel.initFriend(_arg1.success.friend_detail.seed_basket);
            return (true);
        }

    }
}//package com.gaiaonline.monster.service.process 
