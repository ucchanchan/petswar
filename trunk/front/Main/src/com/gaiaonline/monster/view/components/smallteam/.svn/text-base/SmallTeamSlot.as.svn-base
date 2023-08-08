//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.smallteam {
    import flash.display.*;
    import flash.events.*;
    import com.gskinner.motion.*;
    import org.osflash.signals.*;
    import com.gaiaonline.monster.model.*;
    import alecmce.ui.button.*;
    import com.gaiaonline.monster.*;
    import com.gaiaonline.monster.view.components.smallteam.anim.*;

    public class SmallTeamSlot {

        private var _clicked:Signal;
        private var _info:Signal;
        private var _coffee:Signal;
        private var ui:MovieClip;
        private var button:MovieClipButton;
        private var coffeeButton:MovieClipButton;
        private var card:SmallTeamCard;
        private var container:Sprite;
        private var health:MovieClip;
        private var slider:Sprite;
        private var overlay:Sprite;
        private var dead:Sprite;
        private var zzz:Sprite;
        private var vo:SmallTeamVO;
        private var isSelected:Boolean;
        public var isHealthy:Boolean;
        private var isOver:Boolean;
        private var _isEnabled:Boolean;
        private var healthSlider:HealthSlider;
        private var overlayTint:BackgroundTint;

        private static const SELECTABLE:uint = 4278190080;
        private static const LOCKED:uint = 4294967295;
        private static const RED:uint = 4290912294;
        private static const HIGHLIGHT:uint = 4294953829;
        private static const NAPPING:uint = 4280193279;

        public function SmallTeamSlot(){
            this._clicked = new Signal(SmallTeamSlot);
            this._coffee = new Signal(SmallTeamSlot);
            this._info = new Signal(SmallTeamSlot);
            this._isEnabled = true;
            this.overlayTint = new BackgroundTint();
            this.healthSlider = new HealthSlider();
        }
        public function init(_arg1:MovieClip):void{
            this.ui = _arg1;
            _arg1.visible = false;
            this.button = new MovieClipButton(_arg1);
            if (_arg1.coffee){
                this.coffeeButton = new MovieClipButton(_arg1.coffee);
                this.coffeeButton.clicked.add(this.onCoffee);
            };
            this.container = _arg1.container;
            this.container.mouseEnabled = false;
            this.container.mouseChildren = false;
            if (_arg1.card){
                this.card = new SmallTeamCard(_arg1.card);
            };
            this.health = _arg1.health;
            this.health.mouseEnabled = false;
            this.health.mouseChildren = false;
            this.slider = this.health.slider;
            new GTween(this.slider, 0.001, {tint:Color.fromHealth(0)});
            this.healthSlider.init(this.slider.width, this.slider);
            this.overlay = _arg1.overlay;
            this.overlay.blendMode = BlendMode.OVERLAY;
            this.overlay.visible = true;
            this.overlayTint.init(this.overlay);
            this.dead = _arg1.dead;
            this.dead.visible = false;
            this.zzz = _arg1.zzz;
            this.zzz.visible = false;
            if (this.vo){
                this.container.addChild(this.vo.icon.self);
            };
            this.update();
        }
        public function set canUseCoffee(_arg1:Boolean):void{
            var _local2:Boolean = ((((this.vo) && (this.vo.monster))) && (this._isEnabled));
            this.coffeeButton.isEnabled = ((_local2) && (this.vo.monster.canNap));
        }
        public function assign(_arg1:SmallTeamVO):void{
            if (((this.vo) && (this.vo.monster))){
                this.vo.monster.napping.remove(this.onNapping);
            };
            this.vo = _arg1;
            if (!this.ui){
                return;
            };
            while (this.container.numChildren) {
                this.container.removeChildAt(0);
            };
            if (((_arg1) && (_arg1.monster))){
                _arg1.monster.napping.add(this.onNapping);
                if (this.card){
                    this.card.vo = _arg1;
                };
            };
            this.container.addChild(_arg1.icon.self);
            this.update();
        }
        public function rps(_arg1:SmallTeamZodiacVO):void{
            this.card.rps(_arg1);
        }
        private function onNapping(_arg1:MonsterModel, _arg2:Boolean):void{
            this.update();
        }
        public function update(_arg1:MonsterModel=null):void{
            if (((!(_arg1)) && (this.vo))){
                _arg1 = this.vo.monster;
            };
            if (((((_arg1) && ((_arg1.onTeam == 0)))) && ((_arg1.id.indexOf("n") == -1)))){
                this.clear();
                return;
            };
            var _local2:Number = (_arg1) ? (_arg1.hp / _arg1.maxHP) : 0;
            this.isHealthy = (_local2 > 0);
            if (!this.ui){
                return;
            };
            var _local3 = !((_arg1 == null));
            this.ui.visible = _local3;
            this.updateEventListeners();
            if (!_local3){
                this.dead.visible = false;
                this.zzz.visible = false;
                return;
            };
            var _local4:uint = Color.fromHealth(_local2);
            this.healthSlider.update(_local2, _local4);
            if (this.card){
                this.card.update();
            };
            var _local5:Boolean = _arg1.isNapping;
            this.zzz.visible = _local5;
            this.dead.visible = ((!(_local5)) && (!(this.isHealthy)));
            this.updateOverlay();
        }
        private function updateOverlay():void{
            var _local1:uint;
            if (!this.monster){
                return;
            };
            if (this.monster.isNapping){
                _local1 = NAPPING;
                this.overlay.blendMode = BlendMode.OVERLAY;
            } else {
                if (!this.isHealthy){
                    _local1 = RED;
                    this.overlay.blendMode = BlendMode.OVERLAY;
                } else {
                    if (this.isSelected){
                        _local1 = HIGHLIGHT;
                        this.overlay.blendMode = BlendMode.OVERLAY;
                    } else {
                        if (!this._isEnabled){
                            _local1 = LOCKED;
                            this.overlay.blendMode = BlendMode.MULTIPLY;
                        } else {
                            if (this.isOver){
                                _local1 = HIGHLIGHT;
                                this.overlay.blendMode = BlendMode.OVERLAY;
                            } else {
                                _local1 = SELECTABLE;
                                this.overlay.blendMode = BlendMode.ADD;
                            };
                        };
                    };
                };
            };
            this.overlayTint.update(_local1);
        }
        public function get clicked():Signal{
            return (this._clicked);
        }
        public function clear():void{
            if (((this.vo) && (this.vo.monster))){
                this.vo.monster.napping.remove(this.onNapping);
            };
            this.vo = null;
            if (!this.ui){
                return;
            };
            while (this.container.numChildren) {
                this.container.removeChildAt(0);
            };
            this.updateEventListeners();
            this.update();
        }
        public function set isEnabled(_arg1:Boolean):void{
            if (this._isEnabled == _arg1){
                return;
            };
            this._isEnabled = _arg1;
            this.updateEventListeners();
            this.updateOverlay();
            this.button.isEnabled = this._isEnabled;
        }
        public function get monster():MonsterModel{
            return ((this.vo) ? this.vo.monster : null);
        }
        public function select():void{
            if (this.isSelected){
                return;
            };
            this.isSelected = true;
            this.isOver = false;
            this.update();
        }
        public function deselect():void{
            if (!this.isSelected){
                return;
            };
            this.isSelected = false;
            this.update();
        }
        private function updateEventListeners():void{
            if (!this.button){
                return;
            };
            var _local1:Boolean = ((((this.vo) && (this.vo.monster))) && (this._isEnabled));
            this.button.isEnabled = _local1;
            if (this.ui.card){
                this.ui.card.mouseEnabled = false;
                this.ui.card.mouseChildren = false;
            };
            this.ui.mouseChildren = _local1;
            if (this.coffeeButton){
                this.coffeeButton.isEnabled = ((_local1) && (this.vo.monster.canNap));
            };
            if (_local1){
                this.ui.overlay.addEventListener(MouseEvent.CLICK, this.onClick);
                if (this.ui.info){
                    this.ui.info.addEventListener(MouseEvent.CLICK, this.onInfo);
                };
            } else {
                this.ui.overlay.removeEventListener(MouseEvent.CLICK, this.onClick);
                if (this.ui.info){
                    this.ui.info.removeEventListener(MouseEvent.CLICK, this.onInfo);
                };
            };
        }
        private function onCoffee(_arg1:MovieClipButton):void{
            this._coffee.dispatch(this);
        }
        private function onInfo(_arg1:MouseEvent):void{
            this._info.dispatch(this);
        }
        private function onClick(_arg1:MouseEvent):void{
            this._clicked.dispatch(this);
        }
        public function get info():Signal{
            return (this._info);
        }
        public function get coffee():Signal{
            return (this._coffee);
        }

    }
}//package com.gaiaonline.monster.view.components.smallteam 
