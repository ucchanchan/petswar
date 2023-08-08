//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.view.ui {
    import flash.display.*;
    import alecmce.ui.button.*;

    public class DexUIAddToTeamButton extends MovieClipButton {

        public function DexUIAddToTeamButton(_arg1:MovieClip, _arg2=1, _arg3=2, _arg4=3, _arg5=4){
            super(_arg1, _arg2, _arg3, _arg4, _arg5);
            this.showBubble = false;
        }
        public function get showBubble():Boolean{
            return (ui.bubble.visible);
        }
        public function set showBubble(_arg1:Boolean):void{
            ui.bubble.visible = _arg1;
        }

    }
}//package gaia.moga.dex.view.ui 
