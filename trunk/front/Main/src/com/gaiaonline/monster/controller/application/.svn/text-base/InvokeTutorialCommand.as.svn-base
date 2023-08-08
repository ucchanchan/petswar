//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.application {
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.menu.events.*;
    import com.gaiaonline.monster.service.process.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.controller.*;
    import com.gaiaonline.monster.view.components.tutorial.*;

    public class InvokeTutorialCommand extends AsyncCommand {

		[Inject]
        public var assets:AssetService;
		[Inject]
        public var process:CompleteTutorialProcess;
		[Inject]
        public var player:PlayerModel;
		[Inject]
        public var server:GSIDataService;
        private var asset:Asset;

        override public function execute():void{
            var _local1:String = this.getTutorial();
            if (!_local1){
                return;
            };
            this.process.tutorial = _local1;
            var _local2:AsyncCollection = new AsyncCollection();
            _local2.add((this.asset = this.getTutorialAsset(_local1)));
            _local2.add(this.process);
            hook(_local2, this.onComplete, this.onError);
        }
        private function onComplete(_arg1:Async):void{
            var _local2:Tutorial = new Tutorial(this.asset);
            dispatch(new PanelsEvent(PanelsEvent.ADD_OVERLAY, _local2));
            dispatch(new ApplicationEvent(MenuEvent.ENABLE));
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 142));
        }
        private function getTutorial():String{
            var _local1:String;
            if (!this.player.hasCompletedTutorial(PlayerModel.NAP)){
                _local1 = PlayerModel.NAP;
            } else {
                if (!this.player.hasCompletedTutorial(PlayerModel.WHISTLE)){
                    _local1 = PlayerModel.WHISTLE;
                };
            };
            return (_local1);
        }
        private function getTutorialAsset(_arg1:String):Asset{
            switch (_arg1){
                case PlayerModel.NAP:
                    this.asset = this.assets.getTutorialSwf("napTutorial");
                    break;
                case PlayerModel.WHISTLE:
                    this.asset = this.assets.getTutorialSwf("whistleTutorial");
                    break;
            };
            return (this.asset);
        }

    }
}//package com.gaiaonline.monster.controller.application 
