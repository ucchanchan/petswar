//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.ui {
    import flash.display.*;
    import alecmce.ui.*;
    import gaia.moga.monster.model.actions.*;

    public class ZodiacAttackButton extends AttackButton {

        private var _hasPoints:Boolean;
        private var _haveHints:Boolean;
        private var _hintTitle:String;
        private var _hintMain:String;
        private var _hintMod:String;
        private var _hintOut:String;
        private var _hintPlayerIcon:Asset;
        private var _hintNpcIcon:Asset;
        private var _critChance:String;
        private var _procIcon:Asset;
        private var _proc:String;
        public var extraFrame:int;

        public function ZodiacAttackButton(_arg1:MovieClip){
            super(_arg1);
            this.extraFrame = 4;
            disabledFrame = 5;
        }
        public function setHint(_arg1:Asset, _arg2:Asset, _arg3:String, _arg4:String, _arg5:String, _arg6:String, _arg7:String, _arg8:Asset, _arg9:String):void{
            this._haveHints = true;
            this._hintPlayerIcon = _arg1;
            this._hintNpcIcon = _arg2;
            _arg3 = ((_arg3) || (""));
            this._hintTitle = _arg3;
            _arg4 = ((_arg4) || (""));
            this._hintMain = _arg4;
            _arg5 = ((_arg5) || (""));
            this._hintMod = _arg5;
            _arg6 = ((_arg6) || (""));
            this._hintOut = _arg6;
            _arg7 = ((_arg7) || (""));
            this._critChance = _arg7;
            this._procIcon = _arg8;
            _arg9 = ((_arg9) || (""));
            this._proc = _arg9;
            this.updateTooltip();
        }
        override protected function updateQuantity(_arg1:Action):void{
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
        private function updateTooltip():void{
            if (!this._haveHints){
                return;
            };
            if (this._hasPoints){
                this.updateTooltipWithZodiac();
            } else {
                this.updateTooltipWithOut();
            };
        }
        override protected function click():void{
            if (this._hasPoints){
                super.click();
            };
        }
        private function updateTooltipWithOut():void{
            var _local1:MovieClip = _ui.toolTip;
            _local1.gotoAndStop(1);
            _local1.title.htmlText = this._hintTitle;
            _local1.main.htmlText = this._hintOut;
        }
        private function updateTooltipWithZodiac():void{
            var _local1:MovieClip = _ui.toolTip;
            _local1.gotoAndStop("zodiac");
            _local1.title.htmlText = this._hintTitle;
            _local1.zodiacMod.htmlText = this._hintMod;
            _local1.main.htmlText = (this._hintMain + this._critChance);
            var _local2:MovieClip = _local1.playerIcon;
            while (_local2.numChildren > 0) {
                _local2.removeChildAt(0);
            };
            if (this._hintPlayerIcon){
                _local2.addChild(this._hintPlayerIcon.self);
            };
            _local2.scaleX = (_local2.scaleY = 0.3);
            var _local3:MovieClip = _local1.npcIcon;
            while (_local3.numChildren > 0) {
                _local3.removeChildAt(0);
            };
            if (this._hintNpcIcon){
                _local3.addChild(this._hintNpcIcon.self);
            };
            _local3.scaleX = (_local3.scaleY = 0.3);
            var _local4:MovieClip = _local1.modIcon;
            while (0 < _local4.numChildren) {
                _local4.removeChildAt(0);
            };
            if (this._procIcon){
                _local4.addChild(this._procIcon.self);
            };
            _local1.modField.htmlText = this._proc;
        }

    }
}//package com.gaiaonline.monster.view.components.battle.ui 
