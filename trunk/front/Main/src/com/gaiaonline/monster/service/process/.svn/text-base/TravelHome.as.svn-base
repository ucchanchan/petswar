//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service.process {
    import com.gaiaonline.monster.model.world.*;
    import com.gaiaonline.monster.service.*;

    public class TravelHome extends GSIProcess {

		[Inject]
        public var world:WorldModel;
		[Inject]
        public var server:GSIDataService;

        public function TravelHome(){
            super("TravelHome");
        }
        override protected function onInit():void{
            if (this.world.currentLocation.isHomeOrTaxiStop){
                asyncComplete();
            } else {
                this.server.travelToLocation(this, 0);
            };
        }
        override protected function parse(_arg1:Object):Boolean{
            this.world.currentLocation = this.world.home;
            return (true);
        }

    }
}//package com.gaiaonline.monster.service.process 
