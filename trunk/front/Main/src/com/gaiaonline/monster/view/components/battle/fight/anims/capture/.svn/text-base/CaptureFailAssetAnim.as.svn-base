//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.capture {
    import flash.display.*;
    import alecmce.ui.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.view.components.battle.fight.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.monster.*;

    public class CaptureFailAssetAnim extends MonsterAnim {

        private var toBeReplaced:Asset;

        public function CaptureFailAssetAnim(_arg1:DisplayObjectContainer, _arg2:Asset, _arg3:Asset, _arg4:FightMonster){
            super(_arg1, _arg2, _arg4);
            this.toBeReplaced = _arg3;
        }
        override protected function setup(_arg1:ParallelAsyncs):void{
            super.setup(_arg1);
            var _local2:DisplayObject = this.toBeReplaced.self;
            _local2.parent.removeChild(_local2);
            _monster.self.scaleX = -1;
        }
        override public function play():void{
            super.play();
        }
        override protected function completeEffect():void{
            super.completeEffect();
            _monster.self.scaleX = 1;
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.capture 
