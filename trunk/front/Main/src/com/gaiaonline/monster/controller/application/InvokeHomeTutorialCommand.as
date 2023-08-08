//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.application {
    import alecmce.ui.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.controller.*;
    import com.gaiaonline.monster.view.components.homeTutorial.*;

    public class InvokeHomeTutorialCommand extends AsyncCommand {

        public var assets:AssetService;
        private var asset:Asset;

        private static const HOME_TUTORIAL_LOCATION:String = "assets/tutorial/homeTutorial.swf";

        override public function execute():void{
            this.asset = this.assets.createWrapper(HOME_TUTORIAL_LOCATION);
            hook(this.asset, this.onComplete, this.onError);
        }
        private function onComplete(_arg1:Asset):void{
            var _local2:HomeTutorial = new HomeTutorial(this.asset);
            dispatch(new PanelsEvent(PanelsEvent.ADD_OVERLAY, _local2));
        }
        private function onError(_arg1:Asset, _arg2:String=""):void{
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 118));
        }

    }
}//package com.gaiaonline.monster.controller.application 
