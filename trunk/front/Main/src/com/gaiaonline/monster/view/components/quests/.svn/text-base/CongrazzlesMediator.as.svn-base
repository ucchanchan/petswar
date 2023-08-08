//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.quests {
    import com.gaiaonline.monster.model.vo.*;
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.sound.*;
    import com.gaiaonline.monster.service.*;
    import org.robotlegs.mvcs.*;

    public class CongrazzlesMediator extends Mediator {

		[Inject]
        public var view:Congrazzles;
		[Inject]
        public var async:AsyncService;
		[Inject]
        public var sounds:SoundService;
		[Inject]
        public var textService:TextService;
		[Inject]
        public var gsiService:GSIDataService;
		[Inject]
        public var appModel:ApplicationModel;
		[Inject]
        public var fbService:FBService;
		[Inject]
        public var timer:TimerService;

        private static const QUEST_COMPLETE_EVENT_ID:int = 10;

        override public function onRegister():void{
            this.view.closed.addOnce(this.onClosed);
            this.view.shareClick.addOnce(this.onShareClick);
            var _local1:SoundProxy = this.sounds.getFX("sounds/quest_complete.mp3");
            _local1.play();
        }
        override public function onRemove():void{
            this.view.closed.remove(this.onClosed);
            this.view.shareClick.remove(this.onShareClick);
            this.view.dispose();
        }
        private function onShareClick(_arg1:QuestVO):void{
            var _local2:String = String(this.timer.currentTime);
            this.gsiService.createEvent(QUEST_COMPLETE_EVENT_ID, _local2, []);
            var _local3:String = this.textService.getQuestText(String(_arg1.id), "name");
            var _local4:String = this.textService.getQuestCompleteMainMessage(this.appModel.firstName, _local3);
            var _local5:String = this.textService.getQuestCompleteSecondMessage(this.appModel.firstName, _local3);
            this.fbService.publishQuestCompleteShare(_arg1.id, _local4, _local5, _local2);
        }
        private function onClosed():void{
            dispatch(new PanelsEvent(PanelsEvent.REMOVE_OVERLAY, this.view));
        }

    }
}//package com.gaiaonline.monster.view.components.quests 
