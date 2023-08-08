//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.team {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.sound.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.inventory.model.*;
    import org.robotlegs.mvcs.*;

    public class AwakenMonsterConfirmedCommand extends Command {

		[Inject]
        public var event:DialogEvent;
		[Inject]
        public var service:GSIDataService;
		[Inject]
        public var inventory:InventoryModel;
		[Inject]
        public var sounds:SoundService;

        override public function execute():void{
            var _local1:MonsterModel = this.event.data.target;
            this.service.awakenMonster(_local1);
            _local1.awaken();
            dispatch(new NapEvent(NapEvent.AWAKEN_MONSTER, _local1));
            var _local2:SoundProxy = this.sounds.getFX("sounds/awaken.mp3");
            _local2.play();
        }

    }
}//package com.gaiaonline.monster.controller.team 
