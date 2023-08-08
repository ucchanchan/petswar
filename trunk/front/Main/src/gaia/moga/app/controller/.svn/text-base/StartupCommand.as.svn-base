//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.app.controller {
    import flash.display.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.data.*;
    import gaia.moga.assets.bundle.*;
    import com.gaiaonline.monster.controller.*;
    import com.gaiaonline.monster.view.components.app.*;
    import gaia.moga.*;

    public class StartupCommand extends AsyncCommand {

		[Inject]
        public var view:DisplayObjectContainer;
		[Inject]
        public var data:DataBundle;
		[Inject]
        public var bundle:AppAssetsBundle;

        override public function execute():void{
            var _local1:Application = new Application(this.bundle);
            this.view.addChild(_local1);
            hook(this.data, this.onComplete, this.onError);
        }
        private function onComplete(_arg1:Async):void{
            dispatch(new ApplicationEvent(ApplicationEvent.CONTINUE_STARTUP));
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, Errors.UNABLE_TO_LAUNCH_APPLICATION));
        }

    }
}//package gaia.moga.app.controller 
