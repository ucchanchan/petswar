//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.world {
    import flash.display.*;
    import com.gskinner.motion.*;
    import alecmce.ui.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.service.sound.*;
    import com.gaiaonline.monster.view.components.world.taxi.*;

    public class TaxiToHomeAnim extends AsyncBase {

        private var taxi:ITaxi;
        private var avatar:Asset;
        private var homeX:Number;
        private var homeY:Number;
        private var endX:Number;
        private var endY:Number;
        private var sound:SoundProxy;

        public static const DURATION:Number = 0.2;

        public function TaxiToHomeAnim(_arg1:ITaxi, _arg2:Asset, _arg3:WorldNode, _arg4:SoundProxy){
            this.taxi = _arg1;
            this.avatar = _arg2;
            this.homeX = _arg3.x;
            this.homeY = _arg3.y;
            this.endY = this.endY;
            this.endX = this.endX;
            this.sound = _arg4;
        }
        override protected function onInit():void{
            this.sound.play();
            this.taxi.complete.addOnce(this.onHome);
            this.avatar.self.visible = false;
            this.taxi.gotoPosition(this.homeX, this.homeY);
        }
        private function onHome():void{
            var _local1:DisplayObject;
            _local1 = this.avatar.self;
            _local1.x = this.homeX;
            _local1.y = this.homeY;
            _local1.visible = true;
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
