//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model {
    import gaia.moga.friendlist.model.*;

    public class HomeRanchModel extends MonsterRanchModel {

		[Inject]
        public var friends:FriendsModel;

        override public function update(_arg1:Object):void{
            super.update(_arg1);
            if (this.friends.me){
                this.friends.me.count = count;
            } else {
                this.friends.meCreated.addOnce(this.onMeCreated);
            };
        }
        private function onMeCreated(_arg1:Friend):void{
            _arg1.count = count;
        }

    }
}//package com.gaiaonline.monster.model 
