//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.world {
    import flash.display.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.service.sound.*;
    import flash.geom.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;

    public class SurpriseAnim extends SignallingAssetAnim {

        private var position:Point;
        private var soundEffect:SoundProxy;

        public function SurpriseAnim(_arg1:DisplayObjectContainer, _arg2:Asset, _arg3:Point, _arg4:SoundProxy){
            super(_arg1, _arg2);
            this.position = _arg3;
            this.soundEffect = _arg4;
        }
        override protected function setup(_arg1:Asset):void{
            var _local2:DisplayObject = _arg1.self;
            _local2.x = this.position.x;
            _local2.y = this.position.y;
            super.setup(_arg1);
        }
        override protected function actuallyPlay():void{
            signaller.signal.addOnce(this.onComplete);
            content.gotoAndPlay(1);
            this.soundEffect.play();
        }
        private function onComplete(_arg1:Object):void{
            content.stop();
            _complete.dispatch(this);
        }

    }
}//package com.gaiaonline.monster.view.components.world 
