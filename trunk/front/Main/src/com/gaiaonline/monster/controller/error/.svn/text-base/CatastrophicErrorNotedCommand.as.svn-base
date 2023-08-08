//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.error {
    import com.gaiaonline.monster.model.*;
    import org.robotlegs.mvcs.*;
    import flash.external.*;

    public class CatastrophicErrorNotedCommand extends Command {

        public var model:ApplicationModel;

        override public function execute():void{
            if (ExternalInterface.available){
                ExternalInterface.call("reloadPage");
            } else {
                this.model.state = ApplicationState.SPLASH;
            };
        }

    }
}//package com.gaiaonline.monster.controller.error 
