//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import com.gaiaonline.monster.model.vo.*;
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.view.components.app.panel.*;
    import com.gaiaonline.monster.service.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.view.components.quests.*;

    public class QuestsMediator extends Mediator {

		[Inject]
        public var view:IQuestView;
		[Inject]
        public var gsiService:GSIDataService;
		[Inject]
        public var timer:TimerService;
		[Inject]
        public var appModel:ApplicationModel;
		[Inject]
        public var fbService:FBService;
		[Inject]
        public var textService:TextService;

        private static const QUEST_HELP_EVENT_ID:int = 10;

        override public function onRegister():void{
            this.view.closed.addOnce(this.onClosed);
            this.view.helpRequested.add(this.onQuestHelpRequested);
        }
        override public function onRemove():void{
            this.view.closed.remove(this.onClosed);
            this.view.helpRequested.remove(this.onQuestHelpRequested);
        }
        private function onClosed():void{
            dispatch(new PanelsEvent(PanelsEvent.REMOVE_OVERLAY, (this.view as Panel)));
        }
        private function onQuestHelpRequested(_arg1:QuestVO):void{
            var _local2:String = String(this.timer.currentTime);
            this.gsiService.createEvent(QUEST_HELP_EVENT_ID, _local2, []);
            var _local3:String = this.textService.getQuestText(String(_arg1.id), "name");
            var _local4:String = this.textService.getQuestHelpMainMessage(this.appModel.firstName, _local3);
            var _local5:String = this.textService.getQuestHelpSecondaryMessage(this.appModel.firstName, _local3);
            this.fbService.publishQuestHelpRequest(_arg1.id, _local4, _local5, _local2);
        }

    }
}//package com.gaiaonline.monster.view 
