//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service.sound {
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;

    public class AnimMusic implements Anim {

        private var _complete:AnimSignal;
        private var _musicProxy:MusicProxy;

        public function AnimMusic(_arg1:MusicProxy){
            this._complete = new AnimSignal();
            this._musicProxy = _arg1;
        }
        public function play():void{
            this._musicProxy.play();
            this._complete.dispatch(this);
        }
        public function get complete():AnimSignal{
            return (this._complete);
        }

    }
}//package com.gaiaonline.monster.service.sound 
