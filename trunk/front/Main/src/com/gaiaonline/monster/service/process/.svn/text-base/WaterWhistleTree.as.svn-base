//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service.process {
    import com.gaiaonline.monster.service.*;

    public class WaterWhistleTree extends GSIProcess {

		[Inject]
        public var server:GSIDataService;
        public var whistleTreeCount:int;
        public var witherOn:int;

        public function WaterWhistleTree(){
            super("WaterWhistleTree");
        }
        override protected function onInit():void{
            this.server.waterTree(this);
        }
        override protected function parse(_arg1:Object):Boolean{
            var _local2:Object = _arg1.success;
            if (_local2 == null){
                return (false);
            };
            this.whistleTreeCount = _local2.whistle_tree_count;
            this.witherOn = _local2.whistle_tree_withers_on;
            return (true);
        }

    }
}//package com.gaiaonline.monster.service.process 
