//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.ui {
    import flash.display.*;
    import gaia.moga.monster.model.actions.*;

    public class AttackButton extends IconButton {

        public var _attack:Action;
        private var _isEnabled:Boolean;

        public function AttackButton(_arg1:MovieClip){
            super(_arg1);
            _arg1.attack.label.text = "";
            _arg1.attack.mouseEnabled = false;
            _arg1.attack.mouseChildren = false;
        }
        public function get attack():Action{
            return (this._attack);
        }
        public function set attack(_arg1:Action):void{
            if (this._attack == _arg1){
                return;
            };
            this._attack = _arg1;
            if (!this._attack){
                return;
            };
            this._attack.updated.add(this.updateQuantity);
            _ui.attack.label.text = this._attack.data.name;
            this.updateQuantity(_arg1);
            super.isEnabled = ((this._isEnabled) && (!((this._attack == null))));
        }
        override public function set isEnabled(_arg1:Boolean):void{
            this._isEnabled = _arg1;
            super.isEnabled = ((this._isEnabled) && (!((this._attack == null))));
        }
        protected function updateQuantity(_arg1:Action):void{
            points = (_arg1) ? ((_arg1.quantity + "/") + _arg1.max) : "";
        }

    }
}//package com.gaiaonline.monster.view.components.battle.ui 
