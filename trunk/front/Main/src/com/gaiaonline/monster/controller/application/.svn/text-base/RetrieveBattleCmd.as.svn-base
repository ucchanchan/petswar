//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.application {
    import com.gaiaonline.monster.model.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.controller.*;
    import com.gaiaonline.monster.service.process.battle.*;

    public class RetrieveBattleCmd extends AsyncCommand {

        public var retrieve:RetrieveBattle;

        override public function execute():void{
            hook(this.retrieve, this.onComplete, this.onError);
        }
        private function onComplete(_arg1:Async):void{
            dispatch(new ApplicationEvent(ApplicationEvent.SET_STATE, ApplicationState.BATTLE));
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            dispatch(new ApplicationEvent(ApplicationEvent.SET_STATE, ApplicationState.HOME));
        }

    }
}//package com.gaiaonline.monster.controller.application 
