//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.application {
    import alecmce.ui.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.view.components.whistleReport.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.controller.*;

    public class InvokeWhistleReportCommand extends AsyncCommand {

        public var assets:AssetService;
        public var text:TextService;
        public var asset:Asset;

        private static const REPORT_ASSET:String = "assets/ui/whistleReport.swf";

        override public function execute():void{
            this.asset = this.assets.createWrapper(REPORT_ASSET);
            hook(this.asset, this.onComplete, this.onError);
        }
        private function onComplete(_arg1:Async):void{
            var _local2:WhistleReport = new WhistleReport(this.asset);
            dispatch(new PanelsEvent(PanelsEvent.ADD_OVERLAY, _local2));
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 117));
        }

    }
}//package com.gaiaonline.monster.controller.application 
