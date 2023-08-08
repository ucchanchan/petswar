//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.application {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.model.world.*;
    import gaia.moga.story.view.ui.*;
    import gaia.moga.assets.*;
    import gaia.moga.story.view.assets.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.app.*;
    import org.robotlegs.mvcs.*;

    public class InvokeStoryLocationCommand extends Command {

		[Inject]
        public var event:ApplicationEvent;
		[Inject]
        public var text:TextService;
		[Inject]
        public var world:WorldModel;
		[Inject]
        public var assets:AssetService;
		[Inject]
        public var model:StoryModel;
		[Inject]
        public var factory:StoryAssetFactory;
		[Inject]
        public var config:AppConfig;
        private var bundle:StoryAssetBundle;
        private var story:NewStory;

        override public function execute():void{
            var _local1:String;
            switch (this.event.type){
                case ApplicationEvent.INVOKE_STORY_LOCATION:
                case ApplicationEvent.INVOKE_NEWQUEST_STORY_LOCATION:
                case ApplicationEvent.INVOKE_NEW_ANNOUNCEMENT_STORY:
                    _local1 = this.model.id;
                    break;
                case ApplicationEvent.INVOKE_CONGRAZZLES_STORY_LOCATION:
                    _local1 = this.model.id;
                    break;
                case ApplicationEvent.INVOKE_WIN_STORY_LOCATION:
                    _local1 = this.model.winId;
                    break;
                case ApplicationEvent.INVOKE_LOSE_STORY_LOCATION:
                    _local1 = this.model.loseId;
                    break;
            };
            var _local2:String = this.config.parseURL((("data/{$LANGUAGE}/story/" + _local1) + ".txt"));
            this.bundle = new StoryAssetBundle(this.factory);
            this.bundle.url = _local2;
            this.bundle.complete.addOnce(this.onBundleComplete);
            this.bundle.error.addOnce(this.onBundleError);
            this.bundle.init();
            commandMap.detain(this);
        }
        private function onBundleComplete(_arg1:StoryAssetBundle):void{
            this.story = this.createNewStory(_arg1);
            dispatch(new ApplicationEvent(ApplicationEvent.NOT_LOADING));
            dispatch(new PanelsEvent(PanelsEvent.ADD_OVERLAY, this.story));
            commandMap.release(this);
        }
        private function onBundleError(_arg1:StoryAssetBundle, _arg2:String):void{
            eventDispatcher.dispatchEvent(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 109));
            commandMap.release(this);
        }
        protected function createNewStory(_arg1:StoryAssetBundle):NewStory{
            return (new NewStory(_arg1));
        }

    }
}//package com.gaiaonline.monster.controller.application 
