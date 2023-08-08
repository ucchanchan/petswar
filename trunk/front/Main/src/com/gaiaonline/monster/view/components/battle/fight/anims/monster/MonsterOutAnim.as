//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.monster {
    import flash.display.*;
    import alecmce.ui.*;

    public class MonsterOutAnim extends MonsterAnim {

        private var _reverse:Boolean;

        public function MonsterOutAnim(_arg1:DisplayObjectContainer, _arg2:Asset, _arg3:Asset, _arg4:Boolean=false){
            super(_arg1, _arg2, _arg3);
            this._reverse = _arg4;
        }
        override public function play():void{
            if (this._reverse){
                _monster.self.scaleX = -1;
            };
            super.play();
        }
        override protected function completeEffect():void{
            _container.removeChild(_asset.self);
            _signaller.signal.removeAll();
            _complete.dispatch(this);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.monster 
