//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.story.view.anim {
    import flash.display.*;
    import flash.events.*;
    import alecmce.ui.*;
    import alecmce.async.*;

    public class StoryAssetOutAnim extends AsyncBase implements StoryAnim {

        private var asset:Asset;
        private var mc:MovieClip;

        public function StoryAssetOutAnim(_arg1:Asset){
            this.asset = _arg1;
        }
        override protected function onInit():void{
            this.mc = (this.asset.content as MovieClip);
            if ((((this.mc.currentFrame == 1)) || ((this.mc.currentFrame == this.mc.totalFrames)))){
                asyncComplete();
            } else {
                this.mc.addEventListener(Event.ENTER_FRAME, this.iterate);
            };
        }
        public function cancel():void{
            this.mc.removeEventListener(Event.ENTER_FRAME, this.iterate);
            this.mc.stop();
        }
        private function iterate(_arg1:Event):void{
            this.mc.nextFrame();
            if (this.mc.currentFrame < this.mc.totalFrames){
                return;
            };
            var _local2:DisplayObject = this.asset.self;
            if (_local2.parent){
                _local2.parent.removeChild(_local2);
            };
            this.mc.gotoAndStop(1);
            this.mc.removeEventListener(Event.ENTER_FRAME, this.iterate);
            asyncComplete();
        }
        public function get forwards():Boolean{
            return (true);
        }

    }
}//package gaia.moga.story.view.anim 
