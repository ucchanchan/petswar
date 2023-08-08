//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.whistleReport {
    import flash.display.*;
    import alecmce.ui.*;
    import alecmce.async.*;

    public class WhistleReportLevelUpAsync extends AsyncBase {

        private var _asset:Asset;
        private var _animation:MovieClip;

        public function WhistleReportLevelUpAsync(_arg1:Asset, _arg2:Boolean=true){
            this._asset = _arg1;
            if (_arg2){
                init();
            };
        }
        public function get anim():MovieClip{
            return (this._animation);
        }
        public function play(_arg1:int):void{
            this._animation.levelUpAnim.newLevelText.textBox.text = ("New Level:" + _arg1.toString(10));
            this._animation.levelUpAnim.gotoAndPlay(1);
        }
        override protected function onInit():void{
            if (this._asset.isComplete){
                this.initialize();
            } else {
                this._asset.complete.addOnce(this.initialize);
            };
        }
        private function initialize(_arg1:Asset=null):void{
            this._animation = this._asset.content["anim"];
            this._animation.levelUpAnim.gotoAndStop(1);
            this._animation.levelUpAnim.addFrameScript((this._animation.levelUpAnim.totalFrames - 1), this.onFinalFrame);
        }
        private function onFinalFrame():void{
            this._animation.levelUpAnim.gotoAndStop(1);
            asyncComplete();
        }

    }
}//package com.gaiaonline.monster.view.components.whistleReport 
