//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import flash.display.*;
    import flash.events.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.model.world.*;
    import gaia.moga.travel.events.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.view.components.world.locationinfo.*;
    import org.robotlegs.mvcs.*;

    public class LocationInfoMediator extends Mediator {

		[Inject]
        public var view:LocationInfo;
		[Inject]
        public var assets:AssetService;
		[Inject]
        public var service:GSIDataService;
		[Inject]
        public var ranch:HomeRanchModel;
		[Inject]
        public var async:AsyncService;
		[Inject]
        public var text:TextService;
        private var stage:Stage;
        private var location:Location;

        override public function onRegister():void{
            eventDispatcher.addEventListener(LocationInfoEvent.SELECTED, this.onLocationSelected);
            this.stage = this.view.stage;
            this.view.clicked.add(this.locationSelected);
            this.view.alpha = 0;
            this.view.visible = false;
        }
        override public function onRemove():void{
            this.view.clicked.removeAll();
            this.stage.removeEventListener(MouseEvent.CLICK, this.hideInfoOnClickOutside);
            this.stage = null;
            eventDispatcher.removeEventListener(LocationInfoEvent.SELECTED, this.onLocationSelected);
        }
        private function onLocationSelected(_arg1:LocationInfoEvent):void{
            if (this.location == _arg1.location){
                this.hideInfo();
                return;
            };
            if (this.location){
                this.hideInfo();
            };
            this.location = _arg1.location;
            var _local2:int = (_arg1.x + 20);
            var _local3:int = ((_arg1.y - 20) - this.view.height);
            if ((_local2 + this.view.width) > 760){
                _local2 = ((_arg1.x - 20) - this.view.width);
            };
            if (_local3 < 100){
                _local3 = 100;
            };
            var _local4:String = this.location.name;
            var _local5:Asset = this.assets.backgroundThumbnail(this.location.background);
            var _local6:int = this.location.targetLevel;
            var _local7:Boolean = this.location.isLocked();
            var _local8:int = this.ranch.team.highestMonsterLevel;
            var _local9:String = this.text.getReasonLocationIsLocked(this.location);
            var _local10:ShowLocationInfoAnim = new ShowLocationInfoAnim(this.view, _local2, _local3, _local4, _local5, _local7, _local6, _local8, _local9);
            _local10.complete.addOnce(this.onAnimComplete);
            this.async.pushAnim(_local10);
        }
        private function locationSelected():void{
            if (this.location.isHomeOrTaxiStop){
                dispatch(new TravelHomeEvent(TravelHomeEvent.TRAVEL_HOME));
            } else {
                dispatch(new TravelToLocationEvent(TravelToLocationEvent.TRAVEL_TO_LOCATION, this.location));
            };
            this.hideInfo();
        }
        private function onAnimComplete(_arg1:Anim):void{
            this.stage.addEventListener(MouseEvent.CLICK, this.hideInfoOnClickOutside);
        }
        private function hideInfoOnClickOutside(_arg1:MouseEvent):void{
            this.hideInfo();
        }
        private function hideInfo():void{
            this.location = null;
            this.stage.removeEventListener(MouseEvent.CLICK, this.hideInfoOnClickOutside);
            this.async.pushAnim(new HideLocationInfoAnim(this.view));
        }

    }
}//package com.gaiaonline.monster.view 
