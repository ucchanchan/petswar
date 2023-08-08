//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.ui {
    import flash.display.*;
    import gaia.moga.inventory.model.*;

    public class BonusAttackButton extends ItemButton {

        private var _hasPoints:Boolean;
        private var _haveHints:Boolean;
        private var _hintTitle:String;
        private var _hintMain:String;
        private var _hintOut:String;
        public var extraFrame:int;

        public function BonusAttackButton(_arg1:MovieClip){
            super(_arg1);
            this._hasPoints = true;
            this.extraFrame = 4;
            disabledFrame = 5;
        }
        public function setHint(_arg1:String, _arg2:String, _arg3:String):void{
            this._haveHints = true;
            _arg1 = ((_arg1) || (""));
            this._hintTitle = _arg1;
            _arg2 = ((_arg2) || (""));
            this._hintMain = _arg2;
            _arg3 = ((_arg3) || (""));
            this._hintOut = _arg3;
            this.updateTooltip();
        }
        override protected function updateQuantity(_arg1:InventoryItem):void{
            super.updateQuantity(_arg1);
            this._hasPoints = (_arg1.quantity > 0);
            this.update();
        }
        override public function update():void{
            var _local1:Boolean = ((!(this._hasPoints)) && (isEnabled));
            _target.useHandCursor = !(_local1);
            if (_local1){
                if (isOver){
                    _ui.gotoAndStop(this.extraFrame);
                } else {
                    _ui.gotoAndStop(disabledFrame);
                };
            } else {
                super.update();
            };
            _ui.toolTip.visible = this._haveHints;
            this.updateTooltip();
        }
        override protected function click():void{
            if (this._hasPoints){
                super.click();
            };
        }
        private function updateTooltip():void{
            if (!this._haveHints){
                return;
            };
            var _local1:MovieClip = _ui.toolTip;
            _local1.title.htmlText = this._hintTitle;
            _local1.main.htmlText = (this._hasPoints) ? this._hintMain : this._hintOut;
        }

    }
}//package com.gaiaonline.monster.view.components.battle.ui 
