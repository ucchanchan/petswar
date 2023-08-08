//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import alecmce.async.*;
    import com.gaiaonline.monster.service.sound.*;

    public class KillSound extends AsyncBase {

        private var sound:SoundProxy;

        public function KillSound(_arg1:SoundProxy){
            this.sound = _arg1;
        }
        override protected function onInit():void{
            this.sound.dispose();
            asyncComplete();
        }

    }
}//package com.gaiaonline.monster.view 
