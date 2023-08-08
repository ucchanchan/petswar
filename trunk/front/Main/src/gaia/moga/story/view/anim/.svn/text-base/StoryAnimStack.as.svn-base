//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.story.view.anim {
    import alecmce.async.*;

    public class StoryAnimStack extends AsyncBase implements StoryAnim {

        private var stack:AsyncStack;
        private var storyTalk:StoryTalk;

        public function StoryAnimStack(_arg1:String){
            this.stack = new AsyncStack(_arg1);
        }
        public function push(_arg1:StoryAnim):void{
            this.stack.push(_arg1);
            if ((_arg1 is StoryTalk)){
                this.storyTalk = (_arg1 as StoryTalk);
            };
        }
        override protected function onInit():void{
            this.stack.complete.addOnce(this.onStackComplete);
            this.stack.error.addOnce(this.onStackError);
            this.stack.init();
        }
        public function cancel():void{
            this.stack.complete.remove(this.onStackComplete);
            this.stack.error.remove(this.onStackError);
        }
        private function onStackComplete(_arg1:AsyncStack):void{
            this.stack.error.removeAll();
            asyncComplete();
        }
        private function onStackError(_arg1:AsyncStack, _arg2:String):void{
            this.stack.complete.removeAll();
            asyncError(_arg2);
        }
        public function get forwards():Boolean{
            return ((this.storyTalk) ? this.storyTalk.forwards : false);
        }

    }
}//package gaia.moga.story.view.anim 
