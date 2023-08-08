//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.ui {
    import flash.display.*;
    import alecmce.ui.*;

    public class BattleUIPortrait {

        public var container:MovieClip;
        private var _monster:Asset;
        private var _monsterContainer:Sprite;
        private var _background:Asset;
        private var _backgroundContainer:Sprite;

        public function BattleUIPortrait(_arg1:MovieClip){
            this.container = _arg1;
            _arg1.x = -180;
            this._monsterContainer = _arg1.monster;
            this._backgroundContainer = _arg1.background;
        }
        public function get background():Asset{
            return (this._background);
        }
        public function set background(_arg1:Asset):void{
            if (this._background == _arg1){
                return;
            };
            if (this._background){
                this._backgroundContainer.removeChild(this._background.self);
                this._background.dispose();
            };
            this._background = _arg1;
            if (this._background){
                this._backgroundContainer.addChild(this._background.self);
            };
        }
        public function get monster():Asset{
            return (this._monster);
        }
        public function set monster(_arg1:Asset):void{
            if (this._monster == _arg1){
                return;
            };
            if (this._monster){
                this._monsterContainer.removeChild(this._monster.self);
                this._monster.dispose();
            };
            this._monster = _arg1;
            if (this._monster){
                this._monsterContainer.addChild(this._monster.self);
            };
        }
        public function dispose(_arg1:Boolean=true):void{
            if (this._background){
                this._background.dispose(_arg1);
            };
            if (this._monster){
                this._monster.dispose(_arg1);
            };
            this._background = null;
            this._monster = null;
            this._monsterContainer = null;
            this._backgroundContainer = null;
        }

    }
}//package com.gaiaonline.monster.view.components.battle.ui 
