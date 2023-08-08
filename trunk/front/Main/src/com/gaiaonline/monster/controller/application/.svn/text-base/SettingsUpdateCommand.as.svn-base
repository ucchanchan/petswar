//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.application {
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.*;
    import org.robotlegs.mvcs.*;

    public class SettingsUpdateCommand extends Command {

		[Inject]
        public var event:SettingsEvent;
		[Inject]
        public var server:GSIDataService;
        private var DAILY_PRIZE:Number;// = 0x0100

        override public function execute():void{
            if (this.event.setting == "dailyPrize"){
                this.server.saveSetting(this.DAILY_PRIZE);
            };
        }

    }
}//package com.gaiaonline.monster.controller.application 
