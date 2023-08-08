//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.application {
    import com.gaiaonline.monster.model.vo.*;
    import alecmce.ui.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.model.quests.*;
    import com.gaiaonline.monster.controller.*;
    import com.gaiaonline.monster.view.components.quests.*;

    public class InvokeCongrazzlesDialogCommand extends AsyncCommand {

		[Inject]
        public var quests:QuestModel;
		[Inject]
        public var assets:AssetService;
		[Inject]
        public var text:TextService;
        private var asset:Asset;

        private static const CONGRAZZLES_ASSET:String = "assets/ui/congrazzles.swf";

        override public function execute():void{
            if (((!(this.quests.completeQuests)) || ((this.quests.completeQuests.length == 0)))){
                return;
            };
            this.asset = this.assets.createWrapper(CONGRAZZLES_ASSET);
            hook(this.asset, this.onComplete, this.onError);
        }
        private function onComplete(_arg1:Async):void{
            var _local2:QuestVO = this.quests.completeQuests.shift();
            var _local3:Congrazzles = new Congrazzles(this.asset, _local2, this.text);
            dispatch(new PanelsEvent(PanelsEvent.ADD_OVERLAY, _local3));
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 107));
        }

    }
}//package com.gaiaonline.monster.controller.application 
