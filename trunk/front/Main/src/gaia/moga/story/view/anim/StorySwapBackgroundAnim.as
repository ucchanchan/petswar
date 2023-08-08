//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.story.view.anim {
    import flash.display.*;
    import com.gskinner.motion.*;
    import alecmce.ui.*;
    import alecmce.async.*;

    public class StorySwapBackgroundAnim extends AsyncBase implements StoryAnim {

        private var outgoing:Asset;
        private var incoming:Asset;
        private var tween:GTween;

        public function StorySwapBackgroundAnim(_arg1:Asset, _arg2:Asset){
            this.outgoing = _arg1;
            this.incoming = _arg2;
            _arg2.self.alpha = 0;
        }
        override protected function onInit():void{
            this.tween = new GTween(this.incoming.self, 0.4, {alpha:1}, {onComplete:this.onComplete});
        }
        public function cancel():void{
            this.tween.paused = true;
            this.tween.onComplete = null;
            var _local1:DisplayObject = this.outgoing.self;
            if (_local1.parent){
                _local1.parent.removeChild(_local1);
            };
        }
        private function onComplete(_arg1:GTween):void{
            var _local2:DisplayObject = this.outgoing.self;
            if (_local2.parent){
                _local2.parent.removeChild(_local2);
            };
            asyncComplete();
        }
        public function get forwards():Boolean{
            return (true);
        }

    }
}//package gaia.moga.story.view.anim 
