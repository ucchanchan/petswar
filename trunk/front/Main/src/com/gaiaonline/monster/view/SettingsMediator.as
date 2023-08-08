//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import flash.display.*;
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.menu.events.*;
    import gaia.moga.settings.view.ui.*;
    import com.gaiaonline.monster.service.sound.*;
    import gaia.lib.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.model.tracking.*;

    public class SettingsMediator extends Mediator {

		[Inject]
        public var view:Settings;
		[Inject]
        public var sounds:SoundService;
		[Inject]
        public var music:MusicService;
		[Inject]
        public var cookie:Cookie;
		[Inject]
        public var model:SettingsModel;

        private static const SETTINGS_VERSION:String = "SETTINGS_VERSION";
        private static const APP_QUALITY:String = "APP_QUALITY";
        private static const SKIP_INTRO:String = "alwaysSkipIntro";
        private static const DAILY_PRIZE:String = "dailyPrize";

        override public function onRegister():void{
            eventDispatcher.addEventListener(MenuEvent.SETTINGS, this.onSettingsToggle);
            this.view.soundChanged.add(this.onSoundChanged);
            this.view.musicChanged.add(this.onMusicChanged);
            this.view.qualityChanged.add(this.onQualityChanged);
            this.view.fullscreenChanged.add(this.onFullscreenChanged);
            this.view.dailyPrizeChanged.add(this.onDailyPrizeChanged);
            this.view.skipIntroChanged.add(this.onSkipIntroChanged);
            var _local1:Number = this.sounds.volume;
            var _local2:Number = this.music.volume;
            var _local3:uint = this.cookie.getValue(SETTINGS_VERSION, 1);
            this.cookie.setValue(SETTINGS_VERSION, 2);
            var _local4:uint = this.cookie.getValue(APP_QUALITY, 2);
            var _local5:Boolean = this.cookie.getValue(SKIP_INTRO, false);
            if ((((_local3 == 1)) && ((_local4 == 3)))){
                _local4 = 4;
            };
            this.onQualityChanged(_local4);
            this.view.initialValues(_local1, _local2, _local4, _local5);
            this.model.updated.add(this.onModelUpdated);
            eventDispatcher.addEventListener(SettingsEvent.UPDATE_SETTINGS, this.onUpdateSetting);
            this.onModelUpdated();
        }
        private function onSettingsToggle(_arg1:MenuEvent):void{
            this.view.isVisible = !(this.view.isVisible);
        }
        private function onModelUpdated():void{
            if (this.model.enablePrize){
                this.view.updatePrize(true);
            };
        }
        private function onSoundChanged(_arg1:Number):void{
            this.sounds.volume = _arg1;
        }
        private function onMusicChanged(_arg1:Number):void{
            this.music.volume = _arg1;
        }
        private function onQualityChanged(_arg1:uint):void{
            var _local2:Stage = this.view.mc.stage;
            switch (_arg1){
                case 1:
                    _local2.quality = StageQuality.LOW;
                    break;
                case 2:
                    _local2.quality = StageQuality.MEDIUM;
                    break;
                case 3:
                case 4:
                    _local2.quality = StageQuality.HIGH;
                    break;
            };
            this.cookie.setValue(APP_QUALITY, _arg1);
            dispatch(new SettingsEvent(SettingsEvent.QUALITY_CHANGED, _arg1));
        }
        private function onFullscreenChanged(_arg1:Boolean):void{
            var _local2:Stage = this.view.mc.stage;
            if (_arg1){
                _local2.displayState = StageDisplayState.FULL_SCREEN;
                dispatch(new TrackingEvent(TrackingEvent.TRACK, "enter_fullscreen"));
            } else {
                _local2.displayState = StageDisplayState.NORMAL;
            };
        }
        private function onDailyPrizeChanged(_arg1:int):void{
            if (_arg1){
                dispatch(new TrackingEvent(TrackingEvent.TRACK, TrackingType.ENABLE_DAILY_PRIZE));
            } else {
                dispatch(new TrackingEvent(TrackingEvent.TRACK, TrackingType.DISABLE_DAILY_PRIZE));
            };
            dispatch(new SettingsEvent(SettingsEvent.UPDATE_SETTINGS, _arg1, DAILY_PRIZE));
        }
        private function onSkipIntroChanged(_arg1:int):void{
            this.cookie.setValue(SKIP_INTRO, _arg1);
        }
        private function onUpdateSetting(_arg1:SettingsEvent):void{
            if (_arg1.setting == "skipIntro"){
                this.view.updateSkipIntro(Boolean(_arg1.value));
            };
        }
        override public function onRemove():void{
            eventDispatcher.removeEventListener(MenuEvent.SETTINGS, this.onSettingsToggle);
            eventDispatcher.removeEventListener(SettingsEvent.UPDATE_SETTINGS, this.onUpdateSetting);
            this.view.soundChanged.removeAll();
            this.view.musicChanged.removeAll();
            this.view.qualityChanged.removeAll();
            this.view.fullscreenChanged.removeAll();
            this.view.dailyPrizeChanged.removeAll();
            this.view.skipIntroChanged.removeAll();
            this.view.dispose();
        }

    }
}//package com.gaiaonline.monster.view 
