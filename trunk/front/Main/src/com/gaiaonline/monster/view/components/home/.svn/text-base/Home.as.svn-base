//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.home {
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.view.components.smallteam.*;
    import gaia.moga.friendlist.view.ui.*;
    import com.gaiaonline.monster.view.components.app.panel.*;
    import com.gaiaonline.monster.view.components.battle.fight.*;
    import org.osflash.signals.natives.*;
    import flash.geom.*;
    import gaia.moga.assets.bundle.*;
    import com.gaiaonline.monster.view.components.starseedBasket.view.ui.*;
    import gaia.moga.whistletree.view.ui.*;
    import com.gaiaonline.monster.view.components.recurringPrize.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.monster.*;
    import gaia.moga.autoHarvester.view.*;
    import gaia.moga.menu.view.ui.*;
    import com.gaiaonline.monster.view.components.top.*;

    public class Home extends Panel {

        private const HEIGHT:uint = 425;

        private var bundle:HomeAssetsBundle;
        private var hitLayer:MovieClip;
        private var mainContainer:Sprite;
        private var overlayContainer:Sprite;
        private var aboveContainer:Sprite;
        private var cardContainer:Sprite;
        private var treePanelContainer:Sprite;
        private var _monsterMap:Dictionary;
        private var _monsterModelMap:Dictionary;
        private var _idMonsterMap:Dictionary;
        private var _animMonsterMap:Dictionary;
        private var _rechargeMonster:Signal;
        private var _smallTeam:SmallTeam;
        private var _highlightedMonster:HomeMonster;
        private var _monsterCardAsset:Asset;
        private var _monsterCard:MonsterCard;
        private var _isFriendRanch:Boolean;
        private var _friends:FriendList;
        private var _depthSorter:DepthSorter;
        private var _clickBox:Sprite;
        private var _decorations:Vector.<Asset>;
        private var _whistleTree:WhistleTree;
        private var _starseedBasket:StarseedBasket;
        private var _onHomeTreeRollover:NativeSignal;
        private var _onHomeTreeRollout:NativeSignal;
        private var _onHomeTreeClick:NativeSignal;
        private var _onHomeTreeReady:Signal;
        private var _house:AssetBase;
        private var _door:MovieClip;
        private var _lock:MovieClip;
        private var _onMogaHouseDrop:Signal;
        private var _storage:MogaStorage;
        private var _showStorageLock:Boolean;// = true
        private var _countClip:MovieClip;
        private var _mogaStorageCount:uint;// = 0
        private var quality:int;
        private var menu:Menu;

        private static const WIDTH:uint = 760;
        private static const SMALL_TEAM_Y:int = 515;

        public function Home(_arg1:HomeAssetsBundle, _arg2:Boolean){
            this.bundle = _arg1;
            this._isFriendRanch = _arg2;
            this._monsterCardAsset = _arg1.card;
            this._monsterMap = new Dictionary(true);
            this._monsterModelMap = new Dictionary(true);
            this._idMonsterMap = new Dictionary(true);
            this._animMonsterMap = new Dictionary(true);
            this._rechargeMonster = new Signal();
            this._onHomeTreeReady = new Signal();
            this._onMogaHouseDrop = new Signal();
            this._decorations = new Vector.<Asset>();
            this.overlayContainer = new Sprite();
            this.mainContainer = new Sprite();
            this.aboveContainer = new Sprite();
        }
        public function get onHomeTreeRollover():NativeSignal{
            return (this._onHomeTreeRollover);
        }
        public function get onHomeTreeRollout():NativeSignal{
            return (this._onHomeTreeRollout);
        }
        public function get onHomeTreeClick():NativeSignal{
            return (this._onHomeTreeClick);
        }
        public function get onHomeTreeReady():Signal{
            return (this._onHomeTreeReady);
        }
        public function get onMogaHouseDrop():Signal{
            return (this._onMogaHouseDrop);
        }
        override public function setup():void{
            var _local2:Vector.<String>;
            var _local1:Asset = this.bundle.background;
            if (_local1.isComplete){
                this.onBackgroundReady(_local1);
            } else {
                _local1.complete.addOnce(this.onBackgroundReady);
            };
            addChild(this.mainContainer);
            addChild(this.overlayContainer);
            this.overlayContainer.mouseEnabled = false;
            this.overlayContainer.mouseChildren = false;
            this.setQuality(this.quality);
            addChild(this.aboveContainer);
            this._smallTeam = this.createSmallTeam();
            addChild(this._smallTeam);
            _local2 = Vector.<String>([Menu.TRAVEL, Menu.DEX, Menu.QUEST, Menu.COLLECTIONS]);
            addChild(new Top(this.bundle.top));
            addChild((this.menu = new Menu(this.bundle.menu)));
            this.menu.setup(_local2);
            addChild(new RecurringPrize(this.bundle.prizeTimer));
            this._friends = this.bundle.friends;
            this._friends.isAtHome = !(this._isFriendRanch);
            addChild(this._friends);
            addChild((this.cardContainer = new Sprite()));
            addChild((this.treePanelContainer = new Sprite()));
            this._depthSorter = new DepthSorter(this.mainContainer);
            this._clickBox = this.addClickBox();
            this.mainContainer.addChildAt(this._clickBox, 0);
            this.enableHitBox();
            this.addAllMonstersToMain();
            this.addAllDecorationsToMain();
            if (this._whistleTree){
                this.mainContainer.addChild(this._whistleTree);
            };
            if (this.bundle.whistleTreePanel){
                this.treePanelContainer.addChild(this.bundle.whistleTreePanel.self);
            };
        }
        private function createSmallTeam():SmallTeam{
            var _local1:SmallTeam = new SmallTeam(this.bundle.team);
            _local1.x = (WIDTH * 0.5);
            _local1.y = SMALL_TEAM_Y;
            return (_local1);
        }
        private function onBackgroundReady(_arg1:Asset):void{
            addChild(_arg1.self);
            this.hitLayer = MovieClip(_arg1.content).hitLayer;
            this.hitLayer.alpha = 0;
        }
        public function set limitWalkArea(_arg1:Boolean):void{
            this.hitLayer.gotoAndStop((_arg1) ? 2 : 1);
        }
        public function get rechargeMonster():Signal{
            return (this._rechargeMonster);
        }
        public function checkMogaCount():void{
        }
        public function addMonster(_arg1:FightMonster, _arg2:MonsterModel):HomeMonster{
            var _local3:HomeMonster;
            if (this._idMonsterMap[_arg2.id] == null){
                _local3 = new HomeMonster(_arg1, this.hitLayer);
                this._monsterMap[_local3] = _arg1;
                this._monsterMap[_arg1] = _local3;
                this._monsterModelMap[_local3] = _arg2;
                this._idMonsterMap[_arg2.id] = _local3;
            } else {
                _local3 = this._idMonsterMap[_arg2.id];
            };
            if (this.mainContainer){
                this.addMonsterToMain(_local3);
            };
            return (_local3);
        }
        public function addAllMonstersToMain():void{
            var _local1:*;
            for each (_local1 in this._monsterMap) {
                if ((_local1 is HomeMonster)){
                    this.addMonsterToMain(_local1);
                };
            };
        }
        private function addMonsterToMain(_arg1:HomeMonster):void{
            _arg1.monsterClicked.remove(this.onMonsterClicked);
            this.mainContainer.addChild(_arg1);
            _arg1.monsterClicked.add(this.onMonsterClicked);
        }
        public function setWhistleTree(_arg1:Point):void{
            var _local2:Asset = this.bundle.whistleTree;
            var _local3:Asset = this.bundle.whistleTreePanel;
            var _local4:DisplayObject = _local3.self;
            _local4.x = _arg1.x;
            _local4.y = _arg1.y;
            _local4.visible = false;
            this._whistleTree = new WhistleTree(_local2, _local3);
            this._whistleTree.x = _arg1.x;
            this._whistleTree.y = _arg1.y;
            if (this._whistleTree){
                this.mainContainer.addChild(this._whistleTree);
            };
            if (_local4){
                this.treePanelContainer.addChild(this.bundle.whistleTreePanel.self);
            };
        }
        public function setStarseedBasket(_arg1:Point):void{
            var _local2:Asset = this.bundle.starseedBasket;
            this._starseedBasket = new StarseedBasket(_local2);
            this._starseedBasket.x = _arg1.x;
            this._starseedBasket.y = _arg1.y;
            this.mainContainer.addChild(this._starseedBasket);
        }
        public function addDecoration(_arg1:Asset, _arg2:DecorationVO):void{
            this._decorations.push(_arg1);
            var _local3:Sprite = Sprite(_arg1.self);
            _local3.mouseChildren = (_arg2.type == "house");
            _local3.mouseEnabled = (_arg2.type == "house");
            _local3.x = _arg2.position.x;
            _local3.y = _arg2.position.y;
            if (this.mainContainer){
                this.mainContainer.addChild(_local3);
            };
            if (_arg2.type == "house"){
                this._house = (_arg1 as AssetBase);
                if (_arg1.isComplete){
                    this.onHouseReady((_arg1 as AssetBase));
                } else {
                    _arg1.complete.addOnce(this.onHouseReady);
                };
            };
        }
        public function highlightHouse(_arg1:Boolean):void{
            if (_arg1){
                this._door.gotoAndPlay("open");
            } else {
                this._door.gotoAndPlay("close");
            };
        }
        public function set showStorageLock(_arg1:Boolean):void{
            if (this._lock){
                this._lock.visible = _arg1;
            };
            this._showStorageLock = _arg1;
        }
        private function onHouseReady(_arg1:AssetBase):void{
            this._door = _arg1.content["door"];
            this._door.useHandCursor = true;
            this._door.buttonMode = true;
            this._door.mouseChildren = false;
            this._lock = _arg1.content["lock"];
            this._lock.useHandCursor = true;
            this._lock.buttonMode = true;
            this._lock.mouseChildren = false;
            this.showStorageLock = this._showStorageLock;
            this._countClip = _arg1.content["count"];
            this.mogaStorageCount = this._mogaStorageCount;
            this._onHomeTreeClick = new NativeSignal(this._door, MouseEvent.CLICK);
            this._onHomeTreeRollout = new NativeSignal(this._door, MouseEvent.ROLL_OUT);
            this._onHomeTreeRollover = new NativeSignal(this._door, MouseEvent.ROLL_OVER);
            this._onHomeTreeReady.dispatch(_arg1);
        }
        public function set mogaStorageCount(_arg1:uint):void{
            if (this._countClip){
                this._countClip.visible = (_arg1 > 0);
                this._countClip.field.text = _arg1.toString();
            };
            this._mogaStorageCount = _arg1;
        }
        private function addAllDecorationsToMain():void{
            var _local1:Asset;
            for each (_local1 in this._decorations) {
                this.mainContainer.addChild(_local1.self);
            };
        }
        private function onMonsterClicked(_arg1:MouseEvent):void{
            var _local2:HomeMonster = (_arg1.currentTarget as HomeMonster);
            if (_local2.parent){
                if (this._highlightedMonster){
                    this.enableHighlightedMonster();
                };
                if (this._monsterCard){
                    this._monsterCard.dispose();
                };
                this._highlightedMonster = _local2;
                this.showMonsterCard();
            };
        }
        private function enableHitBox():void{
            this._clickBox.addEventListener(MouseEvent.CLICK, this.onClickHitBox, false, 0, true);
        }
        public function showMonsterCard():void{
            if (!this._highlightedMonster){
                return;
            };
            var _local1:Point = new Point(this._highlightedMonster.x, this._highlightedMonster.y);
            var _local2:Boolean = this._isFriendRanch;
            this._highlightedMonster.removeMessaging();
            if (!this._monsterCard){
                this._monsterCard = new MonsterCard(this._monsterCardAsset, _local2);
            };
            this._monsterCard.x = _local1.x;
            this._monsterCard.y = _local1.y;
            this._highlightedMonster.monsterClicked.remove(this.onMonsterClicked);
            this.cardContainer.addChild(this._monsterCard);
            this._monsterCard.init(this._monsterModelMap[this._highlightedMonster]);
        }
        public function dropMonster(_arg1:HomeMonster):void{
            var _local2:MonsterModel = this._monsterModelMap[_arg1];
            var _local3:DisplayObject = (this._house.content["door"] as DisplayObject);
            this.addMonsterToMain(_arg1);
            if (((!(this._isFriendRanch)) && (_local3.hitTestObject(_arg1)))){
                this._onMogaHouseDrop.dispatch(_local2);
            } else {
                this.showMonsterCard();
            };
        }
        public function removeMonsterFromRanch(_arg1:MonsterModel):void{
            var _local4:*;
            var _local2:HomeMonster = this._idMonsterMap[_arg1.id];
            var _local3:FightMonster = this._monsterMap[_local2];
            if (this._highlightedMonster == _local2){
                this._highlightedMonster = null;
            };
            if (((_local2) && (_local2.parent))){
                _local2.parent.removeChild(_local2);
            };
            this.removeMonsterCard();
            for (_local4 in this._animMonsterMap) {
                if (this._animMonsterMap[_local4] == this._idMonsterMap[_arg1.id]){
                    delete this._animMonsterMap[_local4];
                    MonsterAnim(_local4).complete.remove(this.onRechargeAnimComplete);
                    break;
                };
            };
            delete this._idMonsterMap[_arg1.id];
            delete this._monsterModelMap[_local2];
            delete this._monsterMap[_local2];
            delete this._monsterMap[_local3];
        }
        private function onClickHitBox(_arg1:MouseEvent):void{
            if (this._highlightedMonster){
                this.enableHighlightedMonster();
                this.onRemoveMonsterCard();
            } else {
                this.swarmMonsters();
            };
        }
        private function onRemoveMonsterCard(_arg1=null):void{
            if (this._monsterCard){
                this._monsterCard.dispose();
            };
            if (((this._monsterCard) && (this.cardContainer.contains(this._monsterCard)))){
                this.cardContainer.removeChild(this._monsterCard);
            };
        }
        private function enableHighlightedMonster():void{
            this._highlightedMonster.filters = null;
            this._highlightedMonster.monsterClicked.add(this.onMonsterClicked);
            this._highlightedMonster.scaleX = 1;
            this._highlightedMonster.scaleY = 1;
            this._highlightedMonster.resume();
            this.mainContainer.addChild(this._highlightedMonster);
            this._highlightedMonster = null;
        }
        public function elevateMonsterStatus(_arg1:HomeMonster):void{
            if (_arg1.parent == this.mainContainer){
                this.aboveContainer.addChild(_arg1);
            };
        }
        public function lowerMonsterStatus(_arg1:HomeMonster):void{
            this.mainContainer.addChild(_arg1);
        }
        private function addClickBox():Sprite{
            var _local1:Sprite = new Sprite();
            _local1.graphics.lineStyle(1, 0xFF00, 0);
            _local1.graphics.beginFill(0, 0);
            _local1.graphics.drawRect(0, 0, 660, 760);
            _local1.graphics.endFill();
            return (_local1);
        }
        public function setInNap(_arg1:MonsterModel, _arg2:Asset, _arg3:int):void{
            var _local4:HomeMonster = this._idMonsterMap[_arg1.id];
            var _local5:int = (_arg1.napEndTime - _arg3);
            var _local6:NapTimer = new NapTimer(_local5, _arg1);
            _local4.setInNap(_arg2, _local6, _arg1.napTime, _arg1.napEndTime, _arg3);
            _local4.scaleX = ((_local4.scaleX)<0) ? _local4.scaleX = -1 : _local4.scaleX = 1;
            _local4.scaleY = 1;
            this.onRemoveMonsterCard();
            if (this._highlightedMonster){
                this.enableHighlightedMonster();
            };
        }
        public function awakenMonster(_arg1:MonsterModel):void{
            var _local2:HomeMonster = this._idMonsterMap[_arg1.id];
            _local2.scaleX = ((_local2.scaleX)<0) ? _local2.scaleX = -1 : _local2.scaleX = 1;
            _local2.scaleY = 1;
            _local2.resumeAfterNap();
            this.onRemoveMonsterCard();
            if (this._highlightedMonster){
                this.enableHighlightedMonster();
            };
        }
        public function playRechargeAnim(_arg1:Asset, _arg2:String, _arg3:Boolean, _arg4:Asset):void{
            var _local5:MonsterAnim = new MonsterAnim(this._idMonsterMap[_arg2], _arg1, this._idMonsterMap[_arg2].fightMonster);
            _local5.play();
            this._animMonsterMap[_local5] = this._idMonsterMap[_arg2];
            this.onRemoveMonsterCard();
            this._idMonsterMap[_arg2].resume();
            this._idMonsterMap[_arg2].scaleX = ((this._idMonsterMap[_arg2].scaleX)<0) ? this._idMonsterMap[_arg2].scaleX = -1 : this._idMonsterMap[_arg2].scaleX = 1;
            this._idMonsterMap[_arg2].scaleY = 1;
            if (this._highlightedMonster){
                this.enableHighlightedMonster();
            };
            if (_arg3){
                _local5.complete.addOnce(this.onRechargeAnimComplete);
            };
            this._idMonsterMap[_arg2].removeMessaging();
        }
        private function onRechargeAnimComplete(_arg1:MonsterAnim):void{
            var _local2:HomeMonster = this._animMonsterMap[_arg1];
            this.awakenMonster(this._monsterModelMap[_local2]);
        }
        public function removeMonsterCard():void{
            this.onRemoveMonsterCard();
        }
        public function hideSmallTeam():void{
            if (this._smallTeam){
                this._smallTeam.visible = false;
            };
        }
        private function swarmMonsters():void{
            var _local1:HomeMonster;
            for each (_local1 in this._idMonsterMap) {
                _local1.swarmTo(new Point(stage.mouseX, stage.mouseY));
            };
        }
        public function addAutoHarvester(_arg1:AutoHarvester):void{
            this.aboveContainer.addChild(_arg1);
        }
        override public function dispose(_arg1:Boolean=true):void{
            var _local2:*;
            var _local3:Asset;
            if (!this.bundle){
                return;
            };
            this.bundle.dispose(_arg1);
            this.bundle = null;
            this.hitLayer = null;
            var _local4:int = this._decorations.length;
            while (_local4--) {
                _local3 = this._decorations[_local4];
                this.mainContainer.removeChild(_local3.self);
                _local3.dispose(_arg1);
            };
            this._decorations.length = 0;
            this._depthSorter.dispose(_arg1);
            this._depthSorter = null;
            this._highlightedMonster = null;
            if (this._monsterCard){
                this._monsterCard.dispose(_arg1);
            };
            this._monsterCard = null;
            for (_local2 in this._monsterMap) {
                if ((this._monsterMap[_local2] is HomeMonster)){
                    HomeMonster(this._monsterMap[_local2]).dispose(_arg1);
                };
                delete this._monsterMap[_local2];
            };
            this._monsterMap = null;
            for (_local2 in this._monsterModelMap) {
                delete this._monsterModelMap[_local2];
            };
            this._monsterModelMap = null;
            for (_local2 in this._idMonsterMap) {
                delete this._idMonsterMap[_local2];
            };
            this._idMonsterMap = null;
            this.bundle = null;
            removeChild(this.mainContainer);
            this.mainContainer = null;
            this._onHomeTreeClick.removeAll();
            this._onHomeTreeClick = null;
            this._onHomeTreeReady.removeAll();
            this._onHomeTreeReady = null;
            this._onHomeTreeRollout.removeAll();
            this._onHomeTreeRollout = null;
            this._onHomeTreeRollover.removeAll();
            this._onHomeTreeRollover = null;
            this._onMogaHouseDrop.removeAll();
            this._onMogaHouseDrop = null;
            this._rechargeMonster.removeAll();
            this._rechargeMonster = null;
        }
        public function setQuality(_arg1:int):void{
            this.quality = _arg1;
            if (((!(this.bundle.overlay)) || (!(this.overlayContainer)))){
                return;
            };
            var _local2:DisplayObject = this.bundle.overlay.self;
            if (_arg1 == 4){
                this.overlayContainer.addChild(_local2);
            } else {
                if (_local2.parent == this.overlayContainer){
                    this.overlayContainer.removeChild(_local2);
                };
            };
        }

    }
}//package com.gaiaonline.monster.view.components.home 
