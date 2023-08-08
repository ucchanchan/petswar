//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.team {
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.*;
    import org.robotlegs.mvcs.*;

    public class SetTeamCommand extends Command {

		[Inject]
        public var event:TeamEvent;
		[Inject]
        public var ranch:HomeRanchModel;
		[Inject]
        public var server:GSIDataService;

        override public function execute():void{
            var _local1:Vector.<MonsterModel> = this.event.data;
            this.ranch.team.mogas = _local1;
            this.server.setTeam(_local1);
        }

    }
}//package com.gaiaonline.monster.controller.team 
