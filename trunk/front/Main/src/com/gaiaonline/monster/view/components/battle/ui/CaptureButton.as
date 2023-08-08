//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.ui {
    import flash.display.*;
    import com.gskinner.motion.*;
    import alecmce.ui.*;
    import alecmce.ui.button.*;
    import com.gskinner.motion.easing.*;

    public class CaptureButton extends AssetWrapper {

        public var working:Number;
        private var _percentage:uint;
        private var _button:MovieClip;
        private var _mcb:MovieClipButton;

        public function CaptureButton(_arg1:Asset){
            super(_arg1);
            init();
            this._percentage = 0;
            this.working = 0;
        }
        override protected function onComplete(_arg1:Asset):void{
            addChild(_arg1.self);
            this._button = MovieClip(content).button;
            this._mcb = new MovieClipButton(this._button);
        }
        public function set percentage(_arg1:uint):void{
            if (this._percentage == _arg1){
                return;
            };
            this._percentage = _arg1;
            if (this._button.percentage.label){
                this._button.percentage.label.text = (_arg1 + "%");
            };
            new GTween(this, 1, {working:_arg1}, {ease:Quadratic.easeOut, onChange:this.iterate});
        }
        public function get percentage():uint{
            return (this._percentage);
        }
        private function iterate(_arg1:GTween):void{
            var _local2 = (this.working | 0);
            this._button.piechart.gotoAndStop(_local2);
            this._button.highlight.gotoAndStop(_local2);
        }
        override public function dispose(_arg1:Boolean=true):void{
            this._mcb.isEnabled = false;
            this._mcb = null;
            this._button = null;
            _asset.dispose(_arg1);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.ui 
