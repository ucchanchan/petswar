//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import com.gaiaonline.monster.model.vo.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.model.world.*;
    import gaia.moga.friendlist.model.*;
    import gaia.moga.story.view.ui.*;
    import com.gaiaonline.monster.service.sound.*;
    import gaia.moga.collections.service.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.view.components.battle.fight.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import gaia.moga.assets.bundle.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.attack.*;
    import com.gaiaonline.monster.view.components.battle.vo.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.capture.*;
    import gaia.moga.monster.model.actions.*;
    import alecmce.services.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.inventory.model.*;
    import com.gaiaonline.monster.model.battle.*;
    import com.gaiaonline.monster.model.quests.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.controller.async.*;
    import com.gaiaonline.monster.model.tracking.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.*;

    public class FightMediator extends Mediator {

		[Inject]
        public var model:BattleModel;
		[Inject]
        public var world:WorldModel;
		[Inject]
        public var view:Fight;
		[Inject]
        public var factory:BattleAnimFactory;
		[Inject]
        public var assets:AssetService;
		[Inject]
        public var text:TextService;
		[Inject]
        public var monsters:MonsterAssetsFactory;
		[Inject]
        public var application:ApplicationMediator;
		[Inject]
        public var ticker:Ticker;
		[Inject]
        public var roster:HomeRanchModel;
		[Inject]
        public var playerModel:PlayerModel;
		[Inject]
        public var fb:FBService;
		[Inject]
        public var inventory:InventoryModel;
		[Inject]
        public var anims:AsyncService;
		[Inject]
        public var sounds:SoundService;
		[Inject]
        public var music:MusicService;
		[Inject]
        public var quests:QuestModel;
		[Inject]
        public var story:StoryModel;
		[Inject]
        public var collectionData:CollectionDataProcess;
        private var tryCaptureAsset:Asset;
        private var charging:MonsterChargeAnim;

        override public function onRegister():void{
            eventDispatcher.addEventListener(FightEvent.INITIATE_PLAYER_CAPTURE_TRY, this.initiatePlayerCaptureTry);
            eventDispatcher.addEventListener(FightEvent.INITIATE_PLAYER_ATTACK, this.initiatePlayerAttack);
            eventDispatcher.addEventListener(FightEvent.TRY_TO_CAPTURE, this.tryToCapture);
            eventDispatcher.addEventListener(FightEvent.PLAYER_CHANGE_FIRST_MONSTER, this.changeFirstMonster);
            eventDispatcher.addEventListener(FightEvent.SWAP_DEAD_MONSTER, this.swapDeadMonster);
            eventDispatcher.addEventListener(FightEvent.ATTACK_RESPONSE, this.attackResponse);
            eventDispatcher.addEventListener(FightEvent.CAPTURE_SUCCESS, this.captureSuccess);
            eventDispatcher.addEventListener(FightEvent.CAPTURE_FAIL, this.captureFail);
            eventDispatcher.addEventListener(FightEvent.CAPTURE_DIDNT_TRY, this.captureDidntTry);
            eventDispatcher.addEventListener(FightEvent.FRIEND_HELP_LOST_TURN, this.friendHelpLostTurn);
            eventDispatcher.addEventListener(FightEvent.SWAP_PLAYER_MONSTER, this.swapPlayerMonster);
            eventDispatcher.addEventListener(FightEvent.RUN_AWAY, this.runAway);
            eventDispatcher.addEventListener(FightEvent.RUN_AWAY_FAILED, this.runAwayFailed);
            eventDispatcher.addEventListener(FightEvent.RECHARGE_MONSTER, this.rechargePlayer);
            eventDispatcher.addEventListener(FightEvent.NPC_INITIAL_ATTACK, this.npcInitialAttack);
            eventDispatcher.addEventListener(FightEvent.FRIEND_HELP, this.friendHelp);
            eventDispatcher.addEventListener(FightEvent.ROUND_COMPLETE, this.onRoundComplete);
            dispatch(new ApplicationEvent(ApplicationEvent.INVOKE_CONGRAZZLES_STORY));
            if (this.model.state == BattleState.BEFORE_BATTLE_HAS_STARTED){
				//未解决的错误
				this.factory.init();
                this.intro();
            } else {
                this.retrieve();
            };
        }
        override public function onRemove():void{
            eventDispatcher.removeEventListener(FightEvent.INITIATE_PLAYER_CAPTURE_TRY, this.initiatePlayerCaptureTry);
            eventDispatcher.removeEventListener(FightEvent.INITIATE_PLAYER_ATTACK, this.initiatePlayerAttack);
            eventDispatcher.removeEventListener(FightEvent.TRY_TO_CAPTURE, this.tryToCapture);
            eventDispatcher.removeEventListener(FightEvent.PLAYER_CHANGE_FIRST_MONSTER, this.changeFirstMonster);
            eventDispatcher.removeEventListener(FightEvent.SWAP_DEAD_MONSTER, this.swapDeadMonster);
            eventDispatcher.removeEventListener(FightEvent.ATTACK_RESPONSE, this.attackResponse);
            eventDispatcher.removeEventListener(FightEvent.CAPTURE_SUCCESS, this.captureSuccess);
            eventDispatcher.removeEventListener(FightEvent.CAPTURE_FAIL, this.captureFail);
            eventDispatcher.removeEventListener(FightEvent.CAPTURE_DIDNT_TRY, this.captureDidntTry);
            eventDispatcher.removeEventListener(FightEvent.FRIEND_HELP_LOST_TURN, this.friendHelpLostTurn);
            eventDispatcher.removeEventListener(FightEvent.SWAP_PLAYER_MONSTER, this.swapPlayerMonster);
            eventDispatcher.removeEventListener(FightEvent.RUN_AWAY, this.runAway);
            eventDispatcher.removeEventListener(FightEvent.RUN_AWAY_FAILED, this.runAwayFailed);
            eventDispatcher.removeEventListener(FightEvent.RECHARGE_MONSTER, this.rechargePlayer);
            eventDispatcher.removeEventListener(FightEvent.NPC_INITIAL_ATTACK, this.npcInitialAttack);
            eventDispatcher.removeEventListener(FightEvent.FRIEND_HELP, this.friendHelp);
            eventDispatcher.removeEventListener(FightEvent.ROUND_COMPLETE, this.onRoundComplete);
            this.view.dispose();
        }
        private function npcInitialAttack(_arg1:FightEvent):void{
            this.processAttack(false, this.view.player);
        }
        private function attackResponse(_arg1:FightEvent):void{
            this.processAttack(true, this.view.player);
        }
        private function processAttack(_arg1:Boolean, _arg2:FightMonster):void{
            this.finishCharging();
            var _local3:AttackResponseVO = this.model.attack;
            if (!_local3){
                return;
            };
            this.playerLosesTurnFromBuff(_local3.existingUserBuffsFromRound);
            if (_arg1){
                this.completePlayerAttack(_local3.playerAttack);
                this.newUserBuffs(_local3.newUserBuffsOnUser, this.model.playerMonster);
                this.newNPCBuffs(_local3.newUserBuffsOnNPC, this.model.playerMonster);
                this.newUserBuffs(_local3.newUserDebuffsOnUser, this.model.playerMonster);
                this.newNPCBuffs(_local3.newUserDebuffsOnNPC, this.model.playerMonster);
                this.existingBuffs(_local3.existingBuffsFromUserAttacking);
                this.existingBuffs(_local3.existingBuffsFromNPCTakingDamage);
            };
            if (!((_local3.playerAttack.wonRound) || (_local3.playerAttack.wonBattle))){
                this.animateNPCAttack(_local3.npcAttack, _arg2);
            };
            this.newUserBuffs(_local3.newNPCBuffsOnUser, this.model.npcMonster);
            this.newNPCBuffs(_local3.newNPCBuffsOnNPC, this.model.npcMonster);
            this.newUserBuffs(_local3.newNPCDebuffsOnUser, this.model.npcMonster);
            this.newNPCBuffs(_local3.newNPCDebuffsOnNPC, this.model.npcMonster);
            this.existingBuffs(_local3.existingBuffsFromNPCAttacking);
            this.existingBuffs(_local3.existingBuffsFromUserTakingDamage);
            this.existingBuffs(_local3.existingUserBuffsFromRound);
            this.existingBuffs(_local3.existingNPCBuffsFromRound);
            if (((!(this.userWins())) && (!(this.userDies(_arg2))))){
                this.anims.pushAnim(this.factory.buffsFadePlayer());
                this.anims.pushAnim(this.factory.buffsFadeNPC());
                dispatch(new BattleActionEvent(BattleActionEvent.COMPLETE_ROUND));
            };
        }
        private function userWins():Boolean{
            var _local3:int;
            var _local1:AttackResponseVO = this.model.attack;
            var _local2:AttackResultVO = _local1.playerAttack;
            if (!((_local2.wonRound) || (_local2.wonBattle))){
                return (false);
            };
            this.npcMonsterDies();
            if (_local2.wonBattle){
                this.anims.pushAnim(this.factory.showXP());
                this.anims.pushAnim(this.factory.showItem());
                if (_local1.itemGranted){
                    if (_local1.itemGranted.type == int(7)){
                        this.anims.push(this.collectionData);
                        this.anims.pushAnim(this.factory.showMiniCollection());
                    } else {
                        _local3 = _local1.itemGranted.id;
                        this.anims.pushAnim(new UpdateInventoryAnim(this.inventory, _local3, 1));
                    };
                };
                if (this.story.winId){
                    this.anims.push(new AsyncDispatchWaitForPanelClosedEvent(eventDispatcher, new ApplicationEvent(ApplicationEvent.SET_STATE, ApplicationState.WIN_STORY_LOCATION), NewStory));
                };
                dispatch(new ApplicationEvent(ApplicationEvent.PUSH_QUEST_PANELS));
                this.endBattle();
            } else {
                this.nextNPCMonster();
                this.anims.pushAnim(this.factory.buffsFadePlayer());
                dispatch(new BattleActionEvent(BattleActionEvent.COMPLETE_ROUND));
            };
            return (true);
        }
        private function userDies(_arg1:FightMonster):Boolean{
            var _local2:AttackResponseVO = this.model.attack;
            var _local3:AttackResultVO = _local2.npcAttack;
            if (((!(_local3)) || (!(((_local3.wonRound) || (_local3.wonBattle)))))){
                return (false);
            };
            this.anims.pushAnim(this.factory.userMonsterDies(_arg1));
            if (_local2.npcAttack.wonBattle){
                if (this.story.loseId){
                    this.anims.push(new AsyncDispatchWaitForPanelClosedEvent(eventDispatcher, new ApplicationEvent(ApplicationEvent.SET_STATE, ApplicationState.LOSE_STORY_LOCATION), NewStory));
                };
                this.anims.pushAnim(this.factory.lose("LOSS_KO"));
                this.endBattle();
            } else {
                this.anims.pushAnim(this.factory.buffsFadeNPC());
                this.delayedState(BattleState.CHOOSE_NEXT_MONSTER);
            };
            return (true);
        }
        private function changeFirstMonster(_arg1:FightEvent):void{
            var _local2:MonsterBundle = this.monsters.monsterBundle(this.model.playerMonster);
            this.anims.pushAnim(this.factory.changeMoga(_local2));
            this.delayedState(BattleState.SET_FIRST_MONSTER);
        }
        private function swapDeadMonster(_arg1:FightEvent):void{
            var _local2:MonsterBundle = this.monsters.monsterBundle(this.model.playerMonster);
            this.anims.pushAnim(this.factory.changeMoga(_local2));
            this.delayedState(BattleState.FORCED_SWAP_MONSTER);
        }
        private function completeRound():void{
            dispatch(new BattleActionEvent(BattleActionEvent.COMPLETE_ROUND));
        }
        private function onRoundComplete(_arg1:FightEvent):void{
            var _local2:Boolean = ((((this.model.attack.playerAttack) && (this.model.attack.playerAttack.wonBattle))) || (((this.model.attack.npcAttack) && (this.model.attack.npcAttack.wonBattle))));
            if (!_local2){
                this.delayedState(BattleState.INPUT);
            };
        }
        private function endBattle():void{
            this.delayedState(BattleState.END);
            this.anims.push(new AsyncDispatchEvent(eventDispatcher, new ApplicationEvent(ApplicationEvent.SET_STATE, ApplicationState.WORLD)));
        }
        private function delayedState(_arg1:BattleState):void{
            this.anims.pushAnim(new SetStateAnim(this.model, _arg1));
        }
        private function intro():void{
            var _local1:Boolean = this.world.isSurprised;
            this.anims.pushAnim(this.factory.intro(_local1));
            this.delayedState(BattleState.SET_FIRST_MONSTER);
            if (this.model.npc.monsters.length > 1){
                this.anims.pushAnim(this.teamFightAnim());
            };
            if (this.model.isButtBattle){
                this.anims.pushAnim(this.specialFightAnim());
            };
            dispatch(new TrackingEvent(TrackingEvent.TRACK, TrackingType.START_BATTLE));
        }
        private function retrieve():void{
            this.anims.pushAnim(this.factory.retrieve());
        }
        private function initiatePlayerCaptureTry(_arg1:FightEvent):void{
            this.anims.pushAnim((this.charging = this.factory.playerCharging("2")));
        }
        private function initiatePlayerAttack(_arg1:FightEvent):void{
            var _local2:String = _arg1.data;
            this.anims.pushAnim(new PromoteContainerAnim(this.view, this.view.playerContainer));
            var _local3:ParallelAnims = new ParallelAnims();
            _local3.add((this.charging = this.factory.playerCharging(_local2)));
            if (this.model.pendingActionType == ActionType.ZODIAC){
                _local3.add(this.zodiacAnim());
            };
            this.anims.pushAnim(_local3);
        }
        private function zodiacAnim():Anim{
            var _local3:Asset;
            var _local1:AttackEstimateVO = this.model.getEstimates(this.model.playerMonster.id).zodiac;
            var _local2:Number = _local1.zodiacMod;
            if (_local2 >= 1){
                _local3 = this.assets.effectAsset("zodiacAttack_blue");
            } else {
                _local3 = this.assets.effectAsset("zodiacAttack_red");
            };
            var _local4:Asset = this.assets.zodiacIcon(this.model.playerMonster.zodiac);
            var _local5:Asset = this.assets.zodiacIcon(this.model.npcMonster.zodiac);
            return (this.factory.getZodiacAnim(_local1.zodiacMod, _local4, _local5, _local3));
        }
        private function teamFightAnim():Anim{
            return (this.factory.getTeamBattleAnim(this.assets.teamFightAnim));
        }
        private function specialFightAnim():Anim{
            return (this.factory.getSpecialEventBattleAnim(this.assets.specialEventBattleAnim));
        }
        private function completePlayerAttack(_arg1:AttackResultVO):void{
            if (!_arg1.attackingMove){
                return;
            };
            this.anims.pushAnim(this.factory.playerAttack(_arg1));
        }
        private function animateNPCAttack(_arg1:AttackResultVO, _arg2:FightMonster):void{
            if (((!(_arg1)) || (!(_arg1.attackingMove)))){
                return;
            };
            this.anims.pushAnim(new PromoteContainerAnim(this.view, this.view.npcContainer));
            this.anims.pushAnim(this.factory.npcAttack(_arg1, _arg2));
        }
        private function rechargePlayer(_arg1:FightEvent):void{
            this.anims.pushAnim(this.factory.rechargePlayer());
        }
        private function swapPlayerMonster(_arg1:FightEvent):void{
            var _local2:MonsterBundle = this.monsters.monsterBundle(this.model.playerMonster);
            this.anims.pushAnim(this.factory.changeMoga(_local2, _arg1.data));
            this.anims.push(new SetBattleState(this.model, BattleState.SWAP_MONSTER));
            this.processAttack(false, _local2.fight);
        }
        private function npcMonsterDies():void{
            this.anims.pushAnim(this.factory.npcMonsterDies());
        }
        private function nextNPCMonster():void{
            this.delayedState(BattleState.NPC_SWAP);
            this.anims.pushAnim(this.factory.nextNPCMonster());
        }
        private function tryToCapture(_arg1:FightEvent):void{
            var _local2:CaptureTryAnim = this.factory.tryToCapture();
            this.tryCaptureAsset = _local2.asset;
            this.anims.pushAnim(_local2);
        }
        private function finishCharging():void{
            if (this.charging){
                this.charging.finish();
            };
            this.charging = null;
        }
        private function captureSuccess(_arg1:FightEvent):void{
            var _local4:int;
            this.finishCharging();
            this.tryToCapture(_arg1);
            var _local2:Anim = this.factory.captureSuccess(_arg1.data, this.tryCaptureAsset);
            _local2.complete.addOnce(this.onCaptureAnimCompleted);
            this.anims.pushAnim(_local2);
            this.anims.pushAnim(this.factory.showItem());
            var _local3:AttackResponseVO = this.model.attack;
            if (_local3.itemGranted){
                if (_local3.itemGranted.type == int(7)){
                    this.anims.push(this.collectionData);
                    this.anims.pushAnim(this.factory.showMiniCollection());
                } else {
                    _local4 = _local3.itemGranted.id;
                    this.anims.pushAnim(new UpdateInventoryAnim(this.inventory, _local4, 1));
                };
            };
            dispatch(new ApplicationEvent(ApplicationEvent.PUSH_QUEST_PANELS));
            this.endBattle();
        }
        private function captureFail(_arg1:FightEvent):void{
            this.finishCharging();
            this.tryToCapture(_arg1);
            var _local2:Anim = this.factory.captureFails(this.tryCaptureAsset);
            _local2.complete.addOnce(this.onCaptureAnimCompleted);
            this.anims.pushAnim(_local2);
            this.processAttack(false, this.view.player);
        }
        private function friendHelpLostTurn(_arg1:FightEvent):void{
            this.finishCharging();
            this.processAttack(false, this.view.player);
        }
        private function captureDidntTry(_arg1:FightEvent):void{
            this.finishCharging();
            this.processAttack(false, this.view.player);
        }
        private function onCaptureAnimCompleted(_arg1:Anim):void{
            this.tryCaptureAsset.dispose();
            this.tryCaptureAsset = null;
        }
        public function newUserBuffs(_arg1:Vector.<BuffVO>, _arg2:MonsterModel):void{
            var _local3:BuffVO;
            for each (_local3 in _arg1) {
                this.anims.pushAnim(this.factory.applyPlayerBuff(_local3, _arg2));
            };
        }
        private function newNPCBuffs(_arg1:Vector.<BuffVO>, _arg2:MonsterModel):void{
            var _local3:BuffVO;
            for each (_local3 in _arg1) {
                this.anims.pushAnim(this.factory.applyNPCBuff(_local3, _arg2));
            };
        }
        private function playerLosesTurnFromBuff(_arg1:Vector.<BuffResultVO>):void{
            var _local2:BuffResultVO;
            for each (_local2 in _arg1) {
                if (_local2.isTargetPlayer){
                    switch (_local2.result){
                        case BuffResult.TURN:
                            if (this.model.attack.playerAttack.wonBattle){
                                break;
                            };
                            if (_local2.type == BuffType.DEBUFF){
                                this.anims.pushAnim(this.factory.buffSkipsPlayerTurn(_local2));
                            };
                            break;
                        case BuffResult.DAMAGE:
                        case BuffResult.HP:
                        case BuffResult.APPLY_BUFF:
                        case BuffResult.PROPERTY_MODIFIER:
                            break;
                        default:
                            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 160));
                            break;
                    };
                } else {
                    switch (_local2.result){
                        case BuffResult.TURN:
                            if (this.model.attack.playerAttack.wonBattle){
                                break;
                            };
                            if (_local2.type == BuffType.DEBUFF){
                                this.anims.pushAnim(this.factory.buffSkipsNPCTurn(_local2));
                            };
                            break;
                        case BuffResult.DAMAGE:
                        case BuffResult.HP:
                        case BuffResult.APPLY_BUFF:
                        case BuffResult.PROPERTY_MODIFIER:
                            break;
                        default:
                            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 123));
                            break;
                    };
                };
            };
        }
        private function playerGainsTurnFromBuff(_arg1:Vector.<BuffResultVO>):void{
            var _local2:BuffResultVO;
            for each (_local2 in _arg1) {
                if (_local2.isTargetPlayer){
                    switch (_local2.result){
                        case BuffResult.TURN:
                            if (this.model.attack.playerAttack.wonBattle){
                                break;
                            };
                            if ((((_local2.type == BuffType.BUFF)) && (_local2.isAppliedToSelf))){
                                this.anims.pushAnim(this.factory.buffGainsPlayerTurn(_local2));
                            } else {
                                if ((((_local2.type == BuffType.BUFF)) && (!(_local2.isAppliedToSelf)))){
                                    this.anims.pushAnim(this.factory.buffGainsNPCTurn(_local2));
                                };
                            };
                            break;
                        case BuffResult.DAMAGE:
                        case BuffResult.HP:
                        case BuffResult.APPLY_BUFF:
                        case BuffResult.PROPERTY_MODIFIER:
                            break;
                        default:
                            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 160));
                            break;
                    };
                } else {
                    switch (_local2.result){
                        case BuffResult.TURN:
                            if (this.model.attack.playerAttack.wonBattle){
                                break;
                            };
                            if ((((_local2.type == BuffType.BUFF)) && (_local2.isAppliedToSelf))){
                                this.anims.pushAnim(this.factory.buffGainsNPCTurn(_local2));
                            } else {
                                if ((((_local2.type == BuffType.BUFF)) && (!(_local2.isAppliedToSelf)))){
                                    this.anims.pushAnim(this.factory.buffGainsPlayerTurn(_local2));
                                };
                            };
                            break;
                        case BuffResult.DAMAGE:
                        case BuffResult.HP:
                        case BuffResult.APPLY_BUFF:
                        case BuffResult.PROPERTY_MODIFIER:
                            break;
                        default:
                            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 123));
                            break;
                    };
                };
            };
        }
        private function existingBuffs(_arg1:Vector.<BuffResultVO>):void{
            var _local2:BuffResultVO;
            for each (_local2 in _arg1) {
                if (_local2.isTargetPlayer){
                    switch (_local2.result){
                        case BuffResult.DAMAGE:
                            this.anims.pushAnim(this.factory.buffDamagesPlayer(_local2));
                            break;
                        case BuffResult.HP:
                            this.anims.pushAnim(this.factory.buffHealsPlayer(_local2));
                            break;
                        case BuffResult.APPLY_BUFF:
                            this.anims.pushAnim(this.factory.buffAppliesBuffToPlayer(_local2));
                            break;
                        case BuffResult.TURN:
                            break;
                        case BuffResult.PROPERTY_MODIFIER:
                            break;
                        default:
                            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 160));
                            break;
                    };
                } else {
                    switch (_local2.result){
                        case BuffResult.DAMAGE:
                            this.anims.pushAnim(this.factory.buffDamagesNPC(_local2));
                            break;
                        case BuffResult.HP:
                            this.anims.pushAnim(this.factory.buffHealsNPC(_local2));
                            break;
                        case BuffResult.APPLY_BUFF:
                            this.anims.pushAnim(this.factory.buffAppliesBuffToNPC(_local2));
                            break;
                        case BuffResult.TURN:
                            break;
                        case BuffResult.PROPERTY_MODIFIER:
                            break;
                        default:
                            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 123));
                            break;
                    };
                };
            };
        }
        private function runAway(_arg1:FightEvent):void{
            this.anims.pushAnim(this.factory.runAway());
            if (this.story.loseId){
                this.anims.push(new AsyncDispatchWaitForPanelClosedEvent(eventDispatcher, new ApplicationEvent(ApplicationEvent.SET_STATE, ApplicationState.LOSE_STORY_LOCATION), NewStory));
            };
            this.endBattle();
        }
        private function runAwayFailed(_arg1:FightEvent):void{
            this.anims.pushAnim(this.factory.runAwayFailed());
        }
        private function friendHelp(_arg1:FightEvent):void{
            var _local2:Friend = this.model.friend;
            this.anims.pushAnim(new PromoteContainerAnim(this.view, this.view.playerContainer));
            this.anims.pushAnim(this.factory.friendAttack(_local2));
            if (!this.userWins()){
                dispatch(new BattleActionEvent(BattleActionEvent.COMPLETE_ROUND));
            };
        }

    }
}//package com.gaiaonline.monster.view 
