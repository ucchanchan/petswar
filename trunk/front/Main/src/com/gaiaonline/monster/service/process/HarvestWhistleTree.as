//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service.process {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.inventory.model.*;

    public class HarvestWhistleTree extends GSIProcess {

		[Inject]
        public var server:GSIDataService;
		[Inject]
        public var inventory:InventoryModel;
		[Inject]
        public var home:HomeRanchModel;
		[Inject]
        public var friend:FriendRanchModel;
        public var whistlesHarvested:int;

        public function HarvestWhistleTree(){
            super("HarvestWhistleTree");
        }
        override protected function onInit():void{
            var _local1:String = (this.friend) ? this.friend.friendID.toString() : "";
            this.server.harvestWhistles(this, _local1);
        }
        override protected function parse(_arg1:Object):Boolean{
            var _local2:Array = _arg1.success;
            if (_local2 == null){
                return (false);
            };
            var _local3:String = _local2[0];
            this.whistlesHarvested = _local3.match(/Harvested (.+?) whistles/)[1];
            return ((this.whistlesHarvested > 0));
        }

    }
}//package com.gaiaonline.monster.service.process 
