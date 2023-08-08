//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.monster {
    import flash.display.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.view.components.battle.fight.*;

    public class MonsterInAnim extends MonsterAnim {

        private var target:MonsterContainer;

        public function MonsterInAnim(_arg1:DisplayObjectContainer, _arg2:Asset, _arg3:Asset, _arg4:MonsterContainer){
            super(_arg1, _arg2, _arg3);
            this.target = _arg4;
        }
        override public function play():void{
            super.play();
        }
        override protected function completeEffect():void{
            this.target.addChild(_monster.self);
            _container.removeChild(_asset.self);
            _signaller.signal.removeAll();
            _complete.dispatch(this);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.monster 
