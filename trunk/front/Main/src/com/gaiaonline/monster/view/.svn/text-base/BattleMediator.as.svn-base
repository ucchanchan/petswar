//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
	import flash.display.*;
	import com.gaiaonline.monster.model.vo.*;
	import alecmce.ui.*;
	import com.gaiaonline.monster.model.*;
	import com.gaiaonline.monster.events.*;
	import com.gaiaonline.monster.model.world.*;
	import gaia.moga.menu.events.*;
	import gaia.moga.friendlist.model.*;
	import com.gaiaonline.monster.service.sound.*;
	import gaia.moga.data.*;
	import gaia.moga.assets.*;
	import com.gaiaonline.monster.view.components.battle.vo.*;
	import com.gaiaonline.monster.view.components.battle.ui.*;
	import gaia.moga.monster.model.actions.*;
	import gaia.moga.monster.model.*;
	import com.gaiaonline.monster.service.*;
	import gaia.moga.inventory.model.*;
	import gaia.moga.items.model.*;
	import com.gaiaonline.monster.service.vo.*;
	import gaia.lib.*;
	import com.gaiaonline.monster.model.battle.*;
	import gaia.moga.data.locations.*;
	import org.robotlegs.mvcs.*;
	import gaia.moga.gotoshop.*;
	import com.gaiaonline.monster.controller.async.*;
	
	public class BattleMediator extends Mediator {
		
		[Inject]
		public var appModel:ApplicationModel;
		[Inject]
		public var view:Battle;
		[Inject]
		public var battle:BattleModel;
		[Inject]
		public var ranch:HomeRanchModel;
		[Inject]
		public var monsters:MonsterAssetsFactory;
		[Inject]
		public var gateway:GSIDataService;
		[Inject]
		public var timer:TimerService;
		[Inject]
		public var world:WorldModel;
		[Inject]
		public var assets:AssetService;
		[Inject]
		public var inventory:InventoryModel;
		[Inject]
		public var text:TextService;
		[Inject]
		public var sounds:SoundService;
		[Inject]
		public var async:AsyncService;
		[Inject]
		public var story:StoryModel;
		[Inject]
		public var music:MusicService;
		[Inject]
		public var cookie:Cookie;
		[Inject]
		public var data:DataBundle;
		[Inject]
		public var videoAdModel:VideoAdModel;
		[Inject]
		private var soundMap:Object;
		
		public static const MOD_RESULT_RECIPIENT_OPPONENT:String = "1";
		public static const MOD_RESULT_RECIPIENT_SELF:String = "2";
		public static const MOD_TARGET_PLAYER:String = "player";
		public static const MOD_TARGET_NPC:String = "npc";
		public static const MOD_TYPE_BUFF:String = "1";
		public static const MOD_TYPE_DEBUFF:String = "2";
		public static const DELAY_AFTER_USER_ATTACK:uint = 2000;
		public static const MIN_DELAY_BEFORE_DAMAGE_ANIM:uint = 500;
		private static const CATCH_LEVEL_:String = "CATCH_LEVEL_";
		private static const UNABLE_TO_CATCH_LEVEL:String = "UNABLE_TO_CATCH_LEVEL";
		private static const UNABLE_TO_CATCH_HP:String = "UNABLE_TO_CATCH_HP";
		private static const CANNOT_TAME_MONSTER_MESSAGE:String = "CANNOT_TAME_MONSTER_MESSAGE";
		private static const YOU_ALREADY_HAVE_MOGA_SINGLE:String = "YOU_ALREADY_HAVE_MOGA_SINGLE";
		private static const YOU_ALREADY_HAVE_MOGA_MANY:String = "YOU_ALREADY_HAVE_MOGA_MANY";
		public static const BG_MUSIC:String = "BG_MUSIC";
		
		override public function onRegister():void{
			mediatorMap.createMediator(this.view.log);
			eventDispatcher.addEventListener(FightEvent.FRIEND_HELP, this.friendHelp);
			eventDispatcher.addEventListener(FightEvent.UPDATE_VIEW_STATE, this.onUpdateBattleViewState);
			eventDispatcher.addEventListener(MenuEvent.DEX, this.gotoDex);
			eventDispatcher.addEventListener(MenuEvent.QUEST, this.openQuests);
			eventDispatcher.addEventListener(VideoAdEvent.END_AD, this.onEndAd);
			eventDispatcher.addEventListener(SettingsEvent.QUALITY_CHANGED, this.onSettingsQualityChanged);
			this.view.setQuality(this.cookie.getValue("APP_QUALITY"));
			this.updateBattleState(this.battle.state);
			this.battle.stateChanged.add(this.updateBattleState);
			this.battle.estimatesUpdated.add(this.onEstimateUpdated);
			this.onEstimateUpdated();
			this.battle.playerRecharged.add(this.onPlayerRecharged);
			this.view.circle.add(this.onCircle);
			this.view.attack.add(this.onAttack);
			this.view.callFriend.add(this.onFriendCalled);
			this.view.runAway.add(this.onRunAwayClicked);
			this.view.useItem.add(this.onItemSelected);
			this.view.capture.add(this.onCapture);
			this.view.items = this.inventory.items;
			this.inventory.added.add(this.onAddItem);
			this.view.whistles = this.inventory.getItem(ItemEnum.WHISTLE);
			this.updateMonster(this.battle.playerMonster);
			if (this.battle.playerMonster){
				this.setBuffs(this.battle.playerMonster, this.view.playerStatus);
			};
			this.setBuffs(this.battle.npcMonster, this.view.npcStatus);
			this.view.npcStatus.buffList.buffRollOver.add(this.onBuffIconRollOver);
			this.view.playerStatus.buffList.buffRollOver.add(this.onBuffIconRollOver);
			if (this.battle.isRetrievedBattle){
				if (this.battle.state == BattleState.CHOOSE_NEXT_MONSTER){
					this.view.state = BattleViewState.CHOOSE_NEXT_MONSTER;
				} else {
					this.view.state = BattleViewState.PLAYER_TURN;
				};
			} else {
				this.view.state = BattleViewState.BLANK;
			};
			if (((this.battle.npc) && ((this.battle.npc.id > 0)))){
				this.view.addNPCTeam();
			};
			this.setTips();
			this.setSounds();
		}
		override public function onRemove():void{
			mediatorMap.removeMediatorByView(this.view.log);
			eventDispatcher.removeEventListener(FightEvent.FRIEND_HELP, this.friendHelp);
			eventDispatcher.removeEventListener(FightEvent.UPDATE_VIEW_STATE, this.onUpdateBattleViewState);
			eventDispatcher.removeEventListener(MenuEvent.DEX, this.gotoDex);
			eventDispatcher.removeEventListener(MenuEvent.QUEST, this.openQuests);
			eventDispatcher.removeEventListener(SettingsEvent.QUALITY_CHANGED, this.onSettingsQualityChanged);
			this.clearSounds();
			this.clearTips();
			this.battle.stateChanged.remove(this.updateBattleState);
			this.battle.conclude();
			this.view.sound.removeAll();
			this.view.circle.removeAll();
			this.view.attack.removeAll();
			this.view.callFriend.removeAll();
			this.view.runAway.removeAll();
			this.view.useItem.removeAll();
			this.view.capture.removeAll();
			this.inventory.added.remove(this.onAddItem);
		}
		private function onSettingsQualityChanged(_arg1:SettingsEvent):void{
			this.view.setQuality(_arg1.value);
		}
		private function setBuffs(_arg1:MonsterModel, _arg2:BattleUIStatus):void{
			var _local4:BuffCountVO;
			var _local5:Asset;
			var _local6:DisplayObject;
			if (!_arg1){
				return;
			};
			var _local3:Boolean;
			for each (_local4 in _arg1.buffCounts) {
				_local3 = true;
				_local5 = this.assets.buffIcon(_local4.buff.icon);
				_local6 = _local5.self;
				if (!_arg2.buffList.add(_local4.buff, _local5)){
					_local6.parent.removeChild(_local6);
				};
			};
			if (!_local3){
				_arg2.buffList.clear();
			};
		}
		private function onBuffIconRollOver(_arg1:BuffList, _arg2:BuffVO, _arg3:BuffListItem):void{
			var _local4:String = this.text.describeBuffStatus(_arg2.id);
			var _local5:String = this.text.describeBuffName(_arg2.id);
			_arg1.showBuffDescription(_arg3, _local5, _local4);
		}
		private function setTips():void{
			dispatch(new ToolTipEvent(ToolTipEvent.ADD_TOOLTIP, this.view.playerStatus.hintTarget, this.text.getTip("BATTLE_HP")));
			dispatch(new ToolTipEvent(ToolTipEvent.ADD_TOOLTIP, this.view.npcStatus.hintTarget, this.text.getTip("BATTLE_ENEMY")));
		}
		private function clearTips():void{
			dispatch(new ToolTipEvent(ToolTipEvent.REMOVE_TOOLTIP, this.view.playerStatus.hintTarget));
			dispatch(new ToolTipEvent(ToolTipEvent.REMOVE_TOOLTIP, this.view.npcStatus.hintTarget));
		}
		private function setSounds():void{
			var _local1:LocationDataVO = this.data.locations.getData(this.world.currentLocation.id);
			this.music.loadAndPlay(_local1.music);
			this.soundMap = {};
			this.soundMap[Battle.BEGIN_BATTLE] = this.sounds.getFX("sounds/battle_start.mp3");
			this.view.sound.add(this.playSound);
		}
		private function playSound(_arg1:String):void{
			var _local2:SoundProxy = this.soundMap[_arg1];
			if (_local2){
				_local2.play();
			};
		}
		private function clearSounds():void{
			var _local1:SoundProxy;
			for each (_local1 in this.soundMap) {
				_local1.dispose();
			};
			this.soundMap = null;
			this.view.sound.removeAll();
		}
		private function onAddItem(_arg1:InventoryItem):void{
			this.view.addItem(_arg1);
		}
		private function onUpdateBattleViewState(_arg1:FightEvent):void{
			this.view.state = _arg1.data;
		}
		private function onItemSelected(_arg1:InventoryItem):void{
			dispatch(new TeamEvent(TeamEvent.DISABLE_SMALLTEAM));
			switch (_arg1.type.id){
				case ItemEnum.SEED:
					this.showCaptureDialog();
					break;
				case ItemEnum.COFFEE:
					dispatch(new TeamEvent(TeamEvent.RECHARGE_MONSTER, this.battle.playerMonster));
					break;
				case ItemEnum.WHISTLE:
					dispatch(new BattleActionEvent(BattleActionEvent.USE_WHISTLE));
					break;
				default:
					dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 136));
					break;
			};
		}
		private function onRunAwayClicked(_arg1=null):void{
			dispatch(new TeamEvent(TeamEvent.DISABLE_SMALLTEAM));
			dispatch(new BattleActionEvent(BattleActionEvent.RUN_AWAY));
		}
		private function onFriendCalled(_arg1=null):void{
			dispatch(new TeamEvent(TeamEvent.DISABLE_SMALLTEAM));
			dispatch(new BattleActionEvent(BattleActionEvent.USE_WHISTLE));
		}
		private function onCircle(_arg1:BattleViewState):void{
			dispatch(new TeamEvent(TeamEvent.DISABLE_SMALLTEAM));
			switch (_arg1){
				case BattleViewState.BEFORE_BATTLE_STARTS:
					this.async.push(new AsyncDispatchEvent(eventDispatcher, new BattleActionEvent(BattleActionEvent.START_BATTLE)));
					break;
				case BattleViewState.CHOOSE_NEXT_MONSTER:
				case BattleViewState.ENEMY_TURN:
				case BattleViewState.PENDING:
				case BattleViewState.PLAYER_TURN:
					if (this.isCatchable()){
						this.showCaptureDialog();
					};
					break;
			};
		}
		private function showCaptureDialog():void{
			var _local7:String;
			var _local1:MonsterModel = this.battle.npcMonster;
			var _local2:Boolean = ((_local1) && (_local1.canTame));
			var _local3:MogaType = this.ranch.getMogaType(_local1.monsterID);
			var _local4:uint = (_local3) ? _local3.count : 0;
			var _local5:int = (_local2) ? this.battle.catchPercentage : 0;
			var _local6:String = _local1.name;
			if (!_local2){
				_local7 = this.text.getText(CANNOT_TAME_MONSTER_MESSAGE, {MONSTER:_local6});
			} else {
				if (_local5 > 0){
					_local7 = this.text.getText((CATCH_LEVEL_ + this.battle.rarity), {MONSTER:_local6});
					if (_local4 == 1){
						_local7 = ((this.text.getText(YOU_ALREADY_HAVE_MOGA_SINGLE, {COUNT:_local4, MONSTER:_local6}) + "\n") + _local7);
					} else {
						if (_local4 > 1){
							_local7 = ((this.text.getText(YOU_ALREADY_HAVE_MOGA_MANY, {COUNT:_local4, MONSTER:_local6}) + "\n") + _local7);
						};
					};
				} else {
					if ((this.battle.npcMonster.level - this.battle.playerMonster.level) > 2){
						_local7 = this.text.getText(UNABLE_TO_CATCH_LEVEL);
					} else {
						_local7 = this.text.getText(UNABLE_TO_CATCH_HP);
					};
				};
			};
			this.view.showCaptureDialog(_local4, _local5, _local7, _local2);
		}
		private function onCapture(_arg1:Boolean):void{
			if (!_arg1){
				dispatch(new TeamEvent(TeamEvent.ENABLE_SMALLTEAM));
				return;
			};
			if (this.inventory.getItem(ItemEnum.SEED).quantity > 0){
				dispatch(new BattleActionEvent(BattleActionEvent.TRY_TO_CAPTURE, ItemEnum.SEED));
			} else {
				dispatch(new GotoShopEvent(GotoShopEvent.OUT_OF_SEEDS));
			};
		}
		private function onAttack(_arg1:Action):void{
			this.battle.pendingActionType = _arg1.type;
			dispatch(new TeamEvent(TeamEvent.DISABLE_SMALLTEAM));
			dispatch(new BattleActionEvent(BattleActionEvent.ATTACK, _arg1));
		}
		private function updateBattleState(_arg1:BattleState):void{
			this.view.canCapture = this.isCatchable();
			switch (_arg1){
				case BattleState.INPUT:
					this.view.state = BattleViewState.PLAYER_TURN;
					break;
				case BattleState.FORCED_SWAP_MONSTER:
					this.updateMonster(this.battle.playerMonster);
					this.view.state = BattleViewState.PLAYER_TURN;
					break;
				case BattleState.SWAP_MONSTER_PENDING:
					this.view.state = BattleViewState.BLANK;
					break;
				case BattleState.SWAP_MONSTER:
					this.updateMonster(this.battle.playerMonster);
					this.view.state = BattleViewState.ENEMY_TURN;
					break;
				case BattleState.SET_FIRST_MONSTER_PENDING:
				case BattleState.CHOOSE_NEXT_MONSTER_PENDING:
				case BattleState.FORCED_SWAP_MONSTER_PENDING:
					this.view.state = BattleViewState.BLANK;
					break;
				case BattleState.SET_FIRST_MONSTER:
					this.updateMonster(this.battle.playerMonster);
					this.view.state = BattleViewState.BEFORE_BATTLE_STARTS;
					break;
				case BattleState.CHOOSE_NEXT_MONSTER:
					this.view.state = BattleViewState.CHOOSE_NEXT_MONSTER;
					break;
				case BattleState.CHOOSE_NEXT_MONSTER_SHOWN:
					this.updateMonster(this.battle.playerMonster);
					this.view.state = BattleViewState.ENEMY_TURN;
					break;
				case BattleState.NPC_SWAP:
					this.view.state = BattleViewState.ENEMY_TURN;
					break;
				case BattleState.END:
					this.concludeBattle();
					break;
				case BattleState.ATTACK_PENDING:
				case BattleState.RECHARGE_MONSTER:
				case BattleState.RECHARGE_MONSTER_PENDING:
				case BattleState.CAPTURE_MONSTER_PENDING:
					this.view.state = BattleViewState.PLAYER_ANIM;
					break;
				case BattleState.BEFORE_BATTLE_HAS_STARTED:
					this.checkForVideoAd();
					break;
				default:
					this.view.state = BattleViewState.PENDING;
			};
		}
		private function checkForVideoAd():void{
			if (this.videoAdModel.canShowAd()){
				dispatch(new VideoAdEvent(VideoAdEvent.SHOW_AD));
			} else {
				this.view.state = BattleViewState.BEFORE_BATTLE_STARTS;
			};
		}
		private function onEndAd(_arg1:VideoAdEvent):void{
			this.view.state = BattleViewState.BEFORE_BATTLE_STARTS;
		}
		private function concludeBattle():void{
			this.view.state = BattleViewState.PENDING;
		}
		private function isCatchable():int{
			var _local1:MonsterModel = this.battle.npcMonster;
			if (((!(_local1)) || (!(_local1.canTame)))){
				return (0);
			};
			return (this.battle.catchPercentage);
		}
		private function updateMonster(_arg1:MonsterModel):void{
			if (this.view.monster == _arg1){
				return;
			};
			this.view.monster = _arg1;
			if (_arg1.actions.zodiacAttack){
				this.view.zodiacIcon = this.assets.zodiacIcon(_arg1.actions.zodiacAttack.zodiacId);
			};
			if (_arg1.actions.buffAttack){
				this.view.buffIcon = this.assets.buffIcon(_arg1.actions.buffAttack.details.mod_props.icon_id);
			};
			this.view.canCapture = this.isCatchable();
		}
		private function onEstimateUpdated():void{
			var _local7:Object;
			var _local8:Object;
			var _local9:Object;
			var _local10:Object;
			var _local1:MonsterModel = this.battle.playerMonster;
			if (!_local1){
				return;
			};
			var _local2:AttackHintsVO = new AttackHintsVO();
			var _local3:AttackEstimatesVO = this.battle.getEstimates(_local1.id);
			var _local4:AttackEstimateVO = _local3.physical;
			if (_local4){
				_local7 = {"#MIN":_local4.minDamage, "#MAX":_local4.maxDamage, "#CHANCE":_local4.chance};
				_local2.physicalTitle = this.text.getTip("PHYSICAL_ATTACK_TITLE");
				_local2.physicalMain = this.text.getTip("PHYSICAL_ATTACK_MAIN", _local7);
				_local2.physicalOut = this.text.getTip("PHYSICAL_ATTACK_OUT");
			};
			var _local5:AttackEstimateVO = _local3.zodiac;
			if (_local5){
				_local8 = {"#MIN":_local5.minDamage, "#MAX":_local5.maxDamage, "#CHANCE":_local5.chance};
				_local2.zodiacTitle = this.text.getTip("ZODIAC_ATTACK_TITLE");
				_local2.zodiacMain = this.text.getTip("ZODIAC_ATTACK_MAIN", _local8);
				_local2.zodiacMod = this.text.getZodiacEffectText(_local5.zodiacMod);
				_local2.zodiacOut = this.text.getTip("ZODIAC_ATTACK_OUT");
				_local2.playerZodiacIcon = this.assets.zodiacIcon(this.battle.playerMonster.zodiac);
				_local2.npcZodiacIcon = this.assets.zodiacIcon(this.battle.npcMonster.zodiac);
			};
			var _local6:AttackEstimateVO = _local3.bonus;
			if (_local6){
				_local9 = {"#MIN":_local6.minDamage, "#MAX":_local6.maxDamage, "#CHANCE":_local6.chance};
				_local2.bonusTitle = this.text.getTip("BONUS_ATTACK_TITLE");
				_local2.bonusMain = this.text.getTip("BONUS_ATTACK_MAIN", _local9);
				_local2.bonusOut = this.text.getTip("BONUS_ATTACK_OUT");
			};
			if (_local1.actions.buffAttack){
				_local10 = {DESCRIPTION:this.text.describeBuffDescription(_local1.actions.buffAttack.details.mod)};
				_local2.buffTitle = this.text.getTip("BUFF_ATTACK_TITLE");
				_local2.buffMain = this.text.getTip("BUFF_ATTACK_MAIN", _local10);
				_local2.buffOut = this.text.getTip("BUFF_ATTACK_OUT");
			};
			this.view.updateAttackHints(_local2);
		}
		private function friendHelp(_arg1:FightEvent):void{
			var _local2:Friend = this.battle.friend;
			_local2.picture.init();
			this.view.friend.show(_local2.picture, _local2.name);
		}
		private function gotoDex(_arg1:MenuEvent):void{
			dispatch(new DexEvent(DexEvent.OPEN_DEX));
		}
		private function openQuests(_arg1:MenuEvent):void{
			//dispatch(new ApplicationEvent(ApplicationEvent.INVOKE_QUEST));
		}
		private function onPlayerRecharged(_arg1:MonsterModel):void{
			this.view.playerStatus.setHp(_arg1.hp, _arg1.maxHP);
		}
		
	}
}//package com.gaiaonline.monster.view 
