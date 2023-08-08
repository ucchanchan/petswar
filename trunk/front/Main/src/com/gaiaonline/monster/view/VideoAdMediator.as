//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.sound.*;
    import com.gaiaonline.monster.service.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.view.components.videoAd.*;
    import com.gaiaonline.monster.model.tracking.*;

    public class VideoAdMediator extends Mediator {

        public var view:VideoAdBlueNoodle;
        public var async:AsyncService;
        public var sounds:SoundService;
        public var music:MusicService;
        private var previousSoundVolume:Number;
        private var previousMusicVolume:Number;

        override public function onRegister():void{
            dispatch(new TrackingEvent(TrackingEvent.TRACK, TrackingType.AD_START));
            this.previousSoundVolume = this.sounds.volume;
            this.previousMusicVolume = this.music.volume;
            this.sounds.volume = 0;
            this.music.volume = 0;
        }
        override public function onRemove():void{
            this.view.dispose();
        }
        private function onShop():void{
            dispatch(new TrackingEvent(TrackingEvent.TRACK, TrackingType.AD_CLICK_SHOP));
            dispatch(new ApplicationEvent(ApplicationEvent.INVOKE_PREMIUM_BUNDLE));
        }
        private function onComplete():void{
            this.sounds.volume = this.previousSoundVolume;
            this.music.volume = this.previousMusicVolume;
            dispatch(new TrackingEvent(TrackingEvent.TRACK, TrackingType.AD_END));
            dispatch(new PanelsEvent(PanelsEvent.REMOVE_OVERLAY, this.view));
            dispatch(new VideoAdEvent(VideoAdEvent.END_AD));
        }

    }
}//package com.gaiaonline.monster.view 
