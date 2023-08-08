//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service.process {
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.model.quests.*;

    public class QuestDataProcess extends GSIProcess {

		[Inject]
        public var server:GSIDataService;
		[Inject]
        public var model:QuestModel;

        public function QuestDataProcess(){
            super("QuestDataProcess");
        }
        override protected function onInit():void{
            this.server.getQuestList(this);
        }
        override protected function parse(_arg1:Object):Boolean{
            this.model.init(_arg1.quests);
            return (true);
        }

    }
}//package com.gaiaonline.monster.service.process 
