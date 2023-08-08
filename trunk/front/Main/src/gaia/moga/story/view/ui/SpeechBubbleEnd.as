//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.story.view.ui {

    public class SpeechBubbleEnd {

        private var id:String;
        public var leftArrow:Boolean;
        public var rightArrow:Boolean;
        public var ok:Boolean;
        public var accept:Boolean;

        public static const ARROWS:SpeechBubbleEnd = new SpeechBubbleEnd("ARROWS", true, true, false, false);
;
        public static const ACCEPT:SpeechBubbleEnd = new SpeechBubbleEnd("ACCEPT", true, false, false, true);
;
        public static const ACCEPT_WITHOUT_LEFT_ARROW:SpeechBubbleEnd = new SpeechBubbleEnd("ACCEPT NO LEFT", false, false, false, true);
;
        public static const OK:SpeechBubbleEnd = new SpeechBubbleEnd("OK", true, false, true, false);
;
        public static const OK_WITHOUT_LEFT_ARROW:SpeechBubbleEnd = new SpeechBubbleEnd("OK NO LEFT", false, false, true, false);
;
        public static const RIGHT_ARROW:SpeechBubbleEnd = new SpeechBubbleEnd("RIGHT_ARROW", false, true, false, false);
;

        public function SpeechBubbleEnd(_arg1:String, _arg2:Boolean, _arg3:Boolean, _arg4:Boolean, _arg5:Boolean){
            this.id = _arg1;
            this.accept = _arg5;
            this.ok = _arg4;
            this.rightArrow = _arg3;
            this.leftArrow = _arg2;
        }
        public function toString():String{
            return (this.id);
        }

    }
}//package gaia.moga.story.view.ui 
