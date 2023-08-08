//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.travel.view {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.model.world.*;
    import gaia.moga.menu.events.*;
    import gaia.moga.travel.events.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.travel.view.ui.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.controller.async.*;
    import gaia.moga.travel.view.async.*;

    public class TravelMediator extends Mediator {

		[Inject]
        public var view:TravelUI;
		[Inject]
        public var async:AsyncService;
		[Inject]
        public var app:ApplicationModel;
		[Inject]
        public var world:WorldModel;
		[Inject]
        public var homeRanch:HomeRanchModel;

        override public function onRegister():void{
            this.async.push(new TravelUIEnableAsync(this.view));
            this.view.travel.addOnce(this.onTravel);
            this.view.close.addOnce(this.onClose);
            this.view.setZones(this.world.getZones());
        }
        override public function onRemove():void{
            this.view.dispose();
        }
        private function onTravel(_arg1:Zone):void{
            var _local2 = (this.app.state == ApplicationState.HOME);
            var _local3 = (this.app.state == ApplicationState.FRIEND_RANCH);
            if ((((this.world.currentZone == _arg1)) && (!(((_local2) || (_local3)))))){
                this.onClose();
                return;
            };
            if (((_local2) && ((_arg1.id == 0)))){
                this.onClose();
                return;
            };
            if (((this.homeRanch.team.isMonsterInNap()) && (!((_arg1.id == 0))))){
                dispatch(new TeamEvent(TeamEvent.SHOW_TEAM_MEMBER_NAP_MESSAGE));
                this.onClose();
                return;
            };
            if (((!(this.homeRanch.team.canFight)) && (!((_arg1.id == 0))))){
                dispatch(new TeamEvent(TeamEvent.SHOW_DEAD_TEAM_MESSAGE));
                this.onClose();
                return;
            };
            var _local4:ApplicationEvent = new ApplicationEvent(ApplicationEvent.LOADING);
            this.async.push(new AsyncDispatchEvent(eventDispatcher, _local4));
            this.async.push(new TravelUIDisableAsync(this.view));
            if (_arg1.id == 0){
                this.gotoHome();
            } else {
                this.gotoZone(_arg1);
            };
            this.async.push(new TravelUIRemoveAsync(this.view));
        }
        private function onClose():void{
            this.async.push(new TravelUIDisableAsync(this.view));
            this.async.push(new TravelUIRemoveAsync(this.view));
            this.async.push(new AsyncDispatchEvent(eventDispatcher, new TravelEvent(TravelEvent.CANCEL)));
            this.async.push(new AsyncDispatchEvent(eventDispatcher, new MenuEvent(MenuEvent.ENABLE)));
        }
        private function gotoHome():void{
            this.app.friendRanchID = this.app.userID;
            var _local1:TravelHomeEvent = new TravelHomeEvent(TravelHomeEvent.TRAVEL_HOME);
            this.async.push(new AsyncDispatchEvent(eventDispatcher, _local1));
        }
        private function gotoZone(_arg1:Zone):void{
            var _local2:TravelToZoneEvent = new TravelToZoneEvent(TravelToZoneEvent.TRAVEL_TO_ZONE, _arg1);
            this.async.push(new AsyncDispatchEvent(eventDispatcher, _local2));
        }

    }
}//package gaia.moga.travel.view 
