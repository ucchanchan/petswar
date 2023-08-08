//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service {
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.process.*;
    import gaia.moga.collections.service.*;
    import com.gaiaonline.monster.view.components.starseedBasket.service.*;
    import gaia.lib.gsi.*;
    import gaia.moga.items.model.*;
    import com.adobe.serialization.json.*;
    import org.robotlegs.mvcs.*;
    import gaia.moga.*;
    import com.gaiaonline.serializers.*;

    public class GSIDataService extends Actor {

        private var gateway:GSIGateway;
        private var processMap:Object;
		[Inject]
        public var model:ApplicationModel;
        private var monsterActionQueue:Array;

        private static const GET_USER_DATA:uint = 6800;
        private static const GET_WORLD_DATA:uint = 6801;
        private static const TRAVEL_TO_LOCATION:uint = 6802;
        private static const GET_STORE:uint = 6803;
        private static const GET_MONSTER_DEX_DATA:uint = 6804;
        private static const HANDLE_MONSTER_ACTION:uint = 6805;
        private static const GET_FRIEND_DATA:uint = 6806;
        private static const HANDLE_QUEST:uint = 6812;
        private static const HANDLE_USER_ACTION:uint = 6815;
        private static const RANDOM_LOCATION:uint = 6809;
        private static const HANDLE_BATTLE:uint = 6810;
        private static const INIT_USER_ACTION:uint = 6816;
        private static const MAKE_PURCHASE:uint = 6820;
        private static const CREATE_UGCEVENT:uint = 6840;
        private static const GET_UGCEVENT:uint = 6841;
        private static const ATTEND_UGCEVENT:uint = 6842;
        private static const GET_COLLECTION_DATA:uint = 6846;
        private static const BATTLE_COMMAND_START_BATTLE:int = 1;
        private static const BATTLE_COMMAND_ATTACK:int = 2;
        private static const BATTLE_COMMAND_RUN_AWAY:int = 4;
        private static const BATTLE_COMMAND_USE_ITEM:int = 5;
        private static const BATTLE_COMMAND_TAP_OUT:int = 6;
        private static const BATTLE_COMMAND_TAME:int = 7;
        private static const BATTLE_COMMAND_USE_WHISTLE:int = 8;
        private static const BATTLE_COMMAND_GET_STATUS:int = 9;
        private static const INIT_USER_COMMAND_GET_ZODIACS:int = 1;
        private static const INIT_USER_COMMAND_SET_ZODIAC:int = 2;
        private static const TEAM_MONSTER_COMMAND_NAP:int = 3;
        private static const TEAM_MONSTER_COMMAND_AWAKEN:int = 4;
        private static const TEAM_MONSTER_COMMAND_RECHARGE:int = 1;
        private static const TEAM_MONSTER_COMMAND_NAME:int = 2;
        private static const TEAM_MONSTER_COMMAND_SET_STORAGE:int = 5;
        private static const ITEM_COLLECT_SYSTEM_GRANT:int = 5;
        private static const ITEM_OPEN_RIG:int = 6;
        private static const ITEM_RECURRING_GRANT:int = 8;
        private static const RECHARGE_ITEM_ID:int = 4;

        public function GSIDataService(){
            this.monsterActionQueue = [];
            super();
            this.processMap = {};
        }
        public function init(_arg1:String):void{
            this.gateway = new GSIGateway(_arg1);
            this.gateway.useNonEncodedURL = true;
            this.gateway.serializerClass = JSONSerializer;
            this.gateway.addEventListener(GSIEvent.LOADED, this.onGSILoaded);
            this.gateway.addEventListener(GSIEvent.ERROR, this.onGSIError);
        }
        public function getZodiacs(_arg1:GSIProcess, _arg2:int=0):void{
            if (this.processMap[INIT_USER_ACTION]){
                throw (new Error("cannot make multiple new-user requests"));
            };
            this.processMap[INIT_USER_ACTION] = _arg1;
            this.queue(INIT_USER_ACTION, INIT_USER_COMMAND_GET_ZODIACS, _arg2);
            this.sendqueue();
        }
        public function createUser(_arg1:GSIProcess, _arg2:uint, _arg3:uint, _arg4:String, _arg5:String, _arg6:Object):void{
            if (this.processMap[INIT_USER_ACTION]){
                throw (new Error("cannot make mutiple new-user requests"));
            };
            var _local7:String = JSON.encode([_arg2, _arg3, _arg4, _arg5]);
            var _local8:String = JSON.encode(_arg6);
            this.processMap[INIT_USER_ACTION] = _arg1;
            this.queue(INIT_USER_ACTION, INIT_USER_COMMAND_SET_ZODIAC, _local7, _local8);
            this.sendqueue();
        }
        public function getUserData(_arg1:GSIProcess):void{
            if (this.processMap[GET_USER_DATA]){
                throw (new Error("cannot make mutiple user data requests"));
            };
            this.processMap[GET_USER_DATA] = _arg1;
            this.queue(GET_USER_DATA);
            this.sendqueue();
        }
        public function getMonsterDexData(_arg1:GSIProcess):void{
            if (this.processMap[GET_MONSTER_DEX_DATA]){
                throw (new Error("cannot make multiple monster-dex data requests"));
            };
            this.processMap[GET_MONSTER_DEX_DATA] = _arg1;
            this.queue(GET_MONSTER_DEX_DATA);
            this.sendqueue();
        }
        public function getWorldData(_arg1:GSIProcess):void{
            if (this.processMap[GET_WORLD_DATA]){
                throw (new Error("cannot make multiple world data requests"));
            };
            this.processMap[GET_WORLD_DATA] = _arg1;
            this.queue(GET_WORLD_DATA);
            this.sendqueue();
        }
        public function rechargeMonster(_arg1:GSIProcess, _arg2:MonsterModel, _arg3:String, _arg4:MonsterModel):void{
            if (_arg3 == null){
                this.rechargeMonsterOutOfBattle(_arg1, _arg2);
            } else {
                this.rechargeMonsterInBattle(_arg1, _arg3, _arg2, _arg4);
            };
        }
        private function rechargeMonsterOutOfBattle(_arg1:GSIProcess, _arg2:MonsterModel):void{
            if (this.processMap[HANDLE_MONSTER_ACTION]){
                this.addToMonsterActionQueue(this.rechargeMonsterOutOfBattle, _arg1, _arg2);
            };
            var _local3:Object = {};
            _local3[_arg2.id] = {actions:[{type:TEAM_MONSTER_COMMAND_RECHARGE, item_id:RECHARGE_ITEM_ID}]};
            var _local4:String = JSON.encode(_local3);
            this.processMap[HANDLE_MONSTER_ACTION] = _arg1;
            this.queue(HANDLE_MONSTER_ACTION, _local4);
            this.sendqueue();
        }
        private function rechargeMonsterInBattle(_arg1:GSIProcess, _arg2:String, _arg3:MonsterModel, _arg4:MonsterModel):void{
            if (this.processMap[HANDLE_BATTLE]){
                throw (new Error("cannot make multiple battle command requests"));
            };
            var _local5:Object = {applies_to:_arg3.id, item_id:ItemEnum.COFFEE};
            _local5["monster_id"] = (_arg4) ? _arg4.id : _arg3.id;
            var _local6:String = JSON.encode(_local5);
            this.processMap[HANDLE_BATTLE] = _arg1;
            this.queue(HANDLE_BATTLE, _arg2, BATTLE_COMMAND_USE_ITEM, _local6);
            this.sendqueue();
        }
        public function rechargeMonsterInNap(_arg1:MonsterModel, _arg2:Boolean=true):void{
            var _local3:Object = new Object();
            var _local4:Array = [];
            var _local5:String = _arg1.id;
            _local4.push({type:TEAM_MONSTER_COMMAND_AWAKEN, item_id:RECHARGE_ITEM_ID});
            _local3["actions"] = _local4;
            var _local6:Object = new Object();
            _local6[_local5] = _local3;
            var _local7:String = JSON.encode(_local6);
            this.queue(HANDLE_MONSTER_ACTION, _local7);
            if (_arg2){
                this.sendqueue();
            };
        }
        public function awakenMonster(_arg1:MonsterModel, _arg2:Boolean=true):void{
            var _local3:Object = new Object();
            var _local4:Array = [];
            var _local5:String = _arg1.id;
            _local4.push({type:TEAM_MONSTER_COMMAND_AWAKEN});
            _local3["actions"] = _local4;
            var _local6:Object = new Object();
            _local6[_local5] = _local3;
            var _local7:String = JSON.encode(_local6);
            this.queue(HANDLE_MONSTER_ACTION, _local7);
            if (_arg2){
                this.sendqueue();
            };
        }
        public function setMonsterInNap(_arg1:MonsterModel, _arg2:Boolean=true):void{
            var _local3:Object = new Object();
            var _local4:Array = [];
            var _local5:String = _arg1.id;
            _local4.push({type:TEAM_MONSTER_COMMAND_NAP});
            _local3["actions"] = _local4;
            var _local6:Object = new Object();
            _local6[_local5] = _local3;
            var _local7:String = JSON.encode(_local6);
            this.queue(HANDLE_MONSTER_ACTION, _local7);
            if (_arg2){
                this.sendqueue();
            };
        }
        public function setTeam(_arg1:Vector.<MonsterModel>, _arg2:Boolean=true):void{
            var _local3:Array = [];
            var _local4:uint = _arg1.length;
            var _local5:int;
            while (_local5 < _local4) {
                _local3[_local5] = int(_arg1[_local5].id);
                _local5++;
            };
            var _local6:String = JSON.encode({2:_local3});
            this.queue(HANDLE_USER_ACTION, _local6);
            if (_arg2){
                this.sendqueue();
            };
        }
        public function tradeInCollection(_arg1:TradeInCollectionProcess):void{
            var _local2:Object = {14:{0:_arg1.collection.id.toString(), 1:"1"}};
            this.processMap[HANDLE_USER_ACTION] = _arg1;
            this.queue(HANDLE_USER_ACTION, JSON.encode(_local2));
            this.sendqueue();
        }
        public function giftStarseed(_arg1:GiveStarseedProcess):void{
            var _local2:String = JSON.encode({12:[_arg1.friendID]});
            this.processMap[HANDLE_USER_ACTION] = _arg1;
            this.queue(HANDLE_USER_ACTION, _local2);
            this.sendqueue();
        }
        public function collectGiftedStarseeds(_arg1:CollectStarseedsProcess):void{
            var _local2:String = JSON.encode({13:_arg1.outputData});
            this.processMap[HANDLE_USER_ACTION] = _arg1;
            this.queue(HANDLE_USER_ACTION, _local2);
            this.sendqueue();
        }
        public function harvestWhistles(_arg1:GSIProcess, _arg2:String="", _arg3:Boolean=true):void{
            var _local4:Object = {1:(_arg2) ? [_arg2] : []};
            this.processMap[HANDLE_USER_ACTION] = _arg1;
            this.queue(HANDLE_USER_ACTION, JSON.encode(_local4));
            if (_arg3){
                this.sendqueue();
            };
        }
        public function finishTutorial(_arg1:GSIProcess, _arg2:String, _arg3:Boolean=true):void{
            this.processMap[HANDLE_USER_ACTION] = _arg1;
            this.queue(HANDLE_USER_ACTION, JSON.encode({4:[_arg2]}));
            if (_arg3){
                this.sendqueue();
            };
        }
        public function waterTree(_arg1:GSIProcess, _arg2:Boolean=true):void{
            this.processMap[HANDLE_USER_ACTION] = _arg1;
            this.queue(HANDLE_USER_ACTION, JSON.encode({3:[]}));
            if (_arg2){
                this.sendqueue();
            };
        }
        public function handleUserAction(_arg1:Object, _arg2:Boolean=true):void{
            this.queue(HANDLE_USER_ACTION, _arg1);
            if (_arg2){
                this.sendqueue();
            };
        }
        public function nameMonster(_arg1:GSIProcess, _arg2:String, _arg3:int):void{
            if (this.processMap[HANDLE_MONSTER_ACTION]){
                this.addToMonsterActionQueue(this.nameMonster, _arg2, _arg3);
            };
            this.processMap[HANDLE_MONSTER_ACTION] = _arg1;
            var _local4:Object = {};
            _local4[_arg3] = {actions:[{type:TEAM_MONSTER_COMMAND_NAME, name:_arg2}]};
            var _local5:String = JSON.encode(_local4);
            this.queue(HANDLE_MONSTER_ACTION, _local5);
            this.sendqueue();
        }
        public function setMonsterStorageState(_arg1:GSIProcess, _arg2:Boolean, _arg3:String):void{
            if (this.processMap[HANDLE_MONSTER_ACTION]){
                this.addToMonsterActionQueue(this.setMonsterStorageState, _arg1, _arg2, _arg3);
            };
            this.processMap[HANDLE_MONSTER_ACTION] = _arg1;
            var _local4:Object = {};
            _local4[_arg3] = {actions:[{type:TEAM_MONSTER_COMMAND_SET_STORAGE, storage_state:uint(_arg2)}]};
            var _local5:String = JSON.encode(_local4);
            this.queue(HANDLE_MONSTER_ACTION, _local5);
            this.sendqueue();
        }
        private function addToMonsterActionQueue(_arg1:Function, ... _args):void{
            var _local3:Object = new Object();
            _local3.fn = _arg1;
            _local3.args = _args;
            this.monsterActionQueue.push(_local3);
        }
        private function processNextMonsterAction():void{
            var _local1:Object;
            if (this.monsterActionQueue.length > 0){
                _local1 = this.monsterActionQueue.shift();
                _local1.fn.apply(this, _local1.args);
            };
        }
        public function makeBasicCurrencyPurchase(_arg1:GSIProcess, _arg2:uint, _arg3:uint):void{
            var _local4:Object = {id:_arg2, type:2, currency:1};
            var _local5:String = JSON.encode(_local4);
            this.processMap[MAKE_PURCHASE] = _arg1;
            this.queue(MAKE_PURCHASE, _local5);
            this.sendqueue();
        }
        public function makePremiumCurrencyPurchase(_arg1:GSIProcess, _arg2:uint, _arg3:uint):void{
            var _local4:Object = {id:_arg2, type:2, currency:2, quantity:_arg3};
            var _local5:String = JSON.encode(_local4);
            this.processMap[MAKE_PURCHASE] = _arg1;
            this.queue(MAKE_PURCHASE, _local5);
            this.sendqueue();
        }
        public function travelToLocation(_arg1:GSIProcess, _arg2:uint):void{
            if (this.processMap[TRAVEL_TO_LOCATION]){
                throw (new Error("cannot make mulitple travel-to-location requests"));
            };
            this.processMap[TRAVEL_TO_LOCATION] = _arg1;
            this.queue(TRAVEL_TO_LOCATION, _arg2);
            this.sendqueue();
        }
        public function getFriends(_arg1:GSIProcess):void{
            if (this.processMap[GET_FRIEND_DATA]){
                throw (new Error("cannot make mulitple get-friends requests"));
            };
            this.processMap[GET_FRIEND_DATA] = _arg1;
            this.queue(GET_FRIEND_DATA);
            this.sendqueue();
        }
        public function getFriendBasketData(_arg1:GetFriendBasketData):void{
            if (this.processMap[GET_FRIEND_DATA]){
                throw (new Error("cannot make multiple get-friends requests"));
            };
            this.processMap[GET_FRIEND_DATA] = _arg1;
            this.queue(GET_FRIEND_DATA, _arg1.friendID);
            this.sendqueue();
        }
        public function getStore(_arg1:GSIProcess):void{
            if (this.processMap[GET_STORE]){
                throw (new Error("cannot make mutiple store data requests"));
            };
            this.processMap[GET_STORE] = _arg1;
            this.queue(GET_STORE);
            this.sendqueue();
        }
        public function getQuestList(_arg1:QuestDataProcess):void{
            if (this.processMap[HANDLE_QUEST]){
                throw (new Error("cannot make multiple quest list data requests"));
            };
            var _local2:Object = {1:[]};
            var _local3:String = JSON.encode(_local2);
            this.processMap[HANDLE_QUEST] = _arg1;
            this.queue(HANDLE_QUEST, _local3);
            this.sendqueue();
        }
        public function getCollectionsData(_arg1:CollectionDataProcess):void{
            if (this.processMap[GET_COLLECTION_DATA]){
                throw (new Error("cannot make multiple collection data requests"));
            };
            this.processMap[GET_COLLECTION_DATA] = _arg1;
            this.queue(GET_COLLECTION_DATA);
            this.sendqueue();
        }
        public function visitFriend(_arg1:GSIProcess, _arg2:String):void{
            this.processMap[TRAVEL_TO_LOCATION] = _arg1;
            this.queue(TRAVEL_TO_LOCATION, 0, _arg2);
            this.sendqueue();
        }
        public function startBattle(_arg1:String, _arg2:String, _arg3:Boolean=true):void{
            var _local4:Object = (_arg2) ? {monster_id:_arg2} : null;
            this.battleCommand(_arg1, BATTLE_COMMAND_START_BATTLE, _local4, _arg3);
        }
        public function attack(_arg1:String, _arg2:String, _arg3:String, _arg4:Boolean=true):void{
            var _local5:Object = {monster_id:_arg2};
            if (_arg3){
                _local5.equip_id = _arg3;
            };
            this.battleCommand(_arg1, BATTLE_COMMAND_ATTACK, _local5, _arg4);
        }
        public function runAway(_arg1:String, _arg2:String, _arg3:Boolean=true):void{
            var _local4:Object = {monster_id:_arg2};
            this.battleCommand(_arg1, BATTLE_COMMAND_RUN_AWAY, _local4, _arg3);
        }
        private function useItem(_arg1:String, _arg2:String, _arg3:String, _arg4:Boolean=true):void{
            var _local5:Object = {monster_id:_arg2, item_id:_arg3};
            this.battleCommand(_arg1, BATTLE_COMMAND_USE_ITEM, _local5, _arg4);
        }
        public function tapOut(_arg1:String, _arg2:String, _arg3:Boolean=true):void{
            var _local4:Object = {monster_id:_arg2};
            this.battleCommand(_arg1, BATTLE_COMMAND_TAP_OUT, _local4, _arg3);
        }
        public function capture(_arg1:String, _arg2:String, _arg3:String, _arg4:Boolean=true):void{
            var _local5:Object = {monster_id:_arg2, item_id:_arg3};
            this.battleCommand(_arg1, BATTLE_COMMAND_TAME, _local5, _arg4);
        }
        public function useWhistle(_arg1:String, _arg2:String, _arg3:Boolean=true):void{
            var _local4:Object = {monster_id:_arg2};
            this.battleCommand(_arg1, BATTLE_COMMAND_USE_WHISTLE, _local4, _arg3);
        }
        public function retrieveStatus(_arg1:GSIProcess, _arg2:String, _arg3:Boolean=true):void{
            this.processMap[HANDLE_BATTLE] = _arg1;
            this.battleCommand(_arg2, BATTLE_COMMAND_GET_STATUS, null, _arg3);
        }
        public function retrieveItem(_arg1:GSIProcess, _arg2:String):void{
            var _local3:Object = {5:[_arg2]};
            this.processMap[HANDLE_USER_ACTION] = _arg1;
            this.queue(HANDLE_USER_ACTION, JSON.encode(_local3));
            this.sendqueue();
        }
        public function openRIG(_arg1:GSIProcess, _arg2:int):void{
            var _local3:Object = {6:[_arg2]};
            this.processMap[HANDLE_USER_ACTION] = _arg1;
            this.queue(HANDLE_USER_ACTION, JSON.encode(_local3));
            this.sendqueue();
        }
        public function saveSetting(_arg1:int):void{
            var _local2:Object = {7:[_arg1]};
            this.queue(HANDLE_USER_ACTION, JSON.encode(_local2));
            this.sendqueue();
        }
        public function claimRecurringPrize(_arg1:GSIProcess):void{
            var _local2:Object = {8:["6"]};
            this.processMap[HANDLE_USER_ACTION] = _arg1;
            this.queue(HANDLE_USER_ACTION, JSON.encode(_local2));
            this.sendqueue();
        }
        public function autoHarvest(_arg1:GSIProcess):void{
            var _local2:Object = {10:[]};
            this.processMap[HANDLE_USER_ACTION] = _arg1;
            this.queue(HANDLE_USER_ACTION, JSON.encode(_local2));
            this.sendqueue();
        }
        public function createEvent(_arg1:int, _arg2:String, _arg3:Array):void{
            if (_arg3.length > 0){
                this.queue(CREATE_UGCEVENT, _arg1, _arg2, _arg3.toString());
            } else {
                this.queue(CREATE_UGCEVENT, _arg1, _arg2, "noxid");
            };
            this.sendqueue();
        }
        public function createDummyEvent():void{
            this.queue(CREATE_UGCEVENT, "14", 1301343002, "noxid");
            this.sendqueue();
        }
        public function post(_arg1:GSIProcess, _arg2:uint, ... _args):void{
            this.processMap[_arg2] = _arg1;
            _args.unshift(_arg2);
            this.queue.apply(this, _args);
            this.sendqueue();
        }
        public function attendEvent(_arg1:GSIProcess, _arg2:String, _arg3:String, _arg4:String):void{
            this.processMap[ATTEND_UGCEVENT] = _arg1;
            this.queue(ATTEND_UGCEVENT, _arg2, _arg3, {monster_id:_arg4});
            this.sendqueue();
        }
        private function battleCommand(_arg1:String, _arg2:int, _arg3:Object, _arg4:Boolean=true):void{
            if (_arg3){
                this.queue(HANDLE_BATTLE, _arg1, _arg2, _arg3);
            } else {
                this.queue(HANDLE_BATTLE, _arg1, _arg2);
            };
            if (_arg4){
                this.sendqueue();
            };
        }
        private function onGSILoaded(_arg1:GSIEvent):void{
            var _local2:int = _arg1.gsiMethod;
            var _local3:GSIProcess = this.processMap[_local2];
            if (_local3){
                delete this.processMap[_local2];
                _local3.response(_arg1.gsiData);
            } else {
                this.useDeprecatedLogic(_arg1);
            };
            if (_local2 == HANDLE_MONSTER_ACTION){
                this.processNextMonsterAction();
            };
        }
        private function useDeprecatedLogic(_arg1:GSIEvent):void{
            var _local4:String;
            var _local2:int = _arg1.gsiMethod;
            var _local3:Object = _arg1.gsiData;
            switch (_local2){
                case GET_STORE:
                    _local4 = GSIResponseEvent.GET_STORE_RESPONSE;
                    break;
                case HANDLE_BATTLE:
                    _local4 = GSIResponseEvent.HANDLE_BATTLE_RESPONSE;
                    break;
                case HANDLE_USER_ACTION:
                    _local4 = GSIResponseEvent.HANDLE_USER_ACTION_RESPONSE;
                    break;
                case HANDLE_MONSTER_ACTION:
                    _local4 = GSIResponseEvent.HANDLE_MONSTER_ACTION_RESPONSE;
                    break;
                case GET_MONSTER_DEX_DATA:
                    _local4 = GSIResponseEvent.GET_MONSTER_DEX_RESPONSE;
                    break;
                case INIT_USER_ACTION:
                    _local4 = GSIResponseEvent.INIT_USER_ACTION_RESPONSE;
                    break;
                case MAKE_PURCHASE:
                    _local4 = GSIResponseEvent.MAKE_PURCHASE_RESPONSE;
                    break;
                case ATTEND_UGCEVENT:
                    _local4 = GSIResponseEvent.ATTEND_UGCEVENT_RESPONSE;
                    break;
                case CREATE_UGCEVENT:
                    _local4 = GSIResponseEvent.CREATE_UGCEVENT_RESPONSE;
                    break;
                case GET_UGCEVENT:
                    _local4 = GSIResponseEvent.GET_UGCEVENT_RESPONSE;
                    break;
            };
            dispatch(new GSIResponseEvent(_local4, _local3));
        }
        private function onGSIError(_arg1:GSIEvent):void{
            var _local2:String;
            if (_arg1.gsiData){
                _local2 = "GSIError - no gsiData";
            } else {
                _local2 = ("GSIError\n\n" + JSON.encode(_arg1.gsiData));
            };
            var _local3:int = _arg1.gsiMethod;
            if (_local3 == 0){
                _local3 = Errors.GSIDATASERVICE_FAILED_BUT_DIDNT_SEND_BACK_THE_INSTIGATING_GSI_CALL;
            };
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, _local3));
        }
        private function queue(... _args):void{
            var _local2:Object = new Object();
            _args.splice(1, 0, JSON.encode(_local2));
            this.gateway.queue.apply(this.gateway, _args);
        }
        private function sendqueue(... _args):void{
            this.gateway.send.apply(this.gateway, _args);
        }

    }
}//package com.gaiaonline.monster.service 
