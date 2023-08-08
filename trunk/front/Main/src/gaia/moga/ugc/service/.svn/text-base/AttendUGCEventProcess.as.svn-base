//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.ugc.service {
    import com.gaiaonline.monster.model.*;
    import gaia.moga.ugc.model.*;
    import com.gaiaonline.monster.service.process.*;
    import gaia.moga.monster.model.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.inventory.model.*;
    import gaia.moga.items.model.*;

    public class AttendUGCEventProcess extends GSIProcess {

        public var server:GSIDataService;
        public var model:ApplicationModel;
        public var ranch:HomeRanchModel;
        public var inventory:InventoryModel;
        public var mogas:MogaFactory;
        public var grants:UGCGrants;

        public function AttendUGCEventProcess(){
            super("AttendUGCEventProcess");
        }
        override protected function onInit():void{
            this.grants = new UGCGrants();
            this.server.attendEvent(this, this.model.ugcEventHost, this.model.ugcEventTime, this.model.ugcMonsterId);
        }
        override protected function parse(_arg1:Object):Boolean{
            var _local2:uint;
            var _local3:uint;
            var _local4:InventoryItem;
            var _local5:GrantVO;
            var _local6:GrantVO;
            if (((_arg1.attendee_reward) && (_arg1.attendee_reward.item))){
                _local2 = _arg1.attendee_reward.item.id;
                _local3 = _arg1.attendee_reward.item.quantity;
                _local4 = this.inventory.getItem(_local2);
                this.inventory.getItem(_local2).quantity = (_local4.quantity + _local3);
                _local5 = new GrantVO(_local4.type, this.model.ugcEventHost, _local3);
                this.grants.add(_local5);
            } else {
                if (((_arg1.attendee_reward) && (_arg1.attendee_reward.monster))){
                    _local6 = new GrantVO(new Item(2), "100001591722543", 1);
                    _local6.isMonster = true;
                    this.grants.add(_local6);
                };
            };
            return (true);
        }

    }
}//package gaia.moga.ugc.service 
