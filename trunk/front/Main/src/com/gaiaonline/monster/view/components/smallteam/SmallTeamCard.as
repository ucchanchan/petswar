//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.smallteam {
    import flash.display.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import gaia.moga.monster.model.actions.*;
    import flash.text.*;
    import com.gaiaonline.monster.*;
    import gaia.moga.ui.bar.*;

    public class SmallTeamCard {

        private var ui:MovieClip;
        private var labelTF:TextField;
        private var levelTF:TextField;
        private var xp:TintedMovieClipBar;
        private var hp:TintedMovieClipBar;
        private var _monster:MonsterModel;
        private var physical:TextField;
        private var zodiac:TextField;
        private var buff:TextField;
        private var playerZodiacContainer:MovieClip;
        private var npcZodiacContainer:MovieClip;
        private var zodiacModifier:TextField;
        private var playerZodiacIcon:Asset;
        private var npcZodiacIcon:Asset;

        private static const LEVEL_TEXT:String = "Lv. ";
        private static const PADDING:uint = 3;
        private static const ZODIAC_CONTAINER_SCALE:Number = 0.3;

        public function SmallTeamCard(_arg1:MovieClip){
            this.ui = _arg1;
            _arg1.gotoAndStop("noZodiac");
            this.labelTF = TextField(_arg1.label);
            this.labelTF.autoSize = TextFieldAutoSize.RIGHT;
            this.labelTF.text = "";
            this.labelTF.y = -34.5;
            this.levelTF = TextField(_arg1.level);
            this.levelTF.autoSize = TextFieldAutoSize.RIGHT;
            this.levelTF.text = "";
            this.levelTF.y = -38;
            this.xp = new TintedMovieClipBar(_arg1.xp.bar, _arg1.xp.bar.inner, Color.fromXP);
            this.hp = new TintedMovieClipBar(_arg1.hp.bar, _arg1.hp.bar.inner, Color.fromHealth);
            _arg1.zodiacIcon.scaleX = (_arg1.zodiacIcon.scaleY = 0.25);
            _arg1.buffIcon.scaleX = (_arg1.buffIcon.scaleY = 0.8);
            _arg1.buffIcon.x = (_arg1.buffIcon.x - 10);
            _arg1.buffIcon.y = (_arg1.buffIcon.y - 8);
            this.physical = _arg1.physical;
            this.zodiac = _arg1.zodiac;
            this.buff = _arg1.buff;
            this.playerZodiacContainer = _arg1.playerIcon;
            this.playerZodiacContainer.scaleX = (this.playerZodiacContainer.scaleY = ZODIAC_CONTAINER_SCALE);
            this.playerZodiacContainer.visible = false;
            this.npcZodiacContainer = _arg1.npcIcon;
            this.npcZodiacContainer.scaleX = (this.npcZodiacContainer.scaleY = ZODIAC_CONTAINER_SCALE);
            this.npcZodiacContainer.visible = false;
            this.zodiacModifier = _arg1.zodiacMod;
            this.zodiacModifier.text = "";
            this.zodiacModifier.visible = false;
        }
        public function set vo(_arg1:SmallTeamVO):void{
            this._monster = _arg1.monster;
            if (this.ui.zodiacIcon.numChildren > 0){
                this.ui.zodiacIcon.removeChildAt(0);
            };
            if (this.ui.buffIcon.numChildren > 0){
                this.ui.buffIcon.removeChildAt(0);
            };
            if (!this._monster){
                return;
            };
            this.labelTF.text = this._monster.name;
            this.levelTF.text = (LEVEL_TEXT + this._monster.level.toString());
            this.levelTF.x = ((this.labelTF.x + this.labelTF.getLineMetrics(0).width) + PADDING);
            var _local2:ExperienceVO = this._monster.xp;
            this.xp.setBounds(_local2.value, 0, _local2.max);
            this.ui.xp.label.text = ((_local2.value + "/") + _local2.max);
            if (this.ui.miniZodiac){
                this.ui.zodiacIcon.addChild(_arg1.miniZodiac.self);
            };
            if (this.ui.miniBuff){
                this.ui.buffIcon.addChild(_arg1.miniBuff.self);
            };
            this.update();
        }
        public function update():void{
            var _local1:String;
            var _local3:Action;
            var _local2:MonsterActions = this._monster.actions;
            var _local4:ExperienceVO = this._monster.xp;
            this.xp.setBounds(_local4.value, 0, _local4.max);
            this.ui.xp.label.text = ((_local4.value + "/") + _local4.max);
            this.hp.setBounds(this._monster.hp, 0, this._monster.maxHP);
            this.ui.hp.label.text = ((this._monster.hp + " / ") + this._monster.maxHP);
            _local3 = _local2.physicalAttack;
            _local1 = (_local3) ? ((_local3.quantity + " / ") + _local3.max) : "?";
            this.physical.text = _local1;
            _local3 = _local2.zodiacAttack;
            _local1 = (_local3) ? ((_local3.quantity + " / ") + _local3.max) : "?";
            this.zodiac.text = _local1;
            _local3 = _local2.buffAttack;
            _local1 = (_local3) ? ((_local3.quantity + " / ") + _local3.max) : "?";
            this.buff.text = _local1;
        }
        public function rps(_arg1:SmallTeamZodiacVO):void{
            this.ui.gotoAndStop("withZodiac");
            this.labelTF.y = -61.5;
            this.levelTF.y = -65;
            if (_arg1.playerZodiacIcon != this.playerZodiacIcon){
                while (this.playerZodiacContainer.numChildren > 0) {
                    this.playerZodiacContainer.removeChildAt(0);
                };
                this.playerZodiacIcon = _arg1.playerZodiacIcon;
                this.playerZodiacContainer.addChild(_arg1.playerZodiacIcon.self);
                this.playerZodiacContainer.visible = true;
            };
            if (_arg1.npcZodiacIcon != this.npcZodiacIcon){
                while (this.npcZodiacContainer.numChildren > 0) {
                    this.npcZodiacContainer.removeChildAt(0);
                };
                this.npcZodiacIcon = _arg1.npcZodiacIcon;
                this.npcZodiacContainer.addChild(_arg1.npcZodiacIcon.self);
                this.npcZodiacContainer.visible = true;
            };
            this.zodiacModifier.htmlText = _arg1.zodiacMod;
            this.zodiacModifier.visible = true;
        }

    }
}//package com.gaiaonline.monster.view.components.smallteam 
