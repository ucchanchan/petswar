//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.generic {

    public class ParallelWrapAnim implements Anim {

        protected var parallel:ParallelAnims;

        public function ParallelWrapAnim(){
            this.parallel = new ParallelAnims();
        }
        public function play():void{
            this.parallel.play();
        }
        public function get complete():AnimSignal{
            return (this.parallel.complete);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.generic 
