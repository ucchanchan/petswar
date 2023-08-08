//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service.process {
    import com.gaiaonline.monster.model.vo.*;
    import com.gaiaonline.monster.model.*;
    import gaia.moga.monster.model.*;
    import com.gaiaonline.monster.service.*;

    public class RetrieveItemGrantProcess extends GSIProcess {

        public var server:GSIDataService;
        public var model:ApplicationModel;
        public var grantModel:ItemGrantModel;
        public var ranch:HomeRanchModel;
        public var mogas:MogaFactory;

        public function RetrieveItemGrantProcess(){
            super("RetrieveItemGrantProcess");
        }
        override protected function onInit():void{
            this.server.retrieveItem(this, this.model.grantCode);
        }
        override protected function parse(_arg1:Object):Boolean{
            var _local3:MonsterModel;
            this.model.grantCode = null;
            var _local2 = !((_arg1.success == null));
            if (_local2){
                this.grantModel.id = _arg1.success[0].grant_id;
                if (_arg1.success[0].grant_result.props){
                    this.grantModel.type = ItemGrantType.MONSTER;
                    this.grantModel.name = _arg1.success[0].grant_result.props.name;
                    _local3 = this.mogas.create(_arg1.success[0].grant_result);
                    this.ranch.addMonster(_local3);
                } else {
                    if (_arg1.success[0].grant_result.type == "6"){
                        this.grantModel.type = ItemGrantType.RIG_ITEM;
                        this.grantModel.name = _arg1.success[0].grant_result.name;
                        this.grantModel.quantity = int(_arg1.success[0].grant_bundle.quantity);
                    } else {
                        this.grantModel.type = ItemGrantType.BASIC_ITEM;
                        this.grantModel.name = _arg1.success[0].grant_result.name;
                        this.grantModel.quantity = int(_arg1.success[0].grant_bundle.quantity);
                    };
                };
                this.model.hideSplash = true;
            };
            return (true);
        }

    }
}//package com.gaiaonline.monster.service.process 
