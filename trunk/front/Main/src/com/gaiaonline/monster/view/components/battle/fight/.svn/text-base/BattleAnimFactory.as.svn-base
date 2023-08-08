//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight {
    import flash.display.*;
    import flash.events.*;
    import com.gaiaonline.monster.model.vo.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.model.world.*;
    import gaia.moga.collections.model.*;
    import gaia.moga.friendlist.model.*;
    import com.gaiaonline.monster.service.sound.*;
    import gaia.moga.data.*;
    import com.gaiaonline.monster.view.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import gaia.moga.assets.bundle.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.attack.*;
    import com.gaiaonline.monster.view.components.battle.vo.*;
    import com.gaiaonline.monster.view.components.battle.ui.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.capture.*;
    import gaia.moga.monster.model.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.combatlog.event.*;
    import gaia.moga.collections.view.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.monster.*;
    import com.gaiaonline.monster.model.battle.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.win.*;
    import com.gaiaonline.monster.view.components.team.*;
    import com.gaiaonline.monster.view.components.feeds.*;
    import gaia.moga.data.attacks.*;
    import com.gaiaonline.monster.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.controller.async.*;
    import gaia.moga.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.simple.*;
    import com.gaiaonline.monster.view.components.battle.ui.anims.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.combattext.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.lose.*;

    public class BattleAnimFactory extends Actor {

		[Inject]
        public var data:DataBundle;
		[Inject]
        public var assets:AssetService;
		[Inject]
        public var text:TextService;
		[Inject]
        public var battle:BattleMediator;
		[Inject]
        public var model:BattleModel;
		[Inject]
        public var ranch:HomeRanchModel;
		[Inject]
        public var application:ApplicationMediator;
		[Inject]
        public var monsters:MonsterAssetsFactory;
		[Inject]
        public var facebook:FBService;
		[Inject]
        public var sounds:SoundService;
		[Inject]
        public var music:MusicService;
		[Inject]
        public var world:WorldModel;
		[Inject]
        public var fb:FBService;
		[Inject]
        public var mogas:MogaFactory;
		[Inject]
        public var collectionFactory:MogaCollectionFactory;
		[Inject]
        public var fight:Fight;
        private var missSound:SoundProxy;
        private var lightDamageSound:SoundProxy;
        private var medDamageSound:SoundProxy;
        private var criticalDamageSound:SoundProxy;
        private var attackSound:SoundProxy;
        private var monsterIn:SoundProxy;
        private var foundItem:SoundProxy;
        private var captureSuccessSound:SoundProxy;
        private var captureFailSound:SoundProxy;
        private var levelUpSound:SoundProxy;
        private var runSuccessSound:SoundProxy;
        private var runFailSound:SoundProxy;
        private var dieSound:SoundProxy;
        private var captureAttemptSound:SoundProxy;
        private var bonusAttackSound:SoundProxy;
        private var zodiacSoundGood:SoundProxy;
        private var zodiacSoundBad:SoundProxy;
        private var loseMusic:MusicProxy;
        private var winMusic:MusicProxy;
        private var captureSuccessMusic:MusicProxy;

        private static const DIE:String = "die";
        private static const RUN_FAIL:String = "run_fail";
        private static const RUN:String = "run";
        private static const RECHARGE_ANIM:String = "recharge";

		public var view:Battle;
		
        public function init():void{
            this.view = this.battle.view;
            this.fight = this.view.fight;
            this.missSound = this.sounds.getFX("sounds/battle_miss.mp3");
            this.lightDamageSound = this.sounds.getFX("sounds/battle_dmg_light.mp3");
            this.medDamageSound = this.sounds.getFX("sounds/battle_dmg_med.mp3");
            this.criticalDamageSound = this.sounds.getFX("sounds/battle_dmg_hard.mp3");
            this.attackSound = this.sounds.getFX("sounds/battle_attack.mp3");
            this.monsterIn = this.sounds.getFX("sounds/monster_in.mp3");
            this.foundItem = this.sounds.getFX("sounds/found_item.mp3");
            this.captureSuccessSound = this.sounds.getFX("sounds/capture_success.mp3");
            this.captureFailSound = this.sounds.getFX("sounds/capture_fail.mp3");
            this.captureAttemptSound = this.sounds.getFX("sounds/capture_attempt.mp3");
            this.levelUpSound = this.sounds.getFX("sounds/level_up.mp3");
            this.runSuccessSound = this.sounds.getFX("sounds/run.mp3");
            this.runFailSound = this.sounds.getFX("sounds/run_fail.mp3");
            this.dieSound = this.sounds.getFX("sounds/die.mp3");
            this.bonusAttackSound = this.sounds.getFX("sounds/bonus_attack.mp3");
            this.zodiacSoundGood = this.sounds.getFX("sounds/zodiacSoundGood.mp3");
            this.zodiacSoundBad = this.sounds.getFX("sounds/zodiacSoundBad.mp3");
            this.winMusic = this.music.load("sounds/battle_win.mp3");
            this.loseMusic = this.music.load("sounds/battle_lose.mp3", false);
            this.captureSuccessMusic = this.music.load("sounds/capture_success_music.mp3", false);
        }
        public function intro(_arg1:Boolean):Anim{
            var _local3:ParallelAnims;
            var _local2:AnimStack = new AnimStack();
            var _local4:MonsterModel = this.model.npcMonster;
            var _local5:FightMonster = this.monsters.monsterFight(_local4);
            _local5.useButt = this.model.isButtBattle;
            var _local6:Asset = this.assets.zodiacIcon(_local4.zodiac);
            _local2.push(this.log(this.text.getText("BATTLE_INTRO", {LOCATION:this.world.currentLocation.name})));
            _local2.push(new SwapInNPCAnim(this.fight, _local5));
            var _local7:Vector.<DisplayObject> = new Vector.<DisplayObject>(1, true);
            _local7[0] = this.fight.npcContainer;
            _local2.push(new ScrollBackgroundAnim(this.fight.background, this.fight.parallax, _local7));
            _local3 = new ParallelAnims();
            _local2.push(this.log(this.text.getText("BATTLE_OPPONENT", {MOGA:_local4.name})));
            _local3.add(new StatusShowAnim(this.view.npcStatus, _local4, _local6));
            _local3.add(new DelayAnim(1000));
            if (_arg1){
                _local3.add(new SurpriseAttackAnim(this.fight, this.assets.surpriseAttackAsset()));
            };
            _local2.push(_local3);
            var _local8:MonsterModel = this.model.playerMonster;
            if (_local8){
                _local2.push(this.introPlayerMonster(_local8));
            };
            _local2.push(this.enableSwap());
            return (_local2);
        }
        private function introPlayerMonster(_arg1:MonsterModel):Anim{
            var _local2:AnimStack;
            var _local3:ParallelAnims;
            var _local4:MonsterBundle = this.monsters.monsterBundle(_arg1);
            _local2 = new AnimStack();
            _local2.push(new AnimSoundEffect(this.monsterIn));
            _local2.push(new CallOutAnim(this.view.front, this.assets.callOut, _local4.large, _arg1.name));
            _local3 = new ParallelAnims();
            _local3.add(new MonsterInAnim(this.fight, this.assets.callOutAfter, _local4.fight, this.fight.playerContainer));
            _local3.add(new ShowPortraitMonsterAnim(this.view.portrait, _local4.zodiacBackground, _local4.portrait));
            _local2.push(_local3);
            _local3 = new ParallelAnims();
            _local3.add(new SwapInPlayerAnim(this.fight, _local4.fight));
            _local3.add(new StatusShowAnim(this.view.playerStatus, _arg1, _local4.zodiac));
            _local2.push(_local3);
            return (_local2);
        }
        public function retrieve():Anim{
            var _local7:FightMonster;
            var _local8:Asset;
            var _local9:Asset;
            var _local10:Asset;
            var _local1:AnimStack = new AnimStack();
            var _local2:ParallelAnims = new ParallelAnims();
            _local1.push(_local2);
            var _local3:MonsterModel = this.model.npcMonster;
            var _local4:FightMonster = this.monsters.monsterFight(_local3);
            var _local5:Asset = this.assets.zodiacIcon(_local3.zodiac);
            _local4.useButt = this.model.isButtBattle;
            this.fight.npc = _local4;
            _local2.add(new StatusShowAnim(this.view.npcStatus, _local3, _local5));
            var _local6:MonsterModel = this.model.playerMonster;
            if (_local6){
                _local7 = this.monsters.monsterFight(_local6);
                _local8 = this.monsters.monsterPortrait(_local6);
                _local9 = this.assets.zodiacBackground(_local6);
                _local10 = this.assets.zodiacIcon(_local6.zodiac);
                _local7.useButt = this.model.isButtBattle;
                this.fight.player = _local7;
                this.view.portrait.background = _local9;
                this.view.portrait.monster = _local8;
                this.view.portrait.container.x = 0;
                _local2.add(new StatusShowAnim(this.view.playerStatus, _local6, _local10));
                _local1.push(new SetStateAnim(this.model, BattleState.INPUT));
            } else {
                _local1.push(new SetStateAnim(this.model, BattleState.CHOOSE_NEXT_MONSTER));
            };
            _local1.push(this.enableSwap());
            return (_local1);
        }
        private function enableSwap():Anim{
            var _local1:Event = new TeamEvent(TeamEvent.ENABLE_SMALLTEAM);
            var _local2:AsyncDispatchEvent = new AsyncDispatchEvent(eventDispatcher, _local1);
            return (new AnimAsyncWrapper(_local2));
        }
        public function changeMoga(_arg1:MonsterBundle, _arg2:int=-1):Anim{
            var _local5:ParallelAnims;
            var _local3:MonsterModel = this.model.playerMonster;
            var _local4:AnimStack = new AnimStack();
            if (this.fight.player){
                _local5 = new ParallelAnims();
                _local5.add(new StatusHideAnim(this.view.playerStatus));
                _local5.add(new HidePortraitMonsterAnim(this.view.portrait));
                _local5.add(new MonsterSwapOutAnim(this.fight.player));
                _local4.push(_local5);
            };
            _local4.push(new AnimSoundEffect(this.monsterIn));
            _local4.push(new CallOutAnim(this.view.front, this.assets.callOut, _arg1.large, _local3.name));
            _local5 = new ParallelAnims();
            _local5.add(new MonsterInAnim(this.fight, this.assets.callOutAfter, _arg1.fight, this.fight.playerContainer));
            _local5.add(new ShowPortraitMonsterAnim(this.view.portrait, _arg1.zodiacBackground, _arg1.portrait));
            _local4.push(_local5);
            _local5 = new ParallelAnims();
            _local5.add(new SwapInPlayerAnim(this.fight, _arg1.fight));
            _local5.add(new StatusShowAnim(this.view.playerStatus, _local3, _arg1.zodiac, _arg2));
            _local4.push(_local5);
            _local4.push(this.enableSwap());
            return (_local4);
        }
        public function changeNPC(_arg1:MonsterModel):Anim{
            return (null);
        }
        public function playerCharging(_arg1:String):MonsterChargeAnim{
            var _local2:AttackDataVO = this.data.attacks.getData(_arg1);
            var _local3:Asset = this.assets.effectAsset(_local2.chargeAnim);
            return (new MonsterChargeAnim(_local3, this.fight.player));
        }
        public function playerAttack(_arg1:AttackResultVO):Anim{
            var _local2:AttackDataVO = this.data.attacks.getData(_arg1.attackingMove.id);
            if (!_local2){
                return (null);
            };
            var _local3:FightMonster = this.fight.npc;
            var _local4:IMonsterAttackAnim = this.getAttackAnim(_local2.attackAnim, this.fight.playerContainer, this.fight.player);
            var _local5:Anim = this.monsterReaction(_arg1, _local3, this.view.npcStatus, this.fight.npcContainer, this.fight.npcAbove);
            var _local6:SoundProxy = this.getHitSound(_arg1, _local2.attackAnim);
            return (new MonsterAttackHitAnim(_local4, _local5, _local6));
        }
        public function getZodiacAnim(_arg1:Number, _arg2:Asset, _arg3:Asset, _arg4:Asset):Anim{
            var _local5:SoundProxy;
            if (_arg1 >= 1){
                _local5 = this.zodiacSoundGood;
            } else {
                _local5 = this.zodiacSoundBad;
            };
            var _local6:ZodiacEffectivenessAnim = new ZodiacEffectivenessAnim(this.fight.parent.parent, _arg4, _arg1, _arg2, _arg3, this.text.getZodiacEffectText(_arg1), _local5);
            return (_local6);
        }
        public function getTeamBattleAnim(_arg1:Asset):Anim{
            var _local2:SpecialBattleIntroAnim = new SpecialBattleIntroAnim(this.fight.parent.parent, _arg1);
            return (_local2);
        }
        public function getSpecialEventBattleAnim(_arg1:Asset):Anim{
            var _local2:SpecialBattleIntroAnim = new SpecialBattleIntroAnim(this.fight.parent.parent, _arg1);
            return (_local2);
        }
        private function getAttackAnim(_arg1:String, _arg2:DisplayObjectContainer, _arg3:FightMonster):IMonsterAttackAnim{
            if (_arg1 == "default"){
                return (new MonsterInternalAttackAnim(_arg3));
            };
            var _local4:Asset = this.assets.effectAsset(_arg1);
            var _local5:SoundProxy = this.getAttackSound(_arg1);
            return (new MonsterAttackAnim(_arg2, _local4, _arg3, _local5));
        }
        public function friendAttack(_arg1:Friend):Anim{
            var _local2:AttackResultVO = _arg1.attack;
            var _local3:String = this.text.getText("FRIEND_HELP_MESSAGE", {FRIEND:_arg1.name});
            var _local4:FightMonster = this.fight.player;
            var _local5:FightMonster = this.monsters.monsterFight(_arg1.monster);
            _local5.useButt = this.model.isButtBattle;
            var _local6:Object = _local2.attackingMove;
            if (!_local6){
                dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, Errors.NO_MOVE_FOUND_FOR_BONUS_ATTACK_MOGA));
            };
            var _local7:AttackDataVO = this.data.attacks.getData(_local6.id);
            var _local8:FightMonster = this.fight.npc;
            var _local9:IMonsterAttackAnim = this.getAttackAnim(_local7.attackAnim, this.fight.playerContainer, _local5);
            var _local10:Anim = this.monsterReaction(_local2, _local8, this.view.npcStatus, this.fight.npcContainer, this.fight.npcAbove);
            var _local11:SoundProxy = this.getHitSound(_local2, _local7.attackAnim);
            var _local12:MonsterAttackHitAnim = new MonsterAttackHitAnim(_local9, _local10, _local11);
            var _local13:Asset = this.assets.friendHelpInAsset();
            var _local14:Asset = this.assets.friendHelpOutAsset();
            var _local15:ParallelAnims = new ParallelAnims();
            _local15.add(this.log(_local3));
            _local15.add(new AnimSoundEffect(this.bonusAttackSound));
            _local15.add(new HelpAnim(this.fight.parent.parent, _local13, _local12, _local14, _local4, _local5));
            return (_local15);
        }
        public function npcAttack(_arg1:AttackResultVO, _arg2:FightMonster):Anim{
            var _local3:AttackDataVO = this.data.attacks.getData(_arg1.attackingMove.id);
            var _local4:AnimStack = new AnimStack();
            var _local5:Async = new AsyncDispatchEvent(eventDispatcher, new FightEvent(FightEvent.UPDATE_VIEW_STATE, BattleViewState.ENEMY_TURN));
            _local4.push(new AnimAsyncWrapper(_local5));
            var _local6:MonsterChargeAnim = new MonsterChargeAnim(this.assets.effectAsset(_local3.chargeAnim), this.fight.npc, Timing.NPC_CHARGE_TIME);
            _local4.push(_local6);
            var _local7:IMonsterAttackAnim = this.getAttackAnim(_local3.attackAnim, this.fight.npcContainer, this.fight.npc);
            var _local8:Anim = this.monsterReaction(_arg1, _arg2, this.view.playerStatus, this.fight.playerContainer, this.fight.playerAbove);
            var _local9:SoundProxy = this.getHitSound(_arg1, _local3.attackAnim);
            _local4.push(new MonsterAttackHitAnim(_local7, _local8, _local9));
            return (_local4);
        }
        private function monsterReaction(_arg1:AttackResultVO, _arg2:FightMonster, _arg3:BattleUIStatus, _arg4:MonsterContainer, _arg5:Sprite):Anim{
            var _local6:AttackDataVO = this.data.attacks.getData(_arg1.attackingMove.id);
            var _local7:ParallelAnims = new ParallelAnims();
            _local7.add(this.combatLog(_arg1));
            if (((_arg1.damage) || (_arg1.miss))){
                _local7.add(this.damageCombatText(_arg5, _arg1));
            };
            if (_arg1.damage){
                _local7.add(new MonsterAnim(_arg4, this.assets.effectAsset(_local6.hitAnim), _arg2));
                _local7.add(new StatusUpdateAnim(_arg3, (_arg1.damage * -1)));
                if (_arg1.isPlayer){
                    _local7.add(this.updateNPCTeam(_arg1.target));
                } else {
                    _local7.add(this.updateSmallTeam(_arg1.target));
                };
            };
            return (_local7);
        }
        public function runAway():Anim{
            var _local1:Asset = this.assets.effectAsset(RUN);
            var _local2:String = this.text.getText("RUN_AWAY", {TARGET:this.model.playerMonster.name});
            var _local3:ParallelAnims = new ParallelAnims();
            _local3.add(this.log(_local2));
            _local3.add(new MonsterDieAnim(this.fight.playerContainer, _local1, this.fight.player, this.view.playerStatus));
            _local3.add(new AnimSoundEffect(this.runSuccessSound));
            return (_local3);
        }
        public function applyNPCBuff(_arg1:BuffVO, _arg2:MonsterModel):Anim{
            var _local7:int;
            var _local8:int;
            var _local3:Asset = ((_arg1.type == BuffType.BUFF)) ? this.assets.buffAnim() : this.assets.debuffAnim();
            _local3.self.scaleX = -1;
            if (_local3.isComplete){
                this.tweak(_local3);
            } else {
                _local3.complete.addOnce(this.tweak);
            };
            var _local4:Asset = this.assets.buffIcon(_arg1.icon);
            var _local5:String = this.text.describeNewBuff(_arg1, _arg2, this.model.npcMonster);
            var _local6:ParallelAnims = new ParallelAnims();
            _local6.add(new MonsterBuffAnim(this.fight.npcContainer, _local3, this.fight.npc, this.view.npcStatus, _arg1, _local4));
            _local6.add(this.log(_local5));
            if (((((!(_arg1.alreadyOn)) && ((_arg1.result == BuffResult.PROPERTY_MODIFIER)))) && ((_arg1.fn.input == "hp")))){
                _local7 = (this.model.attack.npcAttack) ? this.model.attack.npcAttack.hpAtStartOfRound : this.model.attack.playerAttack.opponentHpAtStartOfRound;
                _local8 = (_local7 + ((_arg1.fn.m == 1)) ? _arg1.fn.value : 0);
                _local6.add(new StatusHpSetAnim(this.view.npcStatus, _local8, this.model.npcMonster.maxHP));
            };
            return (_local6);
        }
        private function tweak(_arg1:Asset):void{
            MovieClip(_arg1.content).monster.scaleX = -1;
        }
        public function applyPlayerBuff(_arg1:BuffVO, _arg2:MonsterModel):Anim{
            var _local7:int;
            var _local8:int;
            var _local3:Asset = ((_arg1.type == BuffType.BUFF)) ? this.assets.buffAnim() : this.assets.debuffAnim();
            var _local4:Asset = this.assets.buffIcon(_arg1.icon);
            var _local5:String = this.text.describeNewBuff(_arg1, _arg2, this.model.playerMonster);
            var _local6:ParallelAnims = new ParallelAnims();
            _local6.add(new MonsterBuffAnim(this.fight.playerContainer, _local3, this.fight.player, this.view.playerStatus, _arg1, _local4));
            _local6.add(this.log(_local5));
            if (((((!(_arg1.alreadyOn)) && ((_arg1.result == BuffResult.PROPERTY_MODIFIER)))) && ((_arg1.fn.input == "hp")))){
                _local7 = (this.model.attack.playerAttack) ? this.model.attack.playerAttack.hpAtStartOfRound : this.model.attack.npcAttack.opponentHpAtStartOfRound;
                _local8 = (_local7 + ((_arg1.fn.m == 1)) ? _arg1.fn.value : 0);
                _local6.add(new StatusHpSetAnim(this.view.playerStatus, _local8, this.model.playerMonster.maxHP));
            };
            return (_local6);
        }
        public function buffHealsPlayer(_arg1:BuffResultVO):Anim{
            var _local2:ParallelAnims = new ParallelAnims();
            var _local3:uint = _arg1.value;
            if (_local3){
                _local2.add(new DamageSCTAnim(this.fight.playerAbove, this.assets.healSCT(), _local3, Timing.SCT_BLOCKS));
                _local2.add(new StatusUpdateAnim(this.view.playerStatus, _local3));
                _local2.add(this.updateSmallTeam(_arg1.target));
            };
            _local2.add(this.buffLog(_arg1));
            return (_local2);
        }
        public function buffDamagesPlayer(_arg1:BuffResultVO):Anim{
            var _local2:uint = _arg1.value;
            var _local3:AttackDataVO = this.data.attacks.getData(_arg1.id);
            var _local4:ParallelAnims = new ParallelAnims();
            if (_local2){
                _local4.add(new MonsterAnim(this.fight.playerContainer, this.assets.effectAsset(_local3.hitAnim), this.fight.player));
                _local4.add(new DamageSCTAnim(this.fight.playerAbove, this.assets.damageSCT(), _local2, Timing.SCT_BLOCKS));
                _local4.add(new StatusUpdateAnim(this.view.playerStatus, (_local2 * -1)));
                _local4.add(this.updateSmallTeam(_arg1.target));
            };
            _local4.add(this.buffLog(_arg1));
            return (_local4);
        }
        public function buffHealsNPC(_arg1:BuffResultVO):Anim{
            var _local2:ParallelAnims = new ParallelAnims();
            var _local3:uint = _arg1.value;
            if (_local3){
                _local2.add(new DamageSCTAnim(this.fight.npcAbove, this.assets.healSCT(), _local3, Timing.SCT_BLOCKS));
                _local2.add(new StatusUpdateAnim(this.view.npcStatus, _local3));
                _local2.add(this.updateNPCTeam(_arg1.target));
            };
            _local2.add(this.buffLog(_arg1));
            return (_local2);
        }
        public function buffDamagesNPC(_arg1:BuffResultVO):Anim{
            var _local2:uint = _arg1.value;
            var _local3:AttackDataVO = this.data.attacks.getData(_arg1.id);
            var _local4:ParallelAnims = new ParallelAnims();
            if (_local2){
                _local4.add(new MonsterAnim(this.fight.npcContainer, this.assets.effectAsset(_local3.hitAnim), this.fight.npc));
                _local4.add(new DamageSCTAnim(this.fight.npcAbove, this.assets.damageSCT(), _local2, Timing.SCT_BLOCKS));
                _local4.add(new StatusUpdateAnim(this.view.npcStatus, (_local2 * -1)));
                _local4.add(this.updateNPCTeam(_arg1.target));
            };
            _local4.add(this.buffLog(_arg1));
            return (_local4);
        }
        public function buffAppliesBuffToPlayer(_arg1:BuffResultVO):Anim{
            var _local2:BuffVO = _arg1.modApplied;
            var _local3:Asset = this.assets.buffAnim();
            var _local4:Asset = this.assets.buffIcon(_local2.icon);
            var _local5:ParallelAnims = new ParallelAnims();
            _local5.add(new MonsterBuffAnim(this.fight.playerContainer, _local3, this.fight.player, this.view.playerStatus, _local2, _local4));
            _local5.add(this.buffLog(_arg1));
            return (_local5);
        }
        public function buffAppliesBuffToNPC(_arg1:BuffResultVO):Anim{
            var _local2:BuffVO = _arg1.modApplied;
            var _local3:Asset = ((_local2.type == BuffType.BUFF)) ? this.assets.buffAnim() : this.assets.debuffAnim();
            var _local4:Asset = this.assets.buffIcon(_local2.icon);
            var _local5:ParallelAnims = new ParallelAnims();
            _local5.add(new MonsterBuffAnim(this.fight.npcContainer, _local3, this.fight.npc, this.view.npcStatus, _local2, _local4));
            _local5.add(this.buffLog(_arg1));
            return (_local5);
        }
        public function buffSkipsPlayerTurn(_arg1:BuffResultVO):Anim{
            var _local2:ParallelAnims = new ParallelAnims();
            _local2.add(new MiscSCTAnim(this.fight.playerAbove, this.assets.loseTurnSCT(), Timing.SCT_BLOCKS));
            _local2.add(new MonsterAnim(this.fight.playerContainer, this.assets.stunnedAnim(), this.fight.player));
            _local2.add(this.buffLog(_arg1));
            return (_local2);
        }
        public function buffSkipsNPCTurn(_arg1:BuffResultVO):Anim{
            var _local2:ParallelAnims = new ParallelAnims();
            _local2.add(new MiscSCTAnim(this.fight.npcAbove, this.assets.loseTurnSCT(), Timing.SCT_BLOCKS));
            _local2.add(new MonsterAnim(this.fight.npcContainer, this.assets.stunnedAnim(), this.fight.npc));
            _local2.add(this.buffLog(_arg1));
            return (_local2);
        }
        public function buffGainsPlayerTurn(_arg1:BuffResultVO):Anim{
            var _local2:ParallelAnims = new ParallelAnims();
            _local2.add(new MiscSCTAnim(this.fight.playerAbove, this.assets.gainTurnSCT(), Timing.SCT_BLOCKS));
            return (_local2);
        }
        public function buffGainsNPCTurn(_arg1:BuffResultVO):Anim{
            var _local2:ParallelAnims = new ParallelAnims();
            _local2.add(new MiscSCTAnim(this.fight.npcAbove, this.assets.gainTurnSCT(), Timing.SCT_BLOCKS));
            return (_local2);
        }
        public function buffsFadeNPC():Anim{
            return (this.buffsFade(this.model.npcMonster, this.view.npcStatus));
        }
        public function buffsFadePlayer():Anim{
            return (this.buffsFade(this.model.playerMonster, this.view.playerStatus));
        }
        private function buffsFade(_arg1:MonsterModel, _arg2:BattleUIStatus):Anim{
            return (new FadeBuffsAnim(eventDispatcher, _arg1, _arg2, this.text));
        }
        public function userMonsterDies(_arg1:FightMonster):Anim{
            var _local2:Asset = this.assets.effectAsset(DIE);
            if (!_arg1){
                _arg1 = this.fight.player;
            };
            var _local3:AnimStack = new AnimStack();
            var _local4:ParallelAnims = new ParallelAnims();
            _local4.add(new MonsterDieAnim(this.fight.playerContainer, _local2, _arg1, this.view.playerStatus, this.dieSound));
            _local4.add(new HidePortraitMonsterAnim(this.view.portrait));
            _local3.push(_local4);
            var _local5:DeselectDeadMonster = new DeselectDeadMonster(eventDispatcher, this.model);
            _local3.push(_local5);
            return (_local3);
        }
        public function npcMonsterDies():Anim{
            var _local1:Asset = this.assets.effectAsset(DIE);
            return (new MonsterDieAnim(this.fight.npcContainer, _local1, this.fight.npc, this.view.npcStatus, this.dieSound));
        }
        public function runAwayFailed():Anim{
            var _local1:Asset = this.assets.effectAsset(RUN_FAIL);
            var _local2:String = this.text.getText("RUN_AWAY_FAIL", {TARGET:this.model.playerMonster.name});
            var _local3:ParallelAnims = new ParallelAnims();
            _local3.add(this.log(_local2));
            _local3.add(new MonsterAnim(this.fight.playerContainer, _local1, this.fight.player));
            _local3.add(new AnimSoundEffect(this.runFailSound));
            return (_local3);
        }
        public function lose(_arg1:String):Anim{
            var _local2:ParallelAnims = new ParallelAnims();
            _local2.add(new StatusHideAnim(this.view.playerStatus));
            _local2.add(new MonsterSwapOutAnim(this.fight.player));
            _local2.add(new AnimMusic(this.loseMusic));
            _arg1 = this.text.getText(_arg1);
            var _local3:AnimStack = new AnimStack();
            _local3.push(_local2);
            _local3.push(new LoseDisplayAnim(this.fight, this.assets.loseAsset, _arg1));
            return (_local3);
        }
        public function tryToCapture():CaptureTryAnim{
            return (new CaptureTryAnim(this.fight, this.assets.tryCaptureAsset, this.captureAttemptSound));
        }
        public function captureSuccess(_arg1:MonsterModel, _arg2:Asset):Anim{
            var _local3:BattleUIStatus = this.view.npcStatus;
            var _local4:FightMonster = this.fight.npc;
            var _local5:Asset = this.monsters.monsterLarge(_arg1);
            var _local6:Asset = this.assets.captureYesAsset;
            var _local7:Asset = this.assets.captureResultAsset;
            var _local8:String = this.text.getText("CAPTURE_MESSAGE", {TARGET:_arg1.name});
            var _local9:AnimStack = new AnimStack();
            var _local10:ParallelAnims = new ParallelAnims();
            _local10.add(new StatusHideAnim(_local3));
            _local10.add(new AnimSoundEffect(this.captureSuccessSound));
            _local10.add(new CaptureSuccessAssetAnim(this.fight, _local6, _arg2, _local4));
            _local10.add(new AnimMusic(this.captureSuccessMusic));
            _local9.push(_local10);
            var _local11:Asset = this.assets.nameMonster();
            var _local12:Asset = this.assets.captureConfirm();
            var _local13:NameMonster = new NameMonster(_local11, _arg1);
            var _local14:Asset = this.assets.captureStreamIcon(_arg1.monsterID);
            var _local15 = (((this.text.getText("CAPTURE_STREAM_CONFIRM_MSG") + " ") + _arg1.name) + "!");
            var _local16:PublishCaptureFeedConfirm = new PublishCaptureFeedConfirm(_local12, _local15, _local14, _arg1);
            _local9.push(new CaptureResultAssetAnim(this.fight, _local7, _local5, _local8, this.facebook, _arg1, _local13, _local16, this.view));
            return (_local9);
        }
        public function captureFails(_arg1:Asset):Anim{
            var _local2:Asset = this.assets.captureNoAsset;
            var _local3:FightMonster = this.fight.npc;
            var _local4:ParallelAnims = new ParallelAnims();
            _local4.add(new CaptureFailAssetAnim(this.fight, _local2, _arg1, _local3));
            _local4.add(new AnimSoundEffect(this.captureFailSound));
            return (_local4);
        }
        private function damageCombatText(_arg1:DisplayObjectContainer, _arg2:AttackResultVO):Anim{
            var _local5:Anim;
            var _local3:int = _arg2.damage;
            var _local4:Boolean = _arg2.critical;
            if (!_local3){
                _local5 = new MiscSCTAnim(_arg1, this.assets.missSCT(), Timing.SCT_BLOCKS);
            } else {
                if (_local4){
                    _local5 = new DamageSCTAnim(_arg1, this.assets.criticalSCT(), _local3, Timing.SCT_BLOCKS);
                } else {
                    _local5 = new DamageSCTAnim(_arg1, this.assets.damageSCT(), _local3, Timing.SCT_BLOCKS);
                };
            };
            if (!_local4){
                return (_local5);
            };
            var _local6:ParallelAnims = new ParallelAnims();
            _local6.add(_local5);
            _local6.add(new CriticalHitAnim(this.fight.background));
            return (_local6);
        }
        public function showXP():Anim{
            var _local2:WinResultVO;
            var _local3:AnimStack;
            var _local4:ParallelAnims;
            var _local5:ParallelAnims;
            var _local6:String;
            var _local7:WinXPDisplayAnim;
            var _local1:Vector.<WinResultVO> = this.model.attack.rewards;
            for each (_local2 in _local1) {
                _local2.asset = this.monsters.monsterFightByID(_local2.moga.monsterID);
            };
            _local3 = new AnimStack();
            _local4 = new ParallelAnims();
            _local4.add(new AnimMusic(this.winMusic));
            _local4.add(new StatusHideAnim(this.view.playerStatus));
            _local4.add(new MonsterSwapOutAnim(this.fight.player));
            _local3.push(_local4);
            _local5 = new ParallelAnims();
            _local6 = this.model.attack.player.id;
            _local7 = new WinXPDisplayAnim(this.view, this.assets.winAsset, _local1, this.levelUpSound, _local6);
            _local5.add(_local7);
            _local3.push(_local5);
            _local7.share.add(this.onShareLevelUp);
            return (_local3);
        }
        private function onShareLevelUp(_arg1:uint, _arg2:int, _arg3:String, _arg4:String):void{
            var _local5:FeedStoryVO = new FeedStoryVO();
            _local5.level = _arg1;
            _local5.name = _arg3;
            _local5.id = _arg2;
            _local5.instanceId = _arg4;
            dispatch(new PostToStreamEvent(PostToStreamEvent.LEVEL_UP_MONSTER, _local5));
        }
        public function showItem():Anim{
            var _local3:Asset;
            var _local1:Object = (this.model.attack) ? this.model.attack.itemGranted : null;
            if (_local1 == null){
                return (null);
            };
            var _local2 = "1x";
            if (_local1.type == int(7)){
                _local3 = this.assets.collectionIcon(_local1.id);
            } else {
                _local3 = this.assets.itemIcon(_local1.id);
            };
            return (new WinItemAnim(this.fight, this.assets.winItemsAsset, uint(_local1), this.assets.winItemAsset, _local3, _local2, _local1.name, this.foundItem));
        }
        public function showMiniCollection():Anim{
            var _local1:Object = this.model.attack.itemGranted;
            var _local2:MogaCollectionItem = this.collectionFactory.getCollectable(_local1.id);
            var _local3:MogaCollectionVO = this.collectionFactory.getCollection(this.model.attack.collectionID.toString());
            return (new MiniCollectionAnim(this.view, this.assets.miniCollectionAsset, _local3));
        }
        public function rechargePlayer():Anim{
            var _local1:MonsterModel = this.model.playerMonster;
            var _local2:String = this.text.getText("USER_RECHARGES_MESSAGE", {TARGET:this.model.playerMonster.name});
            var _local3:int = _local1.hp;
            _local1.hp = _local1.maxHP;
            var _local4:AnimStack = new AnimStack();
            var _local5:ParallelAnims = new ParallelAnims();
            var _local6:StatusUpdateAnim = new StatusUpdateAnim(this.view.playerStatus, _local1.maxHP, false);
            _local5.add(_local6);
            _local5.add(this.updateSmallTeam(_local1));
            _local5.add(this.log(_local2));
            var _local7:MonsterAnim = new MonsterAnim(this.fight.playerContainer, this.assets.effectAsset(RECHARGE_ANIM), this.fight.player);
            _local5.add(_local7);
            _local4.push(_local5);
            _local4.push(new SetMonsterHPAnim(_local1, _local3));
            return (_local4);
        }
        private function updateSmallTeam(_arg1:MonsterModel):Anim{
            var _local2:TeamEvent = new TeamEvent(TeamEvent.UPDATE_MONSTER, _arg1);
            var _local3:Async = new AsyncDispatchEvent(eventDispatcher, _local2);
            return (new AnimAsyncWrapper(_local3));
        }
        private function updateNPCTeam(_arg1:MonsterModel):Anim{
            var _local2:NPCTeamEvent = new NPCTeamEvent(NPCTeamEvent.UPDATE_MONSTER, _arg1);
            var _local3:Async = new AsyncDispatchEvent(eventDispatcher, _local2);
            return (new AnimAsyncWrapper(_local3));
        }
        private function getAttackSound(_arg1:String):SoundProxy{
            var _local2:SoundProxy = this.sounds.getFX((("sounds/" + _arg1) + ".mp3"));
            return (_local2);
        }
        private function getHitSound(_arg1:AttackResultVO, _arg2:String):SoundProxy{
            if (_arg1.miss){
                return (this.missSound);
            };
            if (_arg1.critical){
                return (this.criticalDamageSound);
            };
            var _local3:SoundProxy = this.sounds.getFX((("sounds/" + _arg2) + "_hit.mp3"));
            return (_local3);
        }
        public function nextNPCMonster():Anim{
            var _local1:AnimStack = new AnimStack();
            var _local2:MonsterModel = this.model.npcMonster;
            var _local3:FightMonster = this.monsters.monsterFight(_local2);
            var _local4:Asset = this.assets.zodiacIcon(_local2.zodiac);
            _local3.useButt = this.model.isButtBattle;
            var _local5:Asset = this.assets.callOutAfter;
            _local5.self.scaleX = -1;
            _local5.self.x = 760;
            var _local6:ParallelAnims = new ParallelAnims();
            _local6.add(new MonsterInAnim(this.fight, _local5, _local3, this.fight.npcContainer));
            _local6.add(new StatusShowAnim(this.view.npcStatus, _local2, _local4));
            _local1.push(_local6);
            _local1.push(new SwapInNPCAnim(this.fight, _local3));
            return (_local1);
        }
        private function log(_arg1:String):Anim{
            var _local2:AsyncDispatchEvent = new AsyncDispatchEvent(eventDispatcher, new CombatLogEvent(CombatLogEvent.LOG, _arg1));
            return (new AnimAsyncWrapper(_local2));
        }
        private function combatLog(_arg1:AttackResultVO):Anim{
            var _local2:String = this.text.describeAttack(_arg1);
            return (this.log(_local2));
        }
        private function buffLog(_arg1:BuffResultVO):Anim{
            var _local2:String = this.text.describeExistingBuffResult(_arg1);
            return (this.log(_local2));
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight 
