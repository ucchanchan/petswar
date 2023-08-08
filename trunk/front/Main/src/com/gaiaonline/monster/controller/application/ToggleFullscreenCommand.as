//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.application {
    import flash.display.*;
    import org.robotlegs.mvcs.*;

    public class ToggleFullscreenCommand extends Command {

        public var view:DisplayObjectContainer;

        override public function execute():void{
            var target:String;
            var stage:Stage = this.view.stage;
            var state:String = stage.displayState;
            switch (state){
                case StageDisplayState.NORMAL:
                    target = StageDisplayState.FULL_SCREEN;
                    break;
                case StageDisplayState.FULL_SCREEN:
                    target = StageDisplayState.NORMAL;
                    break;
            };
            try {
                stage.displayState = target;
            } catch(err:Error) {
            };
        }

    }
}//package com.gaiaonline.monster.controller.application 
