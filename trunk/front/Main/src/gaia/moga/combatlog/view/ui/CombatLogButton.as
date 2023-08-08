//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.combatlog.view.ui {
    import flash.display.*;
    import alecmce.ui.button.*;

    public class CombatLogButton extends MovieClipButton {

        private var _isShuttered:Boolean;

        public function CombatLogButton(_arg1:MovieClip){
            super(_arg1, 1, 3, 1, 1);
            useHandCursor = false;
            isEnabled = true;
            this.isShuttered = true;
        }
        public function get isShuttered():Boolean{
            return (this._isShuttered);
        }
        public function set isShuttered(_arg1:Boolean):void{
            this._isShuttered = _arg1;
            overFrame = (this._isShuttered) ? 2 : 3;
            update();
        }

    }
}//package gaia.moga.combatlog.view.ui 
