//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.ui.anims {
    import flash.display.*;
    import alecmce.ui.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.monster.*;

    public class CallOutAnim extends MonsterAnim {

        private var name:String;

        public function CallOutAnim(_arg1:DisplayObjectContainer, _arg2:Asset, _arg3:Asset, _arg4:String){
            super(_arg1, _arg2, _arg3);
            this.name = _arg4;
        }
        override protected function setup(_arg1:ParallelAsyncs):void{
            var _local2:MovieClip = MovieClip(_asset.content);
            _local2.text.text.text = (this.name + ", go!");
            super.setup(_arg1);
        }
        override public function play():void{
            super.play();
        }

    }
}//package com.gaiaonline.monster.view.components.battle.ui.anims 
