//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.battle.action {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.friendlist.model.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.view.dialog.vo.*;
    import com.gaiaonline.monster.model.battle.*;
    import org.robotlegs.mvcs.*;

    public class HelpRequestCommand extends Command {

		[Inject]
        public var model:BattleModel;
		[Inject]
        public var gateway:GSIDataService;
		[Inject]
        public var friends:FriendsModel;
		[Inject]
        public var text:TextService;

        private static const NO_FRIENDS_MESSAGE:String = "NO_FRIENDS_MESSAGE";

        override public function execute():void{
            var _local3:String;
            var _local4:DialogVO;
            var _local1:String = this.model.id;
            var _local2:MonsterModel = this.model.playerMonster;
            if (this.friends.friends.length){
                this.model.state = BattleState.REQUEST_HELP_PENDING;
                this.gateway.useWhistle(_local1, _local2.id);
            } else {
                _local3 = this.text.getText(NO_FRIENDS_MESSAGE);
                _local4 = new DialogVO(_local3, DialogVO.OK_ONLY);
                dispatch(new DialogEvent(DialogEvent.SHOW_DIALOG, _local4));
            };
        }

    }
}//package com.gaiaonline.monster.controller.battle.action 
