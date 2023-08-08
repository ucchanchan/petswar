//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.simple {
    import com.gskinner.motion.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import com.gaiaonline.monster.view.components.battle.ui.*;

    public class StatusShowAnim implements Anim {

        private var status:BattleUIStatus;
        public var hp:int;
        public var maxHP:int;
        public var level:int;
        public var name:String;
        private var zodiac:Asset;
        private var _complete:AnimSignal;

        private static const SHOW_TIME:Number = 0.5;

        public function StatusShowAnim(_arg1:BattleUIStatus, _arg2:MonsterModel, _arg3:Asset, _arg4:int=-1){
            this.status = _arg1;
            this.name = _arg2.name;
            this.hp = ((_arg4 > -1)) ? _arg4 : _arg2.hp;
            this.maxHP = _arg2.maxHP;
            this.level = _arg2.level;
            this.zodiac = _arg3;
            this._complete = new AnimSignal();
        }
        public function play():void{
            this.status.setup(this.name, this.hp, this.maxHP, this.level, this.zodiac);
            this.status.ui.visible = true;
            new GTween(this.status.ui, SHOW_TIME, {alpha:1}, {onComplete:this.dispatchComplete});
        }
        private function dispatchComplete(_arg1:GTween):void{
            this._complete.dispatch(this);
        }
        public function get complete():AnimSignal{
            return (this._complete);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.simple 
