//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.story.view {
    import com.gaiaonline.monster.events.*;
    import gaia.moga.story.view.ui.*;
    import org.robotlegs.mvcs.*;

    public class NewQuestStoryMediator extends Mediator {

		[Inject]
        public var view:NewQuestStory;

        override public function onRegister():void{
            this.view.complete.add(this.onStoryComplete);
            this.view.play();
        }
        override public function onRemove():void{
            this.view.complete.remove(this.onStoryComplete);
        }
        private function onStoryComplete(_arg1:NewQuestStory):void{
            dispatch(new PanelsEvent(PanelsEvent.REMOVE_OVERLAY, _arg1));
        }

    }
}//package gaia.moga.story.view 
