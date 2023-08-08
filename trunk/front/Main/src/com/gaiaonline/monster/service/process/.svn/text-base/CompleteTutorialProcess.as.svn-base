//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service.process {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.service.*;

    public class CompleteTutorialProcess extends GSIProcess {

		[Inject]
        public var server:GSIDataService;
		[Inject]
        public var player:PlayerModel;
        public var tutorial:String;

        public function CompleteTutorialProcess(){
            super("CompleteTutorialProcess");
        }
        override protected function onInit():void{
            var _local1:String;
            switch (this.tutorial){
                case PlayerModel.NAP:
                    _local1 = "16";
                    break;
                case PlayerModel.WHISTLE:
                    _local1 = "32";
                    break;
            };
            this.server.finishTutorial(this, _local1);
            this.player.completeTutorial(this.tutorial);
        }
        override protected function parse(_arg1:Object):Boolean{
            return (true);
        }

    }
}//package com.gaiaonline.monster.service.process 
