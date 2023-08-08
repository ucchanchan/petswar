//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.win {
    import flash.display.*;
    import org.osflash.signals.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import gaia.moga.monster.model.actions.*;
    import flash.text.*;
    import com.gaiaonline.monster.*;
    import gaia.moga.ui.bar.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.win.parts.*;

    public class WinXPDisplay {

        private var _completed:Signal;
        private var _xp:int;
        private var _maxXP:int;
        private var _currentXP:int;
        private var content:Sprite;
        private var container:Sprite;
        private var xpText:TextField;
        private var nameText:TextField;
        private var levelUp:MovieClip;
        private var newSkill:MovieClip;
        private var xpBar:TintedMovieClipBar;
        private var xpClip:MovieClip;
        private var anim:AnimStack;

        private static const XP_PATTERN:String = "+ {1}xp";
        private static const NAME_TEXT:String = "nameText";
        private static const XP_TEXT:String = "xpText";
        private static const XP_BAR:String = "xpBar";
        private static const LEVEL_UP:String = "levelUpAnim";
        private static const NEW_SKILL:String = "newSkill";
        private static const NAME_PATTERN:String = "{1} Lv.{2}";

        public function WinXPDisplay(_arg1:Sprite, _arg2:Sprite){
            this._completed = new Signal(WinXPDisplay);
            this.content = _arg1;
            this.container = _arg2;
            this.nameText = TextField(_arg1.getChildByName(NAME_TEXT));
            this.nameText.text = _arg1.name;
            this.xpClip = MovieClip(_arg1.getChildByName(XP_BAR));
            this.xpClip.label.text = "";
            this.xpBar = new TintedMovieClipBar(this.xpClip.bar, this.xpClip.bar.inner, Color.fromXP);
            this.xpText = TextField(_arg1.getChildByName(XP_TEXT));
            this.xpText.text = "0";
            this.levelUp = MovieClip(_arg1.getChildByName(LEVEL_UP));
            this.levelUp.gotoAndStop(1);
            this.levelUp.visible = false;
            this.newSkill = MovieClip(_arg1.getChildByName(NEW_SKILL));
            this.newSkill.gotoAndStop(1);
            this.newSkill.visible = false;
            this.anim = new AnimStack();
            this.reset();
        }
        public function setup(_arg1:WinResultVO):void{
            var _local3:LevelUpAnim;
            var _local4:ActionPropsVO;
            var _local5:NewSkillAnim;
            if (this.container.numChildren == 1){
                this.container.removeChildAt(0);
            };
            this.container.addChild(_arg1.asset.self);
            var _local2:uint = (_arg1.levelupReward) ? _arg1.levelupReward.newLevel : _arg1.priorLevel;
            this.nameText.text = NAME_PATTERN.replace("{1}", _arg1.name).replace("{2}", _local2);
            this.xp = 0;
            this.anim.push(new ShowXPAnim(this, this.content, _arg1.gainedXP, _arg1.levelCeilingXP, _arg1.currentXP));
            if (_arg1.levelupReward){
                _local3 = new LevelUpAnim(this.levelUp, _arg1.levelupReward.newLevel);
                this.anim.push(_local3);
            };
            if (_arg1.newSkillRewards){
                for each (_local4 in _arg1.newSkillRewards) {
                    _local5 = new NewSkillAnim(this.newSkill, _local4.name);
                    this.anim.push(_local5);
                };
            };
            this.container.visible = true;
            this.content.visible = true;
        }
        public function reset():void{
            if (this.container.numChildren == 1){
                this.container.removeChildAt(0);
            };
            this.container.visible = false;
            this.content.visible = false;
        }
        public function play():void{
            this.anim.complete.addOnce(this.onAnimComplete);
            this.anim.play();
        }
        private function onAnimComplete(_arg1:Anim):void{
            this._completed.dispatch(this);
        }
        public function get completed():Signal{
            return (this._completed);
        }
        public function get xp():int{
            return (this._xp);
        }
        public function set xp(_arg1:int):void{
            this._xp = _arg1;
            this.xpText.text = XP_PATTERN.replace("{1}", this._xp);
        }
        public function set currentXP(_arg1:int):void{
            this._currentXP = _arg1;
        }
        public function set maxXP(_arg1:int):void{
            this._maxXP = _arg1;
            if (this._currentXP > this._maxXP){
                this._currentXP = this._maxXP;
            };
            var _local2:String = ((this._currentXP + "/") + this._maxXP);
            this.xpClip.label.text = _local2;
            this.xpBar.setBounds(this._currentXP, 0, this._maxXP);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.win 
