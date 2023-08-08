//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import flash.events.*;
    import flash.utils.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.model.world.*;
    import gaia.moga.menu.events.*;
    import gaia.moga.travel.events.*;
    import gaia.moga.world.events.*;
    import com.gaiaonline.monster.service.sound.*;
    import gaia.moga.assets.*;
    import flash.geom.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import com.gaiaonline.monster.service.*;
    import gaia.lib.*;
    import com.gaiaonline.monster.view.components.world.*;
    import com.gaiaonline.monster.model.quests.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.controller.async.*;

    public class WorldMediator extends Mediator {

        private const TIMER_DELAY:int = 6000;
        private const START_QUEST_HINT_LOCATION:int = 4;
        private const BEGINNER_QUEST_ID:int = 32;

		[Inject]
        public var view:World2D;
		[Inject]
        public var model:WorldModel;
		[Inject]
        public var ranch:HomeRanchModel;
		[Inject]
        public var quests:QuestModel;
		[Inject]
        public var async:AsyncService;
		[Inject]
        public var sounds:SoundService;
		[Inject]
        public var assets:AssetService;
		[Inject]
        public var music:MusicService;
		[Inject]
        public var application:ApplicationModel;
		[Inject]
        public var cookie:Cookie;
		[Inject]
        public var player:PlayerModel;
        private var isMovePending:Boolean;
        private var questHintTimer:Timer;

        override public function onRegister():void{
            dispatch(new TeamEvent(TeamEvent.ENABLE_SMALLTEAM));
            addContextListener(MenuEvent.TRAVEL, this.gotoTravel, MenuEvent);
            addContextListener(MenuEvent.QUEST, this.displayQuests, MenuEvent);
            addContextListener(WorldAnimateTravelEvent.TAXI, this.animateTaxi, WorldAnimateTravelEvent);
            addContextListener(WorldAnimateTravelEvent.WALK, this.animateWalk, WorldAnimateTravelEvent);
            addContextListener(SettingsEvent.QUALITY_CHANGED, this.onSettingsQualityChanged, SettingsEvent);
            this.view.setQuality(this.cookie.getValue("APP_QUALITY"));
            this.view.selected.add(this.onLocationSelected);
            this.setSounds();
            var _local1:Boolean = ((((((((this.player) && (this.quests))) && (this.quests.getQuestById(this.BEGINNER_QUEST_ID)))) && (!(this.player.hasCompletedTutorial(PlayerModel.NAP))))) && (((this.quests.getQuestById(this.BEGINNER_QUEST_ID).isComplete) || (this.quests.getQuestById(this.BEGINNER_QUEST_ID).hasBeenCompleted))));
            if (((!(this.ranch.team.canFight)) || (_local1))){
                this.model.isTravellingInATaxi = true;
                this.async.push(this.view.callTaxi(this.sounds.getFX("sounds/flying_shop.mp3", true)));
                this.async.push(new AsyncDispatchEvent(eventDispatcher, new TravelHomeEvent(TravelHomeEvent.TRAVEL_HOME)));
            } else {
                if (this.model.isTravellingInATaxi){
                    this.model.isTravellingInATaxi = false;
                    this.async.push(this.view.animateTaxiDropOff(this.model.currentLocation, this.sounds.getFX("sounds/flying_shop.mp3", true)));
                };
            };
            this.startQuestHintTimer();
        }
        private function onGoingHomeConfirmed():void{
            this.model.isTravellingInATaxi = true;
            this.async.push(this.view.callTaxi(this.sounds.getFX("sounds/flying_shop.mp3", true)));
            this.async.push(new AsyncDispatchEvent(eventDispatcher, new TravelHomeEvent(TravelHomeEvent.TRAVEL_HOME)));
        }
        override public function onRemove():void{
            this.view.selected.remove(this.onLocationSelected);
            this.view.dispose();
            this.resetQuestHintTimer();
        }
        private function onSettingsQualityChanged(_arg1:SettingsEvent):void{
            this.view.setQuality(_arg1.value);
        }
        private function setSounds():void{
            this.music.loadAndPlay("sounds/bgmusic_world.mp3");
        }
        private function onLocationSelected(_arg1:Location, _arg2:int, _arg3:int):void{
            this.model.isSurprised = false;
            if (!this.isMovePending){
                dispatch(new LocationInfoEvent(LocationInfoEvent.SELECTED, _arg1, _arg2, _arg3));
            };
        }
        private function gotoTravel(_arg1:MenuEvent):void{
            addContextListener(TravelEvent.CANCEL, this.gotoTravelCancel, TravelEvent);
            this.async.push(this.view.animateTaxiPickup(this.sounds.getFX("sounds/flying_shop.mp3", true)));
            this.thenTriggerTravel();
        }
        private function gotoTravelCancel(_arg1:TravelEvent):void{
            eventMap.unmapListener(eventDispatcher, TravelEvent.CANCEL, this.gotoTravelCancel, TravelEvent);
            this.async.push(this.view.animateTaxiCancelled(this.sounds.getFX("sounds/flying_shop.mp3", true)));
        }
        private function displayQuests(_arg1:MenuEvent):void{
            this.resetQuestHintTimer();
        }
        private function animateTaxi(_arg1:WorldAnimateTravelEvent):void{
            this.cleanupWorld();
            this.async.push(this.view.callTaxi(this.sounds.getFX("sounds/flying_shop.mp3", true)));
        }
        private function animateWalk(_arg1:WorldAnimateTravelEvent):void{
            var _local7:SoundProxy;
            var _local8:Location;
            this.cleanupWorld();
            var _local2:Vector.<Location> = _arg1.route;
            var _local3:int = _local2.length;
            var _local4:int;
            var _local5:Boolean;
            var _local6:Boolean;
            while (((!(_local6)) && ((_local4 < _local3)))) {
                if (!_local5){
                    _local5 = true;
                    _local7 = this.sounds.getFX("sounds/walk.mp3", true);
                    _local7.play();
                };
                var _temp1 = _local4;
                _local4 = (_local4 + 1);
                _local8 = _local2[_temp1];
                _local6 = (((_local4 < _local3)) && (_local8.isCurrent));
                this.async.push(this.view.moveAvatarToLocation(_local8));
                if (_local6){
                    this.actSurprised(_local8);
                };
            };
            this.async.push(new KillSound(_local7));
        }
        private function actSurprised(_arg1:Location):void{
            this.model.isSurprised = true;
            var _local2:Point = this.view.locationPosition(_arg1);
            var _local3:Asset = this.assets.createWrapper("assets/world/surprise.swf");
            var _local4:SoundProxy = this.sounds.getFX("sounds/surprise.mp3");
            var _local5:Anim = new SurpriseAnim(this.view, _local3, _local2, _local4);
            this.async.pushAnim(_local5);
        }
        private function thenTriggerTravel():void{
            var _local1:TravelEvent = new TravelEvent(TravelEvent.TRIGGER);
            this.async.push(new AsyncDispatchEvent(eventDispatcher, _local1));
        }
        private function startQuestHintTimer():void{
            this.questHintTimer = new Timer(this.TIMER_DELAY, 1);
            this.questHintTimer.addEventListener(TimerEvent.TIMER, this.onTimerComplete, false, 0, true);
            this.questHintTimer.start();
        }
        private function resetQuestHintTimer():void{
            this.questHintTimer.reset();
        }
        private function onTimerComplete(_arg1:TimerEvent):void{
            if (this.model.currentLocation.id >= this.START_QUEST_HINT_LOCATION){
                dispatch(new MenuEvent(MenuEvent.SHOW_ARROW, "QUEST"));
            };
        }
        private function cleanupWorld():void{
            this.resetQuestHintTimer();
            dispatch(new MenuEvent(MenuEvent.HIDE_ARROW, "QUEST"));
        }

    }
}//package com.gaiaonline.monster.view 
