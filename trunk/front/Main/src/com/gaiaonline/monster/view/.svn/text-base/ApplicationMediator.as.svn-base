//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.model.world.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.service.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.view.components.app.*;
    import com.gaiaonline.monster.model.tracking.*;

    public class ApplicationMediator extends Mediator {

		[Inject]
        public var view:Application;
		[Inject]
        public var model:ApplicationModel;
		[Inject]
        public var assets:AssetService;
		[Inject]
        public var data:GSIDataService;
		[Inject]
        public var playerModel:PlayerModel;
		[Inject]
        public var text:TextService;
		[Inject]
        public var worldModel:WorldModel;
		[Inject]
        public var fb:FBService;
		[Inject]
        public var money:MonetizationService;
		[Inject]
        public var tracking:OmnitureService;
        private var invoked:String;

        override public function onRegister():void{
            this.model.stateChanged.add(this.onStateChanged);
            this.fb.pause.add(this.onPause);
            this.fb.unpause.add(this.onResume);
            this.money.pause.add(this.onPause);
            this.money.unpause.add(this.onResume);
            dispatch(new TrackingEvent(TrackingEvent.TRACK, TrackingType.GAME_LOAD));
        }
        override public function onRemove():void{
            this.model.stateChanged.remove(this.onStateChanged);
        }
        private function onStateChanged(_arg1:ApplicationState):void{
            var _local4:String;
            var _local2:Boolean=true;
            var _local3:Boolean;
            switch (_arg1){
                case ApplicationState.NEW_USER_ZODIAC:
                    _local4 = ApplicationEvent.INVOKE_NEW_USER_ZODIAC;
                    break;
                case ApplicationState.NEW_USER_INTRO:
                    _local4 = ApplicationEvent.INVOKE_NEW_USER_INTRO;
                    break;
                case ApplicationState.WORLD:
                    _local4 = ApplicationEvent.INVOKE_WORLD;
                    _local3 = true;
                    break;
                case ApplicationState.BATTLE:
                    _local4 = ApplicationEvent.INVOKE_BATTLE;
                    break;
                case ApplicationState.HOME:
                    _local4 = ApplicationEvent.INVOKE_HOME;
                    break;
                case ApplicationState.FRIEND_RANCH:
                    _local4 = ApplicationEvent.INVOKE_FRIEND_RANCH;
                    _local3 = true;
                    break;
                case ApplicationState.STORY_LOCATION:
                    _local4 = ApplicationEvent.INVOKE_STORY_LOCATION;
                    _local3 = true;
                    break;
                case ApplicationState.NEWQUEST_STORY_LOCATION:
                    _local4 = ApplicationEvent.INVOKE_NEWQUEST_STORY_LOCATION;
                    _local3 = true;
                    break;
                case ApplicationState.CONGRAZZLES_STORY_LOCATION:
                    _local4 = ApplicationEvent.INVOKE_CONGRAZZLES_STORY_LOCATION;
                    _local3 = true;
                    break;
                case ApplicationState.WIN_STORY_LOCATION:
                    _local4 = ApplicationEvent.INVOKE_WIN_STORY_LOCATION;
                    _local3 = true;
                    break;
                case ApplicationState.CAPTURE_STORY_LOCATION:
                    _local4 = ApplicationEvent.INVOKE_CAPTURE_STORY_LOCATION;
                    _local3 = true;
                    break;
                case ApplicationState.LOSE_STORY_LOCATION:
                    _local4 = ApplicationEvent.INVOKE_LOSE_STORY_LOCATION;
                    _local3 = true;
                    break;
                default:
                    _local2 = false;
            };
            if (_local2){
                if (((!(_local3)) && ((_local4 == this.invoked)))){
                    return;
                };
                this.invoked = _local4;
                dispatch(new ApplicationEvent(ApplicationEvent.LOADING));
                dispatch(new ApplicationEvent(_local4));
            };
        }
        private function onPause():void{
            this.view.pause();
        }
        private function onResume():void{
            this.view.resume();
        }

    }
}//package com.gaiaonline.monster.view 
