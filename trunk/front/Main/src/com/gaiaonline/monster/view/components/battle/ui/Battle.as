//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.ui {
    import flash.display.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.view.components.smallteam.*;
    import com.gaiaonline.monster.view.components.app.panel.*;
    import alecmce.ui.button.*;
    import com.gaiaonline.monster.view.components.battle.fight.*;
    import gaia.moga.assets.bundle.*;
    import gaia.moga.monster.model.actions.*;
    import gaia.moga.inventory.model.*;
    import com.gaiaonline.monster.service.vo.*;
    import com.gaiaonline.monster.view.components.recurringPrize.*;
    import com.gaiaonline.monster.view.components.battle.ui.items.*;
    import com.gaiaonline.monster.view.components.smallteam.anim.*;
    import gaia.moga.menu.view.ui.*;
    import gaia.moga.combatlog.view.ui.*;
    import com.gaiaonline.monster.view.components.top.*;
    import flash.filters.*;

    public class Battle extends Panel {

        private var bundle:BattleAssetsBundle;
        public var ui:Asset;
        private var prizeTimer:RecurringPrize;
        public var sound:Signal;
        public var circle:Signal;
        public var attack:Signal;
        public var callFriend:Signal;
        public var runAway:Signal;
        public var useItem:Signal;
        public var capture:Signal;
        public var physicalAttack:PhysicalAttackButton;
        public var zodiacAttack:ZodiacAttackButton;
        public var buffAttack:PhysicalAttackButton;
        public var bonusAttack:BonusAttackButton;
        public var circleButton:CircleButton;
        public var runButton:MovieClipButton;
        private var buttons:Vector.<MovieClipButton>;
        public var captureButton:CaptureButton;
        public var log:CombatLog;
        public var itemPicker:ItemPicker;
        public var portrait:BattleUIPortrait;
        public var fight:Fight;
        private var top:Top;
        public var friend:BattleUIFriend;
        private var choicePrompt:MovieClip;
        public var smallTeam:SmallTeam;
        public var npcTeam:NPCTeam;
        public var playerStatus:BattleUIStatus;
        public var npcStatus:BattleUIStatus;
        public var front:Sprite;
        private var _state:BattleViewState;
        private var _canCapture:int;
        private var _monster:MonsterModel;
        private var npcTeamContainer:Sprite;
        private var captureDialog:CaptureDialog;
        private var content:MovieClip;

        public static const BEGIN_BATTLE:String = "BEGIN_BATTLE";
        private static const SMALL_TEAM_X:uint = 132;
        private static const SMALL_TEAM_Y:uint = 45;

        public function Battle(_arg1:BattleAssetsBundle){
            this.sound = new Signal(String);
            this.circle = new Signal(BattleViewState);
            this.attack = new Signal(Action);
            this.callFriend = new Signal();
            this.runAway = new Signal();
            this.useItem = new Signal(InventoryItem);
            this.capture = new Signal(Boolean);
            this.bundle = _arg1;
        }
        override public function setup():void{
            this.ui = this.bundle.ui;
            addChild(this.ui.self);
            this.content = MovieClip(this.ui.content);
            this.log = new CombatLog(this.content.combatLog);
            this.itemPicker = new ItemPicker(this.content.inventoryButton);
            this.itemPicker.selected.add(this.onItemSelected);
            this.physicalAttack = new PhysicalAttackButton(this.content.physicalAttackButton);
            this.physicalAttack.clicked.add(this.onPhysicalAttack);
            this.zodiacAttack = new ZodiacAttackButton(this.content.zodiacAttackButton);
            this.zodiacAttack.clicked.add(this.onZodiacAttack);
            this.buffAttack = new PhysicalAttackButton(this.content.buffAttackButton);
            this.buffAttack.clicked.add(this.onCastBuffClicked);
            this.circleButton = new CircleButton(this.content.circleButton, this.bundle.blankButton);
            this.circleButton.clicked.add(this.onCircleButtonClicked);
            this.runButton = new MovieClipButton(this.content.runButton);
            this.runButton.clicked.add(this.onRunButtonClicked);
            this.bonusAttack = new BonusAttackButton(this.content.callButton);
            this.bonusAttack.clicked.add(this.onCallButton);
            this.portrait = new BattleUIPortrait(this.content.portrait);
            this.buttons = Vector.<MovieClipButton>([this.physicalAttack, this.zodiacAttack, this.buffAttack, this.runButton]);
            this.playerStatus = new BattleUIStatus(this.content.playerStatus);
            this.npcStatus = new BattleUIStatus(this.content.npcStatus);
            addChild((this.top = new Top(this.bundle.top)));
            addChild((this.prizeTimer = new RecurringPrize(this.bundle.prizeTimer)));
            this.smallTeam = new SmallTeam(this.bundle.team);
            this.smallTeam.x = SMALL_TEAM_X;
            this.smallTeam.y = SMALL_TEAM_Y;
            this.content.smallTeamContainer.addChild(this.smallTeam);
            addChild((this.npcTeamContainer = new Sprite()));
            this.choicePrompt = this.content.choicePrompt;
            this.choicePrompt.label.text = this.bundle.choicePromptText;
            this.choicePrompt.visible = false;
            this.fight = new Fight();
            this.fight.background = this.bundle.background;
            this.content.fight.addChild(this.fight);
            addChild(this.fight.playerAbove);
            addChild(this.fight.npcAbove);
            if (this.bundle.overlay){
                this.fight.addOverlay(this.bundle.overlay);
            };
            addChild((this.front = new Sprite()));
            this.friend = new BattleUIFriend(this.bundle.friendTab, this.front);
            this.captureButton = new CaptureButton(this.bundle.captureButton);
            this.captureDialog = new CaptureDialog(this.bundle.captureDialog, this.front);
            var _local1:Menu = new Menu(this.bundle.menu);
            _local1.setup(Vector.<String>([Menu.DEX, Menu.QUEST, Menu.COLLECTIONS]));
            addChild(_local1);
            this.state = BattleViewState.BLANK;
        }
        override public function dispose(_arg1:Boolean=true):void{
            if (!this.bundle){
                return;
            };
            this.itemPicker.selected.remove(this.onItemSelected);
            this.physicalAttack.clicked.remove(this.onPhysicalAttack);
            this.zodiacAttack.clicked.remove(this.onZodiacAttack);
            this.buffAttack.clicked.remove(this.onCastBuffClicked);
            this.circleButton.clicked.remove(this.onCircleButtonClicked);
            this.bundle.dispose(_arg1);
            this.bundle = null;
            this.fight.dispose(_arg1);
            this.fight = null;
            this.captureButton.dispose(_arg1);
        }
        public function get monster():MonsterModel{
            return (this._monster);
        }
        public function set monster(_arg1:MonsterModel):void{
            if (this._monster == _arg1){
                return;
            };
            this._monster = _arg1;
            if (!this._monster){
                return;
            };
            this.physicalAttack.attack = _arg1.actions.physicalAttack;
            this.zodiacAttack.attack = _arg1.actions.zodiacAttack;
            this.buffAttack.attack = _arg1.actions.buffAttack;
            this.smallTeam.fighting = _arg1;
        }
        public function addNPCTeam():void{
            this.npcTeam = new NPCTeam(this.bundle.npc);
            this.npcTeamContainer.addChild(this.npcTeam);
        }
        public function set items(_arg1:Vector.<InventoryItem>):void{
            this.itemPicker.items = _arg1;
        }
        public function addItem(_arg1:InventoryItem):void{
            this.itemPicker.addItem(_arg1);
        }
        public function set whistles(_arg1:InventoryItem):void{
            this.bonusAttack.item = _arg1;
        }
        public function get state():BattleViewState{
            return (this._state);
        }
        public function set state(_arg1:BattleViewState):void{
            if (this._state == _arg1){
                return;
            };
            this._state = _arg1;
            this.update();
        }
        public function get canCapture():int{
            return (this._canCapture);
        }
        public function set canCapture(_arg1:int):void{
            if (this._canCapture == _arg1){
                return;
            };
            this._canCapture = _arg1;
            this.update();
        }
        public function set zodiacIcon(_arg1:Asset):void{
            var _local2:DisplayObject = _arg1.self;
            _local2.scaleX = (_local2.scaleY = 0.3);
            _local2.filters = [new GlowFilter(0, 1, 2, 2, 1000)];
            this.zodiacAttack.icon = _arg1;
        }
        public function set buffIcon(_arg1:Asset):void{
            var _local2:DisplayObject = _arg1.self;
            _local2.x = -13;
            _local2.y = -12;
            this.buffAttack.icon = _arg1;
        }
        private function update():void{
            switch (this._state){
                case BattleViewState.BEFORE_BATTLE_STARTS:
                    if (this._monster){
                        this.beforeBattleStarts();
                    } else {
                        this.chooseNextMonster();
                    };
                    break;
                case BattleViewState.PENDING:
                    this.pending();
                    break;
                case BattleViewState.CHOOSE_NEXT_MONSTER:
                    this.chooseNextMonster();
                    break;
                case BattleViewState.BLANK:
                    this.blank();
                    break;
                case BattleViewState.PLAYER_TURN:
                    this.playerTurn(this._canCapture);
                    break;
                case BattleViewState.PLAYER_ANIM:
                    this.playerAnim();
                    break;
                case BattleViewState.ENEMY_TURN:
                    this.enemyTurn();
                    break;
            };
        }
        private function beforeBattleStarts():void{
            this.disableButtons();
            this.circleButton.showButton(this.bundle.goButton, true);
            this.choicePrompt.visible = false;
            this.smallTeam.isEnabled = true;
        }
        private function pending():void{
            this.disableButtons();
            this.circleButton.showButton(this.bundle.blankButton, false);
            this.choicePrompt.visible = false;
            this.smallTeam.isEnabled = false;
        }
        private function chooseNextMonster():void{
            this.hideButtons();
            this.circleButton.showButton(this.bundle.blankButton, false);
            this.choicePrompt.visible = true;
            this.smallTeam.isEnabled = true;
        }
        private function blank():void{
            this.hideButtons();
            this.circleButton.showButton(this.bundle.blankButton, false);
            this.choicePrompt.visible = false;
            this.smallTeam.isEnabled = false;
        }
        private function playerTurn(_arg1:int, _arg2:Boolean=true):void{
            if (_arg2){
                this.enableButtons();
            };
            this.choicePrompt.visible = false;
            if (((this._canCapture) && (_arg2))){
                this.circleButton.showButton(this.captureButton, true);
                this.captureButton.percentage = _arg1;
            } else {
                this.circleButton.showButton(this.bundle.playerTurnButton, false);
            };
        }
        private function playerAnim():void{
            this.disableButtons();
            this.circleButton.showButton(this.bundle.playerTurnButton, false);
            this.choicePrompt.visible = false;
        }
        private function enemyTurn():void{
            this.disableButtons();
            this.choicePrompt.visible = false;
            this.circleButton.showButton(this.bundle.enemyTurnButton, false);
        }
        private function enableButtons():void{
            var _local1:MovieClipButton;
            for each (_local1 in this.buttons) {
                _local1.isVisible = true;
                _local1.isEnabled = true;
            };
            this.bonusAttack.isVisible = true;
            this.bonusAttack.isEnabled = true;
            this.itemPicker.isVisible = true;
            this.itemPicker.isEnabled = true;
            this.smallTeam.isEnabled = true;
        }
        private function disableButtons():void{
            var _local1:MovieClipButton;
            for each (_local1 in this.buttons) {
                _local1.isVisible = true;
                _local1.isEnabled = false;
            };
            this.bonusAttack.isVisible = true;
            this.bonusAttack.isEnabled = false;
            this.itemPicker.isVisible = true;
            this.itemPicker.isEnabled = false;
        }
        public function hideButtons():void{
            var _local1:MovieClipButton;
            for each (_local1 in this.buttons) {
                _local1.isVisible = false;
                _local1.isEnabled = false;
            };
            this.bonusAttack.isVisible = false;
            this.bonusAttack.isEnabled = false;
            this.itemPicker.isVisible = false;
            this.itemPicker.isEnabled = false;
        }
        private function onPhysicalAttack(_arg1:MovieClipButton):void{
            this.attack.dispatch(this.physicalAttack.attack);
            this.disableButtons();
        }
        private function onZodiacAttack(_arg1:MovieClipButton):void{
            this.attack.dispatch(this.zodiacAttack.attack);
            this.disableButtons();
        }
        private function onCastBuffClicked(_arg1:MovieClipButton):void{
            this.attack.dispatch(this.buffAttack.attack);
            this.disableButtons();
        }
        private function onItemSelected(_arg1:InventoryItem):void{
            this.useItem.dispatch(_arg1);
        }
        private function onCircleButtonClicked():void{
            this.circle.dispatch(this._state);
        }
        private function onRunButtonClicked(_arg1:MovieClipButton):void{
            this.runAway.dispatch();
        }
        private function onCallButton(_arg1:MovieClipButton):void{
            this.callFriend.dispatch();
        }
        public function showCaptureDialog(_arg1:uint, _arg2:int, _arg3:String, _arg4:Boolean=true):void{
            this.captureDialog.response.addOnce(this.onCaptureResponse);
            this.captureDialog.show(_arg1, _arg2, _arg3, _arg4);
        }
        public function updateAttackHints(_arg1:AttackHintsVO):void{
            this.physicalAttack.setHint(_arg1.physicalTitle, _arg1.physicalMain, _arg1.physicalOut, _arg1.physicalCritChance);
            this.zodiacAttack.setHint(_arg1.playerZodiacIcon, _arg1.npcZodiacIcon, _arg1.zodiacTitle, _arg1.zodiacMain, _arg1.zodiacMod, _arg1.zodiacOut, _arg1.zodiacCritChance, _arg1.zodiacProcIcon, _arg1.zodiacProcChance);
            this.bonusAttack.setHint(_arg1.bonusTitle, _arg1.bonusMain, _arg1.bonusOut);
            this.buffAttack.setHint(_arg1.buffTitle, _arg1.buffMain, _arg1.buffOut);
        }
        private function onCaptureResponse(_arg1:Boolean):void{
            this.capture.dispatch(_arg1);
        }
        public function setQuality(_arg1:int):void{
            this.fight.setQuality(_arg1);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.ui 
