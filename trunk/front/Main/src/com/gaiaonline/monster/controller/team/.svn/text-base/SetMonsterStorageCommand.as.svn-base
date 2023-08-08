//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.team {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.process.*;
    import org.robotlegs.mvcs.*;

    public class SetMonsterStorageCommand extends Command {

		[Inject]
        public var event:MogaStorageEvent;
		[Inject]
        public var process:SetMonsterStorageProcess;

        override public function execute():void{
            var _local1:MonsterModel = MonsterModel(this.event.data);
            this.process.id = _local1.id;
            this.process.isStored = _local1.inStorage;
            this.process.init();
        }

    }
}//package com.gaiaonline.monster.controller.team 
