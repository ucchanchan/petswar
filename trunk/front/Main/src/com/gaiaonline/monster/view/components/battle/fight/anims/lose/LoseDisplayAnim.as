//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.lose {
    import flash.display.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import flash.text.*;

    public class LoseDisplayAnim extends SignallingAssetAnim {

        private var reason:String;

        private static const REASON:String = "reason";
        private static const LABEL:String = "label";

        public function LoseDisplayAnim(_arg1:DisplayObjectContainer, _arg2:Asset, _arg3:String){
            super(_arg1, _arg2);
            this.reason = _arg3;
        }
        override protected function actuallyPlay():void{
            content = MovieClip(asset.content);
            var _local1:DisplayObjectContainer = DisplayObjectContainer(content.getChildByName(REASON));
            var _local2:TextField = TextField(_local1.getChildByName(LABEL));
            _local2.text = this.reason;
            container.addChild(asset.self);
            signaller.signal.addOnce(this.onSignal);
            content.gotoAndPlay(1);
        }
        private function onSignal(_arg1:Object=null):void{
            container.removeChild(asset.self);
            _complete.dispatch(this);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.lose 
