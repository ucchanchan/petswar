//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.travel.controller {
    import flash.events.*;
    import com.gaiaonline.monster.model.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.model.world.*;
    import gaia.moga.travel.events.*;
    import gaia.moga.world.events.*;
    import com.gaiaonline.monster.service.process.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.controller.*;
    import com.gaiaonline.monster.controller.async.*;
    import gaia.moga.*;

    public class TravelHomeCommand extends AsyncCommand {

		[Inject]
        public var event:TravelHomeEvent;
		[Inject]
        public var async:AsyncService;
		[Inject]
        public var world:WorldModel;
		[Inject]
        public var travelToNode:TravelToNode;

        override public function execute():void{
            if (this.world.currentLocation.isHome){
                this.showHome();
            } else {
                this.travelToHome();
            };
        }
        private function showHome():void{
            var _local1:ApplicationEvent = new ApplicationEvent(ApplicationEvent.SET_STATE, ApplicationState.HOME);
            this.async.push(new AsyncDispatchEvent(eventDispatcher, _local1));
        }
        private function travelToHome():void{
            this.travelToNode.location = this.world.home;
            hook(this.travelToNode, this.onComplete, this.onError);
        }
        private function animateOnWorldMap():void{
            var _local1:Event = new WorldAnimateTravelEvent(WorldAnimateTravelEvent.TAXI, this.travelToNode.route);
            this.async.push(new AsyncDispatchEvent(eventDispatcher, _local1));
        }
        private function onComplete(_arg1:Async):void{
            this.world.currentLocation = this.world.home;
            this.showHome();
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, Errors.UNABLE_TO_TRAVEL_HOME));
        }

    }
}//package gaia.moga.travel.controller 
