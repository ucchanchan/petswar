//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.story.view.anim {
    import flash.display.*;
    import flash.events.*;
    import alecmce.ui.*;
    import alecmce.async.*;

    public class StoryAssetInAnim extends AsyncBase implements StoryAnim {

        private var container:DisplayObjectContainer;
        private var asset:Asset;
        private var mc:MovieClip;
        private var lastFrame:int;

        public function StoryAssetInAnim(_arg1:DisplayObjectContainer, _arg2:Asset){
            this.container = _arg1;
            this.asset = _arg2;
        }
        override protected function onInit():void{
            this.container.addChild(this.asset.self);
            this.lastFrame = -1;
            this.mc = (this.asset.content as MovieClip);
            this.mc.addEventListener(Event.ENTER_FRAME, this.iterate);
            this.mc.gotoAndStop(1);
            this.mc.play();
        }
        public function cancel():void{
            this.mc.removeEventListener(Event.ENTER_FRAME, this.iterate);
            this.mc.stop();
        }
        private function iterate(_arg1:Event):void{
            if (this.mc.currentFrame == this.lastFrame){
                this.mc.removeEventListener(Event.ENTER_FRAME, this.iterate);
                asyncComplete();
            } else {
                this.lastFrame = this.mc.currentFrame;
            };
        }
        public function get forwards():Boolean{
            return (true);
        }

    }
}//package gaia.moga.story.view.anim 
