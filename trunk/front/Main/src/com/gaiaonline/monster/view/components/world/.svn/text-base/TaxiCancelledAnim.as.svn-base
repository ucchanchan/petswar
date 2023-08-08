//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.world {
    import com.gskinner.motion.*;
    import alecmce.ui.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.service.sound.*;
    import com.gaiaonline.monster.view.components.world.taxi.*;

    public class TaxiCancelledAnim extends AsyncBase {

        private var taxi:ITaxi;
        private var avatar:Asset;
        private var sound:SoundProxy;

        public static const DURATION:Number = 0.2;

        public function TaxiCancelledAnim(_arg1:ITaxi, _arg2:Asset, _arg3:SoundProxy){
            this.taxi = _arg1;
            this.avatar = _arg2;
            this.sound = _arg3;
        }
        override protected function onInit():void{
            this.avatar.self.visible = true;
            new GTween(this.avatar.self, DURATION, {scaleX:1, scaleY:1});
            this.taxi.complete.addOnce(this.onComplete);
            this.taxi.gotoPosition(360, -20);
        }
        private function onComplete():void{
            this.sound.dispose();
            asyncComplete();
        }

    }
}//package com.gaiaonline.monster.view.components.world 
