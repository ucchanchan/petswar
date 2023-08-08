//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.autoHarvester.service {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.service.process.*;
    import com.gaiaonline.monster.service.*;

    public class AutoHarvesterProcess extends GSIProcess {

        public var server:GSIDataService;
        public var playerModel:PlayerModel;

        public function AutoHarvesterProcess(){
            super("AutoHarvesterProcess");
        }
        override protected function onInit():void{
            this.server.autoHarvest(this);
        }
        override protected function parse(_arg1:Object):Boolean{
            if (_arg1.success){
                this.playerModel.premiumCurrency = (this.playerModel.premiumCurrency - 10);
                return (true);
            };
            return (false);
        }

    }
}//package gaia.moga.autoHarvester.service 
