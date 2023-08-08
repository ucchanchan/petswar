//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.application {
    import com.gaiaonline.monster.model.vo.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.model.world.*;
    import com.gaiaonline.monster.model.quests.*;
    import com.gaiaonline.monster.controller.*;

    public class InvokeNewQuestStoryCommand extends AsyncCommand {

		[Inject]
        public var quests:QuestModel;
		[Inject]
        public var story:StoryModel;
		[Inject]
        public var world:WorldModel;
        private var asset:Asset;

        override public function execute():void{
            if (((!(this.quests.newQuests)) || ((this.quests.newQuests.length == 0)))){
                return;
            };
            var _local1:QuestVO = this.quests.newQuests[0];
            this.story.init(_local1.acceptStoryId);
            dispatch(new ApplicationEvent(ApplicationEvent.SET_STATE, ApplicationState.NEWQUEST_STORY_LOCATION));
        }

    }
}//package com.gaiaonline.monster.controller.application 
