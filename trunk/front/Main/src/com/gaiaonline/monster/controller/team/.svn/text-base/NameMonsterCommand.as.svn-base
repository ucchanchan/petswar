//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.team {
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.process.*;
    import org.robotlegs.mvcs.*;

    public class NameMonsterCommand extends Command {

		[Inject]
        public var event:TeamEvent;
		[Inject]
        public var process:NameMonsterProcess;

        override public function execute():void{
            this.process.id = this.event.data.id;
            this.process.monsterName = this.event.data.monsterName;
            this.process.init();
        }

    }
}//package com.gaiaonline.monster.controller.team 
