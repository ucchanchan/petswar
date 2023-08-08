//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.quests.controller {
    import com.gaiaonline.monster.model.vo.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.story.view.ui.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.model.quests.*;
    import com.gaiaonline.monster.controller.*;
    import com.gaiaonline.monster.view.components.quests.*;
    import com.gaiaonline.monster.controller.async.*;

    public class PushQuestPanelsCommand extends AsyncCommand {

		[Inject]
        public var quests:QuestModel;
		[Inject]
        public var async:AsyncService;

        override public function execute():void{
            var _local2:QuestVO;
            var _local3:QuestVO;
            var _local1:Boolean;
            if (((this.quests.completeQuests) && ((this.quests.completeQuests.length > 0)))){
                for each (_local2 in this.quests.completeQuests) {
                    if (!_local1){
                        _local1 = true;
                        this.async.push(new AsyncDispatchEvent(eventDispatcher, new ApplicationEvent(ApplicationEvent.NOT_LOADING)));
                    };
                    if (_local2.completeStoryId){
                        this.async.push(new AsyncDispatchWaitForPanelClosedEvent(eventDispatcher, new ApplicationEvent(ApplicationEvent.INVOKE_CONGRAZZLES_STORY), CongrazzlesStory));
                    };
                    this.async.push(new AsyncDispatchWaitForPanelClosedEvent(eventDispatcher, new ApplicationEvent(ApplicationEvent.INVOKE_CONGRAZZLES_DIALOG), Congrazzles));
                };
            };
            if (((this.quests.newQuests) && ((this.quests.newQuests.length > 0)))){
                for each (_local3 in this.quests.newQuests) {
                    if (!_local1){
                        _local1 = true;
                        this.async.push(new AsyncDispatchEvent(eventDispatcher, new ApplicationEvent(ApplicationEvent.NOT_LOADING)));
                    };
                    if (_local3.acceptStoryId){
                        this.async.push(new AsyncDispatchWaitForPanelClosedEvent(eventDispatcher, new ApplicationEvent(ApplicationEvent.INVOKE_NEWQUEST_STORY), NewQuestStory));
                    };
                    this.async.push(new AsyncDispatchWaitForPanelClosedEvent(eventDispatcher, new ApplicationEvent(ApplicationEvent.INVOKE_NEWQUEST_DIALOG), NewQuests));
                };
            };
        }

    }
}//package gaia.moga.quests.controller 
