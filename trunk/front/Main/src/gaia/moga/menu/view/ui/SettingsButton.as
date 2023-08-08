//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.menu.view.ui {
    import flash.display.*;
    import gaia.moga.settings.view.ui.*;

    public class SettingsButton extends MenuButton {

        private var _settings:Settings;

        public function SettingsButton(_arg1:MovieClip, _arg2:String){
            super(_arg1, _arg2);
            this._settings = new Settings(_arg1.settings);
        }
        public function get settings():Settings{
            return (this._settings);
        }

    }
}//package gaia.moga.menu.view.ui 
