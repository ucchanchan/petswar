//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight {
    import flash.display.*;

    public class MonsterContainer extends Sprite {

        private var _back:Sprite;
        private var _container:Sprite;
        private var _front:Sprite;
        private var _monster:FightMonster;

        public function MonsterContainer(){
            addChild((this._back = new Sprite()));
            addChild((this._container = new Sprite()));
            addChild((this._front = new Sprite()));
        }
        public function get back():Sprite{
            return (this._back);
        }
        public function setMonster(_arg1:FightMonster):FightMonster{
            if (this._monster == _arg1){
                return (null);
            };
            var _local2:FightMonster = this._monster;
            this._monster = _arg1;
            if (this._monster){
                this._container.addChild(this._monster);
            };
            return (_local2);
        }
        public function get front():Sprite{
            return (this._front);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight 
