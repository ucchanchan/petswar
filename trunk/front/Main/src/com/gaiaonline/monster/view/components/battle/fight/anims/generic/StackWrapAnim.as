//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.generic {

    public class StackWrapAnim implements Anim {

        protected var stack:AnimStack;

        public function StackWrapAnim(){
            this.stack = new AnimStack();
        }
        public function play():void{
            this.stack.play();
        }
        public function get complete():AnimSignal{
            return (this.stack.complete);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.generic 
