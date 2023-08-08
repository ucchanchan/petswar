//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.story.view.anim {
    import flash.display.*;
    import flash.events.*;
    import alecmce.ui.*;
    import alecmce.async.*;

    public class StoryAssetPlayAnim extends AsyncBase implements StoryAnim {

        private var asset:Asset;
        private var container:DisplayObjectContainer;
        private var mc:MovieClip;
        private var lastFrame:int;

        public function StoryAssetPlayAnim(_arg1:DisplayObjectContainer, _arg2:Asset){
            this.container = _arg1;
            this.asset = _arg2;
        }
        override protected function onInit():void{
            this.container.addChild(this.asset.self);
            this.lastFrame = -1;
            this.mc = (this.asset.content as MovieClip);
            this.mc.gotoAndStop(1);
            this.mc.addEventListener(Event.ENTER_FRAME, this.iterate);
        }
        public function cancel():void{
            this.mc.removeEventListener(Event.ENTER_FRAME, this.iterate);
            this.mc.gotoAndStop(1);
            if (this.asset.self.parent == this.container){
                this.container.removeChild(this.asset.self);
            };
        }
        private function iterate(_arg1:Event):void{
            this.mc.nextFrame();
            if (this.mc.currentFrame < this.mc.totalFrames){
                return;
            };
            this.container.removeChild(this.asset.self);
            this.mc.removeEventListener(Event.ENTER_FRAME, this.iterate);
            asyncComplete();
        }
        public function get forwards():Boolean{
            return (true);
        }

    }
}//package gaia.moga.story.view.anim 
