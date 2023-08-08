//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.team {
    import com.gaiaonline.monster.events.*;
    import org.robotlegs.mvcs.*;

    public class StoreTeamMonsterCommand extends Command {

        public var event:DialogEvent;

        override public function execute():void{
            dispatch(new MogaStorageEvent(MogaStorageEvent.STORE_TEAM_MONSTER, this.event.data));
        }

    }
}//package com.gaiaonline.monster.controller.team 
