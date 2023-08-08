//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.application {
    import alecmce.ui.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.process.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.model.quests.*;
    import com.gaiaonline.monster.controller.*;
    import com.gaiaonline.monster.view.components.quests.*;

    public class InvokeQuestCommand extends AsyncCommand {

		[Inject]
        public var questData:QuestDataProcess;
		[Inject]
        public var questModel:QuestModel;
		[Inject]
        public var assets:AssetService;
		[Inject]
        public var text:TextService;
        public var asset:Asset;

        private static const QUEST_ASSET:String = "assets/ui/quests.swf";
        private static const NO_QUESTS_MESSAGE:String = "NO_QUESTS_MESSAGE";

        override public function execute():void{
            var _local1:AsyncCollection = new AsyncCollection();
            _local1.add((this.asset = this.assets.createWrapper(QUEST_ASSET)));
            _local1.add(this.questData);
            hook(_local1, this.onComplete, this.onError);
        }
        private function onComplete(_arg1:Async):void{
            var _local2:String = this.text.getText(NO_QUESTS_MESSAGE);
            var _local3:Quests = new Quests(this.asset, this.questModel.currentQuests, _local2, this.text);
            dispatch(new PanelsEvent(PanelsEvent.ADD_OVERLAY, _local3));
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 110));
        }

    }
}//package com.gaiaonline.monster.controller.application 
