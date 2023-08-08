//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.world {
    import flash.display.*;
    import com.gskinner.motion.*;
    import alecmce.ui.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.service.sound.*;
    import com.gaiaonline.monster.view.components.world.taxi.*;

    public class TaxiPickupAnim extends AsyncBase {

        private var taxi:ITaxi;
        private var avatar:Asset;
        private var sound:SoundProxy;

        public static const DURATION:Number = 0.2;

        public function TaxiPickupAnim(_arg1:ITaxi, _arg2:Asset, _arg3:SoundProxy){
            this.taxi = _arg1;
            this.avatar = _arg2;
            this.sound = _arg3;
        }
        override protected function onInit():void{
            this.taxi.complete.addOnce(this.onPickup);
            var _local1:DisplayObject = this.avatar.self;
            this.taxi.gotoPosition(_local1.x, _local1.y);
            this.sound.play();
        }
        private function onPickup():void{
            new GTween(this.avatar.self, DURATION, {scaleX:0.0001, scaleY:0.0001}, {onComplete:this.onComplete});
        }
        private function onComplete(_arg1:GTween):void{
            this.sound.dispose();
            asyncComplete();
        }

    }
}//package com.gaiaonline.monster.view.components.world 
