//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.attack {
    import flash.display.*;
    import alecmce.ui.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.view.components.battle.fight.*;
    import com.gaiaonline.monster.view.components.battle.vo.*;
    import com.gaiaonline.monster.view.components.battle.ui.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.monster.*;

    public class MonsterBuffAnim extends MonsterAnim {

        private var _status:BattleUIStatus;
        private var _buff:BuffVO;
        private var _icon:Asset;

        public function MonsterBuffAnim(_arg1:DisplayObjectContainer, _arg2:Asset, _arg3:FightMonster, _arg4:BattleUIStatus, _arg5:BuffVO, _arg6:Asset){
            super(_arg1, _arg2, _arg3);
            this._status = _arg4;
            this._buff = _arg5;
            _pending.add((this._icon = _arg6));
        }
        override protected function setup(_arg1:ParallelAsyncs):void{
            var _local2:MovieClip = MovieClip(_asset.content);
            _local2.container.addChild(this._icon.self);
            super.setup(_arg1);
        }
        override protected function completeEffect():void{
            var _local1:DisplayObject = this._icon.self;
            if (!this._status.buffList.add(this._buff, this._icon)){
                _local1.parent.removeChild(_local1);
            };
            super.completeEffect();
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.attack 
