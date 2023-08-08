//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.application {
    import com.gaiaonline.monster.model.vo.*;
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.model.quests.*;
    import com.gaiaonline.monster.controller.*;

    public class InvokeCongrazzlesStoryCommand extends AsyncCommand {

		[Inject]
        public var quests:QuestModel;
		[Inject]
        public var story:StoryModel;

        private static const CONGRAZZLES_ASSET:String = "assets/ui/congrazzles.swf";

        override public function execute():void{
            if (((!(this.quests.completeQuests)) || ((this.quests.completeQuests.length == 0)))){
                return;
            };
            var _local1:QuestVO = this.quests.completeQuests[0];
            this.story.init(_local1.completeStoryId);
            dispatch(new ApplicationEvent(ApplicationEvent.SET_STATE, ApplicationState.CONGRAZZLES_STORY_LOCATION));
        }

    }
}//package com.gaiaonline.monster.controller.application 
