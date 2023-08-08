//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight {
    import flash.display.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.view.components.battle.background.*;

    public class Fight extends Sprite {

        private var backgroundContainer:DisplayObjectContainer;
        private var middlegroundContainer:DisplayObjectContainer;
        public var playerContainer:MonsterContainer;
        public var npcContainer:MonsterContainer;
        public var above:DisplayObjectContainer;
        private var foregroundContainer:DisplayObjectContainer;
        private var overlayContainer:DisplayObjectContainer;
        private var _background:Background;
        private var _player:FightMonster;
        private var _oldPlayer:FightMonster;
        private var _npc:FightMonster;
        private var _oldNPC:FightMonster;
        public var parallax:BackgroundScroll;
        public var shocker:BackgroundShock;
        public var playerAbove:Sprite;
        public var npcAbove:Sprite;
        private var promotionIndex:int;
        private var quality:int;
        private var overlay:Asset;

        public static const PLAYER_POSITION_X:int = 198;
        public static const PLAYER_POSITION_Y:int = 412;
        public static const NPC_POSITION_X:int = 562;
        public static const NPC_POSITION_Y:int = 412;

        public function Fight(){
            addChild((this.backgroundContainer = new Sprite()));
            addChild((this.middlegroundContainer = new Sprite()));
            addChild((this.playerContainer = new MonsterContainer()));
            addChild((this.npcContainer = new MonsterContainer()));
            addChild((this.above = new MonsterContainer()));
            addChild((this.foregroundContainer = new Sprite()));
            addChild((this.overlayContainer = new Sprite()));
            this.overlayContainer.mouseEnabled = false;
            this.overlayContainer.mouseChildren = false;
            this.promotionIndex = this.getChildIndex(this.npcContainer);
            this.playerContainer.x = PLAYER_POSITION_X;
            this.playerContainer.y = PLAYER_POSITION_Y;
            this.npcContainer.x = NPC_POSITION_X;
            this.npcContainer.y = NPC_POSITION_Y;
            this.npcContainer.scaleX = -1;
            this.playerAbove = new Sprite();
            this.playerAbove.x = PLAYER_POSITION_X;
            this.playerAbove.y = PLAYER_POSITION_Y;
            this.npcAbove = new Sprite();
            this.npcAbove.x = NPC_POSITION_X;
            this.npcAbove.y = NPC_POSITION_Y;
            this.generateShock();
            this.generateScroll();
        }
        private function generateShock():void{
            this.shocker = new BackgroundShock();
            this.shocker.addLayer(this.backgroundContainer, 11);
            this.shocker.addLayer(this.middlegroundContainer, 22);
            this.shocker.addLayer(this.foregroundContainer, 44);
        }
        private function generateScroll():void{
            this.parallax = new BackgroundScroll();
            this.parallax.addLayer(new BackgroundScrollLayer(this.backgroundContainer, 0, 0, true));
            this.parallax.addLayer(new BackgroundScrollLayer(this.middlegroundContainer, 0, 0, true));
            this.parallax.addLayer(new BackgroundScrollLayer(this.foregroundContainer, 0, 0, true));
        }
        public function dispose(_arg1:Boolean=true):void{
            if (this._npc){
                if (this._npc.parent){
                    this._npc.parent.removeChild(this._npc);
                };
                this._npc = null;
            };
            if (this._player){
                if (this._player.parent){
                    this._player.parent.removeChild(this._player);
                };
                this._player = null;
            };
            this.background = null;
        }
        public function set background(_arg1:Background):void{
            var _local2:DisplayObject;
            if (this._background == _arg1){
                return;
            };
            if (this._background){
                _local2 = (this._background.bg) ? this._background.bg.self : null;
                if (((_local2) && ((_local2.parent == this.backgroundContainer)))){
                    this.backgroundContainer.removeChild(_local2);
                };
                _local2 = (this._background.mg) ? this._background.mg.self : null;
                if (((_local2) && ((this._background.mg.self.parent == this.middlegroundContainer)))){
                    this.middlegroundContainer.removeChild(this._background.mg.self);
                };
                _local2 = (this._background.fg) ? this._background.fg.self : null;
                if (((_local2) && ((_local2.parent == this.foregroundContainer)))){
                    this.foregroundContainer.removeChild(_local2);
                };
            };
            this._background = _arg1;
            if (this._background){
                _local2 = (this._background.bg) ? this._background.bg.self : null;
                if (_local2){
                    this.backgroundContainer.addChild(_local2);
                };
                _local2 = (this._background.mg) ? this._background.mg.self : null;
                if (_local2){
                    this.middlegroundContainer.addChild(this._background.mg.self);
                };
                _local2 = (this._background.fg) ? this._background.fg.self : null;
                if (_local2){
                    this.foregroundContainer.addChild(_local2);
                };
            };
        }
        public function set player(_arg1:FightMonster):void{
            this._player = _arg1;
            this._oldPlayer = this.playerContainer.setMonster(_arg1);
        }
        public function get player():FightMonster{
            return (this._player);
        }
        public function set npc(_arg1:FightMonster):void{
            this._npc = _arg1;
            this._oldNPC = this.npcContainer.setMonster(_arg1);
        }
        public function get npc():FightMonster{
            return (this._npc);
        }
        public function get oldPlayer():FightMonster{
            return (this._oldPlayer);
        }
        public function get oldNPC():FightMonster{
            return (this._oldNPC);
        }
        public function get background():Background{
            return (this._background);
        }
        public function promote(_arg1:MonsterContainer):void{
            setChildIndex(_arg1, this.promotionIndex);
        }
        public function addOverlay(_arg1:Asset):void{
            this.overlay = _arg1;
            if (this.quality != -1){
                this.setQuality(this.quality);
            };
        }
        public function setQuality(_arg1:int):void{
            this.quality = _arg1;
            if (((!(this.overlay)) || (!(this.overlayContainer)))){
                return;
            };
            var _local2:DisplayObject = this.overlay.self;
            if (_arg1 == 4){
                this.overlayContainer.addChild(_local2);
            } else {
                if (_local2.parent == this.overlayContainer){
                    this.overlayContainer.removeChild(_local2);
                };
            };
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight 
