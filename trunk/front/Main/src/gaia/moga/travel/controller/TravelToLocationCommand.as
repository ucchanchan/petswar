//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.travel.controller {
    import flash.events.*;
    import com.gaiaonline.monster.model.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.model.world.*;
    import gaia.moga.travel.events.*;
    import gaia.moga.world.events.*;
    import gaia.moga.story.view.ui.*;
    import com.gaiaonline.monster.service.process.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.model.quests.*;
    import com.gaiaonline.monster.controller.*;
    import com.gaiaonline.monster.controller.async.*;
    import gaia.moga.*;

    public class TravelToLocationCommand extends AsyncCommand {

		[Inject]
        public var event:TravelToLocationEvent;
		[Inject]
        public var async:AsyncService;
		[Inject]
        public var world:WorldModel;
		[Inject]
        public var story:StoryModel;
		[Inject]
        public var ranch:HomeRanchModel;
		[Inject]
        public var travelToNode:TravelToNode;
		[Inject]
        public var quests:QuestModel;
        private var location:Location;
        private var isCurrentLocation:Boolean;

        override public function execute():void{
            this.location = this.event.location;
            this.isCurrentLocation = (this.world.currentLocation == this.location);
            this.travelToLocation();
        }
        private function travelToLocation():void{
            this.travelToNode.location = this.location;
            hook(this.travelToNode, this.onComplete, this.onError);
        }
        private function onComplete(_arg1:Async):void{
            if (!this.isCurrentLocation){
                this.animateOnWorldMap();
            };
            this.gotoLocation();
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, Errors.UNABLE_TO_TRAVEL_TO_LOCATION));
        }
        private function animateOnWorldMap():void{
            dispatch(new WorldAnimateTravelEvent(WorldAnimateTravelEvent.WALK, this.travelToNode.route));
        }
        private function gotoLocation():void{
            dispatch(new ApplicationEvent(ApplicationEvent.PUSH_QUEST_PANELS));
            if (this.world.currentLocation.isHomeOrTaxiStop){
                this.gotoHome();
            } else {
                if (this.world.isStory){
                    this.gotoStory();
                };
                if (this.world.isBattle){
                    this.gotoBattle();
                } else {
                    this.gotoWorldWhenDone();
                };
            };
        }
        private function gotoWorldWhenDone():void{
            this.async.push(new AsyncDispatchEvent(eventDispatcher, new ApplicationEvent(ApplicationEvent.SET_STATE, ApplicationState.WORLD)));
        }
        private function gotoBattle():void{
            var _local1:Event;
            if (this.ranch.team.canFight){
                _local1 = new ApplicationEvent(ApplicationEvent.SET_STATE, ApplicationState.BATTLE);
            } else {
                _local1 = new TeamEvent(TeamEvent.SHOW_DEAD_TEAM_MESSAGE);
            };
            this.async.push(new AsyncDispatchEvent(eventDispatcher, _local1));
        }
        private function gotoStory():void{
            this.async.push(new AsyncDispatchWaitForPanelClosedEvent(eventDispatcher, new ApplicationEvent(ApplicationEvent.SET_STATE, ApplicationState.STORY_LOCATION), NewStory));
        }
        private function gotoHome():void{
            var _local1:Event = new ApplicationEvent(ApplicationEvent.SET_STATE, ApplicationState.HOME);
            this.async.push(new AsyncDispatchEvent(eventDispatcher, _local1));
        }

    }
}//package gaia.moga.travel.controller 
