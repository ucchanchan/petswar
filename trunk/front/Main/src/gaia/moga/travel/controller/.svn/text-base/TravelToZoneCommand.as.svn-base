//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.travel.controller {
    import com.gaiaonline.monster.model.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.model.world.*;
    import gaia.moga.travel.events.*;
    import com.gaiaonline.monster.service.process.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.controller.*;
    import com.gaiaonline.monster.controller.async.*;
    import gaia.moga.*;

    public class TravelToZoneCommand extends AsyncCommand {

		[Inject]
        public var event:TravelToZoneEvent;
		[Inject]
        public var async:AsyncService;
		[Inject]
        public var world:WorldModel;
		[Inject]
        public var travelToNode:TravelToNode;
        private var zone:Zone;

        override public function execute():void{
            this.zone = this.event.zone;
            this.world.isTravellingInATaxi = true;
            if (this.world.currentZone == this.zone){
                this.showWorld();
            } else {
                this.travelToZone();
            };
        }
        private function showWorld():void{
            var _local1:ApplicationEvent = new ApplicationEvent(ApplicationEvent.SET_STATE, ApplicationState.WORLD);
            this.async.push(new AsyncDispatchEvent(eventDispatcher, _local1));
        }
        private function travelToZone():void{
            this.travelToNode.location = this.zone.taxiStop;
            hook(this.travelToNode, this.onComplete, this.onError);
            this.showWorld();
        }
        private function onComplete(_arg1:Async):void{
            this.world.currentLocation = this.zone.taxiStop;
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, Errors.UNABLE_TO_TRAVEL_TO_ZONE));
        }

    }
}//package gaia.moga.travel.controller 
