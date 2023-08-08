//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service.sound {
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;

    public class AnimSoundEffect implements Anim {

        private var _complete:AnimSignal;
        private var _soundProxy:SoundProxy;

        public function AnimSoundEffect(_arg1:SoundProxy){
            this._complete = new AnimSignal();
            this._soundProxy = _arg1;
        }
        public function play():void{
            this._soundProxy.play();
            this._complete.dispatch(this);
        }
        public function get complete():AnimSignal{
            return (this._complete);
        }

    }
}//package com.gaiaonline.monster.service.sound 
