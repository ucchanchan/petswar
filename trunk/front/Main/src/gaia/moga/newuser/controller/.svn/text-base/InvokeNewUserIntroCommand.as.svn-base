//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.newuser.controller {
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.assets.*;
    import gaia.moga.newuser.view.ui.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.newuser.model.*;
    import gaia.moga.newuser.view.assets.*;
    import com.gaiaonline.monster.controller.*;
    import gaia.moga.newuser.controller.process.*;

    public class InvokeNewUserIntroCommand extends AsyncCommand {

		[Inject]
        public var assets:AssetService;
		[Inject]
        public var newuser:NewUserModel;
		[Inject]
        public var text:TextService;
		[Inject]
        public var createUser:CreateUser;
		[Inject]
        public var bundle:NewUserIntroBundle;

        private static const UNABLE_TO_LAUNCH_NEWUSER:String = "UNABLE_TO_LAUNCH_NEWUSER";

        override public function execute():void{
            var _local1:AsyncStack = new AsyncStack("InvokeNewUserIntro-Parallel");
            _local1.push(this.createUser);
            _local1.push(this.bundle);
            hook(_local1, this.onComplete, this.onError);
        }
        private function onComplete(_arg1:Async):void{
            var _local2:NewUserIntro = new NewUserIntro(this.bundle);
            dispatch(new PanelsEvent(PanelsEvent.SET_PANEL, _local2));
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 126));
        }

    }
}//package gaia.moga.newuser.controller 
