//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.story.view.anim {
    import flash.display.*;
    import alecmce.async.*;
    import gaia.moga.story.view.ui.*;
    import gaia.moga.story.model.*;
	import gaia.moga.story.view.anim.StoryAnim;

    public class StoryTalk extends AsyncBase implements StoryAnim {

        private var container:DisplayObjectContainer;
        private var bubble:SpeechBubble;
        private var action:StoryAction;
        private var _forwards:Boolean;

        public function StoryTalk(_arg1:DisplayObjectContainer, _arg2:SpeechBubble, _arg3:StoryAction){
            this.container = _arg1;
            this.bubble = _arg2;
            this.action = _arg3;
        }
        override protected function onInit():void{
            this.container.addChild(this.bubble);
            this.bubble.x = this.action.x;
            this.bubble.y = this.action.y;
            this.bubble.storyComplete.addOnce(this.onBubbleComplete);
            this.bubble.apply(this.action.name, this.action.text, this.action.end);
        }
        public function cancel():void{
            this.bubble.storyComplete.remove(this.onBubbleComplete);
            this.bubble.cancel();
            this.clearUp();
        }
        private function onBubbleComplete(_arg1:SpeechBubble, _arg2:Boolean):void{
            this._forwards = _arg2;
            this.clearUp();
            asyncComplete();
        }
        private function clearUp():void{
            if (this.bubble.parent == this.container){
                this.container.removeChild(this.bubble);
            };
        }
        public function get forwards():Boolean{
            return (this._forwards);
        }

    }
}//package gaia.moga.story.view.anim 
