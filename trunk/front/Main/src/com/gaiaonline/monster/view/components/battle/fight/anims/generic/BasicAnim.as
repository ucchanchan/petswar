//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.generic {

    public class BasicAnim implements Anim {

        protected var _complete:AnimSignal;

        public function BasicAnim(){
            this._complete = new AnimSignal();
        }
        public function play():void{
        }
        public function get complete():AnimSignal{
            return (this._complete);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.generic 
