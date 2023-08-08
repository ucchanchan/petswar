//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.capture {
    import flash.display.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.view.components.battle.fight.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;

    public class CaptureSuccessAssetAnim extends SignallingAssetAnim {

        private var monster:FightMonster;
        private var toBeReplaced:Asset;

        private static const MONSTER:String = "monster";

        public function CaptureSuccessAssetAnim(_arg1:DisplayObjectContainer, _arg2:Asset, _arg3:Asset, _arg4:FightMonster){
            super(_arg1, _arg2);
            this.monster = _arg4;
            this.toBeReplaced = _arg3;
        }
        override public function play():void{
            super.play();
        }
        override protected function actuallyPlay():void{
            var _local1:DisplayObjectContainer;
            content = MovieClip(asset.content);
            _local1 = DisplayObjectContainer(content.getChildByName(MONSTER));
            this.monster.scaleX = -1;
            _local1.addChild(this.monster);
            container.addChild(asset.self);
            container.removeChild(this.toBeReplaced.self);
            signaller.signal.addOnce(this.onSignal);
            content.gotoAndPlay(1);
        }
        private function onSignal(_arg1:Object=null):void{
            container.removeChild(asset.self);
            _complete.dispatch(this);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.capture 
