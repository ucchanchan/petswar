//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.application {
    import flash.display.*;
    import org.robotlegs.mvcs.*;

    public class SmallscreenCommand extends Command {

		[Inject]
        public var view:DisplayObjectContainer;

        override public function execute():void{
            var _local1:Stage = this.view.stage;
            _local1.displayState = StageDisplayState.NORMAL;
        }

    }
}//package com.gaiaonline.monster.controller.application 
