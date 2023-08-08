//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import com.gaiaonline.monster.events.*;
    import gaia.lib.*;
    import gaia.moga.app.view.ui.*;
    import org.robotlegs.mvcs.*;

    public class SplashMediator extends Mediator {

		[Inject]
        public var view:Splash;
		[Inject]
        public var cookie:Cookie;

        override public function onRegister():void{
            this.view.alwaysSkip.add(this.onAlwaysSkip);
        }
        override public function onRemove():void{
            this.view.dispose();
        }
        private function onAlwaysSkip():void{
            dispatch(new SettingsEvent(SettingsEvent.UPDATE_SETTINGS, 1, "skipIntro"));
            this.cookie.setValue("alwaysSkipIntro", true);
        }

    }
}//package com.gaiaonline.monster.view 
