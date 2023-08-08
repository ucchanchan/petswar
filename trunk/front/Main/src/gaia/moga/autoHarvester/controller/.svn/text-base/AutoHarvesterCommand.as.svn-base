//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.autoHarvester.controller {
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.autoHarvester.service.*;
    import com.gaiaonline.monster.controller.*;

    public class AutoHarvesterCommand extends AsyncCommand {

        public var process:AutoHarvesterProcess;

        override public function execute():void{
            hook(this.process, this.onComplete, this.onError);
        }
        private function onComplete(_arg1:Async):void{
            dispatch(new TrackingEvent(TrackingEvent.TRACK, "autoharvester_purchase_success"));
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 600));
        }

    }
}//package gaia.moga.autoHarvester.controller 
