//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.home {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.view.components.home.ui.*;
    import gaia.moga.inventory.model.*;

    public class MonsterCard extends Sprite {

        private const WAKEUP:String = "wakeup_rollover";
        private const PUT_IN_NAP:String = "sleep_rollover";
        private const NO_BUTTONS:String = "no_buttons";

        private var _openEditMoves:Signal;
        private var _enterNap:Signal;
        private var _rechargeMonster:Signal;
        private var _wakeUpMonster:Signal;
        private var _close:Signal;
        private var _initCard:Signal;
        private var _rechargeButton:SimpleButton;
        private var _wakeUpButton:SimpleButton;
        private var _napButton:SimpleButton;
        private var _inventory:InventoryModel;
        private var _asset:Asset;
        private var card:MovieClip;
        private var _info:MonsterCardInfoVO;
        private var _hideButtons:Boolean;

        private static const MONSTER_CARD_DELAY:uint = 400;
        private static const DURATION:Number = 0.2;
        private static const NAP_HP_THRESHOLD:Number = 1;

        public function MonsterCard(_arg1:Asset, _arg2:Boolean){
            this._hideButtons = _arg2;
            this._initCard = new Signal();
            this._close = new Signal();
            this._enterNap = new Signal();
            this._rechargeMonster = new Signal();
            this._wakeUpMonster = new Signal();
            this._asset = _arg1;
            addChild(this._asset.self);
            if (this._asset.isComplete){
                this.prep(this._asset);
            } else {
                this._asset.complete.addOnce(this.prep);
            };
        }
        public function init(_arg1:MonsterModel):void{
            this._initCard.dispatch(_arg1);
        }
        public function remove():void{
        }
        public function get initCard():Signal{
            return (this._initCard);
        }
        private function prep(_arg1:Async):void{
            var _local2:Asset = Asset(_arg1);
            var _local3:MovieClip = MovieClip(_local2.content);
            this.card = _local3.monsterCard;
        }
        public function get rechargeMonster():Signal{
            return (this._rechargeMonster);
        }
        public function get enterNap():Signal{
            return (this._enterNap);
        }
        public function get wakeUpMonster():Signal{
            return (this._wakeUpMonster);
        }
        public function get close():Signal{
            return (this._close);
        }
        public function populateInfo(_arg1:MonsterCardInfoVO):void{
            var _local2:MonsterModel = _arg1.model;
            if (((_arg1.napTimer) && (!(this._hideButtons)))){
                this.card.gotoAndPlay(this.WAKEUP);
                this._rechargeButton = this.card.rechargeButton;
                this._rechargeButton.addEventListener(MouseEvent.CLICK, this.onRecharge);
                this._wakeUpButton = this.card.wakeUpButton;
                this._wakeUpButton.addEventListener(MouseEvent.CLICK, this.onWakeUp);
            } else {
                if (((_local2.canNap) && (!(this._hideButtons)))){
                    this.card.gotoAndPlay(this.PUT_IN_NAP);
                    this._napButton = this.card.napButton;
                    this._napButton.addEventListener(MouseEvent.CLICK, this.onStartNap);
                    this._rechargeButton = this.card.rechargeButton;
                    this._rechargeButton.addEventListener(MouseEvent.CLICK, this.onRecharge);
                } else {
                    this.card.gotoAndPlay(this.NO_BUTTONS);
                };
            };
            this._info = _arg1;
            this.card.info.monsterName.text = _arg1.model.name;
            this.card.info.hpText.text = (_local2.hp + " HP");
            this.card.info.hpBar.scaleX = (_local2.hp / _local2.maxHP);
            var _local3:ExperienceVO = _local2.xp;
            this.card.info.xpBar.scaleX = (_local3.value / _local3.max);
            this.card.info.xpText.text = (((_local3.value + " / ") + _local3.max) + "  XP");
            this.card.info.levelText.text = ("Lvl: " + _local2.level);
            var _local4:MovieClip = this.card.info.zodiacIcon;
            if (_local4.numChildren > 0){
                _local4.removeChildAt(0);
            };
            var _local5:Asset = _arg1.zodiac;
            _local5.complete.add(this.resizeZodiacIcon);
            _local4.addChild(_arg1.zodiac.self);
            this.card.info.mouseEnabled = false;
            this.card.info.mouseChildren = false;
        }
        private function resizeZodiacIcon(_arg1:Asset):void{
            _arg1.self.width = 20;
            _arg1.self.height = 20;
            _arg1.self.x = (_arg1.self.x + 15);
            _arg1.self.y = (_arg1.self.y + 15);
        }
        private function onRecharge(_arg1:MouseEvent):void{
            this._rechargeButton.removeEventListener(MouseEvent.CLICK, this.onRecharge);
            this._rechargeMonster.dispatch(this._info.model);
        }
        private function onStartNap(_arg1:MouseEvent):void{
            this._napButton.removeEventListener(MouseEvent.CLICK, this.onStartNap);
            this._enterNap.dispatch(this._info.model);
        }
        private function onWakeUp(_arg1:MouseEvent):void{
            this._wakeUpButton.removeEventListener(MouseEvent.CLICK, this.onWakeUp);
            this._wakeUpMonster.dispatch(this._info.model);
        }
        public function dispose(_arg1:Boolean=true):void{
        }
        public function get asset():Asset{
            return (this._asset);
        }

    }
}//package com.gaiaonline.monster.view.components.home 
