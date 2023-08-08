//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.settings.view.ui {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;
    import alecmce.ui.slider.*;
    import alecmce.ui.checkbox.*;

    public class Settings extends EventDispatcher {

        private var _mc:MovieClip;
        private var sound:MovieClipSlider;
        private var music:MovieClipSlider;
        private var quality:MovieClipSlider;
        private var fullscreen:MovieClipCheckbox;
        private var dailyPrize:MovieClipCheckbox;
        private var skipIntro:MovieClipCheckbox;
        private var skipIntroValue:Boolean;
        private var soundVolume:Number;
        public var soundChanged:Signal;
        private var musicVolume:Number;
        public var musicChanged:Signal;
        private var qualityValue:uint;
        public var qualityChanged:Signal;
        public var fullscreenChanged:Signal;
        public var dailyPrizeChanged:Signal;
        public var skipIntroChanged:Signal;

        public function Settings(_arg1:MovieClip){
            this._mc = _arg1;
            _arg1.visible = false;
            this.soundChanged = new Signal(Number);
            this.musicChanged = new Signal(Number);
            this.qualityChanged = new Signal(uint);
            this.fullscreenChanged = new Signal(Boolean);
            this.dailyPrizeChanged = new Signal(Boolean);
            this.skipIntroChanged = new Signal(Boolean);
        }
        public function get isVisible():Boolean{
            return (this._mc.visible);
        }
        public function set isVisible(_arg1:Boolean):void{
            if (((_arg1) && (this._mc.stage))){
                this.fullscreen.assert((this._mc.stage.displayState == StageDisplayState.FULL_SCREEN));
                this._mc.addEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
            } else {
                this._mc.removeEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
                this._mc.removeEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
            };
            this._mc.visible = _arg1;
        }
        public function initialValues(_arg1:Number, _arg2:Number, _arg3:uint, _arg4:Boolean):void{
            this.soundVolume = _arg1;
            this.musicVolume = _arg2;
            this.qualityValue = _arg3;
            this.skipIntroValue = _arg4;
            this.sound = new MovieClipSlider(this._mc.sound.knob, this._mc.sound.groove, _arg1, 0, 1, 0.05);
            this.sound.changed.add(this.onSoundVolumeChanged);
            this.music = new MovieClipSlider(this._mc.music.knob, this._mc.music.groove, _arg2, 0, 1, 0.05);
            this.music.changed.add(this.onMusicVolumeChanged);
            this.quality = new MovieClipSlider(this._mc.quality.knob, this._mc.quality.groove, _arg3, 1, 4, 1);
            this.quality.changed.add(this.onQualityChanged);
            this.fullscreen = new MovieClipCheckbox(this._mc.fullscreen, false);
            this.fullscreen.clicked.add(this.onFullscreenClicked);
            if (this._mc.dailyPrize){
                this.dailyPrize = new MovieClipCheckbox(this._mc.dailyPrize, false);
                this.dailyPrize.clicked.add(this.onDailyPrizeClicked);
            };
            this.skipIntro = new MovieClipCheckbox(this._mc.skipIntro, _arg4);
            this.skipIntro.clicked.add(this.onSkipIntroClicked);
        }
        public function dispose(_arg1:Boolean=true):void{
            this.sound.changed.removeAll();
            this.music.changed.removeAll();
            this.quality.changed.removeAll();
            this.fullscreen.clicked.removeAll();
            if (this.dailyPrize){
                this.dailyPrize.clicked.removeAll();
            };
            this.skipIntro.clicked.removeAll();
        }
        public function updatePrize(_arg1:Boolean):void{
            this.dailyPrize.assert(_arg1);
        }
        public function updateSkipIntro(_arg1:Boolean):void{
            this.skipIntro.assert(_arg1);
        }
        private function onSoundVolumeChanged(_arg1:MovieClipSlider, _arg2:Number):void{
            this.soundVolume = _arg2;
            this.soundChanged.dispatch(_arg2);
        }
        private function onMusicVolumeChanged(_arg1:MovieClipSlider, _arg2:Number):void{
            this.musicVolume = _arg2;
            this.musicChanged.dispatch(_arg2);
        }
        private function onQualityChanged(_arg1:MovieClipSlider, _arg2:Number):void{
            this.qualityValue = _arg2;
            this.qualityChanged.dispatch(_arg2);
        }
        private function onFullscreenClicked(_arg1:MovieClipCheckbox, _arg2:Boolean):void{
            this.fullscreenChanged.dispatch(_arg2);
        }
        private function onDailyPrizeClicked(_arg1:MovieClipCheckbox, _arg2:Boolean):void{
            this.dailyPrizeChanged.dispatch(_arg2);
        }
        private function onSkipIntroClicked(_arg1:MovieClipCheckbox, _arg2:Boolean):void{
            this.skipIntroChanged.dispatch(_arg2);
        }
        private function onRollOver(_arg1:MouseEvent):void{
            this._mc.addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
        }
        private function onRollOut(_arg1:MouseEvent):void{
            this.isVisible = false;
        }
        public function get mc():MovieClip{
            return (this._mc);
        }

    }
}//package gaia.moga.settings.view.ui 
