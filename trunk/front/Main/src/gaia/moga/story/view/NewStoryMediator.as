//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.story.view {
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.model.world.*;
    import gaia.moga.story.view.ui.*;
    import com.gaiaonline.monster.service.sound.*;
    import gaia.moga.data.*;
    import gaia.moga.data.locations.*;
    import org.robotlegs.mvcs.*;

    public class NewStoryMediator extends Mediator {

		[Inject]
        public var view:NewStory;
		[Inject]
        public var world:WorldModel;
		[Inject]
        public var data:DataBundle;
		[Inject]
        public var music:MusicService;

        override public function onRegister():void{
            this.view.complete.add(this.onStoryComplete);
            this.view.play();
            this.setSounds();
        }
        override public function onRemove():void{
            this.view.complete.remove(this.onStoryComplete);
        }
        private function onStoryComplete(_arg1:NewStory):void{
            dispatch(new PanelsEvent(PanelsEvent.REMOVE_OVERLAY, _arg1));
        }
        private function setSounds():void{
            var _local1:LocationDataVO = this.data.locations.getData(this.world.currentLocation.id);
            if (_local1){
                this.music.loadAndPlay(_local1.storyMusic);
            };
        }

    }
}//package gaia.moga.story.view 
