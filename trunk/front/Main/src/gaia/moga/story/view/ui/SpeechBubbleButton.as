//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.story.view.ui {
    import flash.display.*;
    import alecmce.ui.button.*;

    public class SpeechBubbleButton extends SpeechBubbleArrow {

        private var button:MovieClipButton;

        public function SpeechBubbleButton(_arg1:MovieClip){
            super(_arg1);
            this.button = new MovieClipButton(_arg1.btn);
        }
        public function set label(_arg1:String):void{
            this.button.ui.label.text = _arg1;
        }

    }
}//package gaia.moga.story.view.ui 
