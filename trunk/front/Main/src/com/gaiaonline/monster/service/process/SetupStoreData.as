//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service.process {
    import com.gaiaonline.monster.model.vo.*;
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.service.*;

    public class SetupStoreData extends GSIProcess {

		[Inject]
        public var model:StoreModel;
		[Inject]
        public var server:GSIDataService;

        public function SetupStoreData(){
            super("SetupStoreData");
        }
        override protected function onInit():void{
            this.server.getStore(this);
        }
        override protected function parse(_arg1:Object):Boolean{
            var _local2:String;
            var _local3:Object;
            var _local4:String;
            var _local5:Object;
            var _local6:StoreItemVO;
            this.model.reset();
            for (_local2 in _arg1) {
                _local3 = _arg1[_local2];
                for (_local4 in _local3) {
                    if (_local4.indexOf("nonce") != -1){
                        break;
                    };
                    _local5 = _local3[_local4];
                    _local6 = new StoreItemVO(_local5);
                    _local6.name = _local5.props.name;
                    _local6.description = _local5.props.description;
                    if (_local6.purchasable){
                        this.model.addItem(_local6);
                    };
                };
            };
            return (true);
        }

    }
}//package com.gaiaonline.monster.service.process 
