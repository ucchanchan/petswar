//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.application {
    import gaia.moga.story.view.ui.*;
    import gaia.moga.story.view.assets.*;

    public class InvokeNewQuestStoryLocationCommand extends InvokeStoryLocationCommand {

        override protected function createNewStory(_arg1:StoryAssetBundle):NewStory{
            return (new NewQuestStory(_arg1));
        }

    }
}//package com.gaiaonline.monster.controller.application 
