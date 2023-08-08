//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.attack {
    import com.gaiaonline.monster.service.sound.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;

    public class MonsterAttackHitAnim implements Anim {

        private var _first:IMonsterAttackAnim;
        private var _second:Anim;
        private var _sound:SoundProxy;
        private var _count:uint;
        private var _complete:AnimSignal;

        public function MonsterAttackHitAnim(_arg1:IMonsterAttackAnim, _arg2:Anim, _arg3:SoundProxy){
            this._sound = _arg3;
            this._first = _arg1;
            this._second = _arg2;
            this._count = 0;
            this._complete = new AnimSignal();
        }
        public function play():void{
            this._first.hit.addOnce(this.playSecond);
            this._first.complete.addOnce(this.onComplete);
            this._first.play();
        }
        private function playSecond(_arg1:Anim):void{
            this._second.complete.addOnce(this.onComplete);
            this._second.play();
            if (this._sound){
                this._sound.play();
            };
        }
        private function onComplete(_arg1:Anim):void{
            if (++this._count == 2){
                this._complete.dispatch(this);
            };
        }
        public function get complete():AnimSignal{
            return (this._complete);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.attack 
