//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.newuser.view {
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.sound.*;
    import gaia.moga.newuser.view.ui.*;
    import com.gaiaonline.monster.service.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.model.tracking.*;

    public class NewUserIntroMediator extends Mediator {

		[Inject]
        public var view:NewUserIntro;
		[Inject]
        public var tracking:OmnitureService;
		[Inject]
        public var sounds:SoundService;

        override public function onRegister():void{
            this.view.event.add(this.onCutSceneEnd);
        }
        override public function onRemove():void{
            this.view.event.remove(this.onCutSceneEnd);
        }
        private function onCutSceneEnd(_arg1:Object):void{
            if (_arg1 == "starFallsComplete"){
                dispatch(new TrackingEvent(TrackingEvent.TRACK, TrackingType.END_PART_ONE));
            } else {
                if (_arg1 == "enterBattleComplete"){
                    dispatch(new TrackingEvent(TrackingEvent.TRACK, TrackingType.END_PART_TWO));
                    dispatch(new ApplicationEvent(ApplicationEvent.INVOKE_BATTLE_TUTORIAL));
                };
            };
        }

    }
}//package gaia.moga.newuser.view 
