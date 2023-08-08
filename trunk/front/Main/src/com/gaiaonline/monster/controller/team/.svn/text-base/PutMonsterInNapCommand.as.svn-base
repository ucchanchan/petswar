//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.team {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.*;
    import org.robotlegs.mvcs.*;

    public class PutMonsterInNapCommand extends Command {

		[Inject]
        public var event:TeamEvent;
		[Inject]
        public var service:GSIDataService;
		[Inject]
        public var ranch:HomeRanchModel;
		[Inject]
        public var timer:TimerService;

        override public function execute():void{
            var _local1:MonsterModel = this.event.data;
            this.service.setMonsterInNap(_local1);
            _local1.nap(this.timer.currentTime);
            dispatch(new NapEvent(NapEvent.START_NAP, _local1));
        }

    }
}//package com.gaiaonline.monster.controller.team 
