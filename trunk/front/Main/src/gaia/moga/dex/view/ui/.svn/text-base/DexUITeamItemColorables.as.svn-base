//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.view.ui {
    import flash.display.*;
    import com.gskinner.motion.*;

    public class DexUITeamItemColorables {

        private var button:GTween;
        private var outline:GTween;

        private static const TIME:Number = 0.3;
        private static const BLUE:uint = 4285516762;
        private static const ORANGE:uint = 4294414908;
        private static const GREY:uint = 4284900966;

        public function DexUITeamItemColorables(_arg1:MovieClip, _arg2:MovieClip){
            this.button = new GTween(_arg1, TIME);
            this.outline = new GTween(_arg2, TIME);
            this.setState(false, false);
        }
        public function setState(_arg1:Boolean, _arg2:Boolean):void{
            if (_arg2){
                this.button.setValues({tint:ORANGE, rotation:45});
                this.outline.setValue("tint", ORANGE);
            } else {
                if (_arg1){
                    this.button.setValues({tint:GREY, rotation:45});
                    this.outline.setValue("tint", GREY);
                } else {
                    this.button.setValues({tint:BLUE, rotation:0});
                    this.outline.setValue("tint", BLUE);
                };
            };
        }

    }
}//package gaia.moga.dex.view.ui 
