//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.newuser.controller {
    import alecmce.ui.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.assets.*;
    import alecmce.services.*;
    import gaia.moga.newuser.view.ui.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.controller.*;
    import gaia.moga.newuser.controller.process.*;

    public class InvokeNewUserZodiacCommand extends AsyncCommand {

		[Inject]
        public var ticker:Ticker;
		[Inject]
        public var assets:AssetService;
		[Inject]
        public var process:NewUserFlowData;
		[Inject]
        public var text:TextService;
        private var asset:Asset;

        private static const UNABLE_TO_LAUNCH_NEWUSER:String = "UNABLE_TO_LAUNCH_NEWUSER";
        private static const ZODIAC_SELECTION:String = "assets/newUser/newZodiacSelection.swf";

        override public function execute():void{
            this.asset = this.assets.createWrapper(ZODIAC_SELECTION);
            var _local1:ParallelAsyncs = new ParallelAsyncs("InvokeNewUserZodiac-Parallel");
            _local1.add(this.process);
            _local1.add(this.asset);
            hook(_local1, this.onComplete, this.onError);
        }
        private function onComplete(_arg1:Async):void{
            _arg1.error.removeAll();
            var _local2:NewUserScreen = new NewUserScreen(this.ticker, this.asset);
            dispatch(new PanelsEvent(PanelsEvent.SET_PANEL, _local2));
            commandMap.release(this);
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            _arg1.complete.removeAll();
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 119));
            commandMap.release(this);
        }

    }
}//package gaia.moga.newuser.controller 
