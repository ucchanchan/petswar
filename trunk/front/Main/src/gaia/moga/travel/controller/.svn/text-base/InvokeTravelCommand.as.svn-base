//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.travel.controller {
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import alecmce.services.*;
    import gaia.moga.travel.assets.*;
    import gaia.moga.travel.view.ui.*;
    import com.gaiaonline.monster.controller.*;

    public class InvokeTravelCommand extends AsyncCommand {

		[Inject]
        public var bundle:TravelAssetBundle;
		[Inject]
        public var ticker:Ticker;

        override public function execute():void{
            dispatch(new ApplicationEvent(ApplicationEvent.LOADING));
            var _local1:ParallelAsyncs = new ParallelAsyncs("InvokeTravelCommand-Parallel");
            _local1.add(this.bundle);
            hook(_local1, this.onComplete, this.onError);
        }
        private function onComplete(_arg1:Async):void{
            var _local2:TravelUI = new TravelUI(this.bundle, this.ticker);
            dispatch(new PanelsEvent(PanelsEvent.ADD_OVERLAY, _local2));
            dispatch(new ApplicationEvent(ApplicationEvent.NOT_LOADING));
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 121));
        }

    }
}//package gaia.moga.travel.controller 
