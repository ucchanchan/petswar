//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.whistletree.controller {
    import com.gaiaonline.monster.model.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.process.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.whistletree.event.*;
    import com.gaiaonline.monster.controller.*;

    public class WaterWhistleTreeCommand extends AsyncCommand {

		[Inject]
        public var server:GSIDataService;
		[Inject]
        public var process:WaterWhistleTree;
		[Inject]
        public var home:HomeRanchModel;
		[Inject]
        public var timer:TimerService;
		[Inject]
        public var text:TextService;

        override public function execute():void{
            dispatch(new WhistleTreeEvent(WhistleTreeEvent.DISABLE));
            hook(this.process, this.onComplete, this.onError);
        }
        private function onComplete(_arg1:Async):void{
            this.home.numWhistles = this.process.whistleTreeCount;
            this.home.witherOn = this.process.witherOn;
            this.home.lastWatered = this.timer.currentTime;
            dispatch(new WhistleTreeEvent(WhistleTreeEvent.UPDATE));
            dispatch(new WhistleTreeEvent(WhistleTreeEvent.ENABLE));
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 128));
        }

    }
}//package gaia.moga.whistletree.controller 
