//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model {
    import flash.utils.*;
    import com.gaiaonline.monster.model.vo.*;
    import __AS3__.vec.*;
    import com.adobe.utils.*;

    public class WhistleReportFriendMonsterLinks {

        private var monsterFriendLinks:Dictionary;
        private var friendMonsterLinks:Dictionary;
        private var monsterMostUniqueFriendTable:Dictionary;
        private var _linksBuilt:Boolean;// = false

        public function WhistleReportFriendMonsterLinks(_arg1:Vector.<WhistleReportItemDataVO>){
            this.monsterFriendLinks = new Dictionary();
            this.friendMonsterLinks = new Dictionary();
            this.buildLinks(_arg1);
        }
        public function getMonstersMostUniqueFriendID(_arg1:String):String{
            return (this.monsterMostUniqueFriendTable[_arg1]);
        }
        private function buildLinks(_arg1:Vector.<WhistleReportItemDataVO>):void{
            var _local2:WhistleReportItemDataVO;
            for each (_local2 in _arg1) {
                this.buildItemMonsterFriends(_local2);
                this.buildItemFriendMonsters(_local2);
            };
            this.buildMonsterUniqueFriendTable(_arg1.length);
        }
        private function buildItemMonsterFriends(_arg1:WhistleReportItemDataVO):void{
            if (!this.monsterFriendLinks[_arg1.instanceId]){
                this.monsterFriendLinks[_arg1.instanceId] = new Array();
            };
            var _local2:Array = (this.monsterFriendLinks[_arg1.instanceId] as Array);
            var _local3:Array = _arg1.friends.join(",").split(",");
            this.monsterFriendLinks[_arg1.instanceId] = _local2.concat(_local3);
        }
        private function buildItemFriendMonsters(_arg1:WhistleReportItemDataVO):void{
            var _local2:String;
            var _local3:Array;
            for each (_local2 in _arg1.friends) {
                if (!this.friendMonsterLinks[_local2]){
                    this.friendMonsterLinks[_local2] = new Array();
                };
                _local3 = (this.friendMonsterLinks[_local2] as Array);
                _local3.push(_arg1.instanceId);
            };
        }
        private function buildMonsterUniqueFriendTable(_arg1:int):void{
            var _local3:Array;
            var _local4:int;
            var _local5:Array;
            var _local6:String;
            var _local7:int;
            this.monsterMostUniqueFriendTable = new Dictionary();
            var _local2:int;
            while (_local2 < _arg1) {
                _local3 = this.getSingleFriendMonsters();
                for each (_local4 in _local3) {
                    this.monsterMostUniqueFriendTable[_local4] = this.monsterFriendLinks[_local4][0];
                    delete this.monsterFriendLinks[_local4];
                    this.clearMonsterID(_local4);
                    _local2++;
                };
                if (_local3.length > 0){
                } else {
                    _local5 = this.getSingleMonsterFriends();
                    for each (_local6 in _local5) {
                        this.monsterMostUniqueFriendTable[this.friendMonsterLinks[_local6][0]] = _local6;
                        delete this.friendMonsterLinks[_local6];
                        this.clearFriendID(_local6);
                        _local2++;
                    };
                    if (_local5.length > 0){
                    } else {
                        _local7 = this.getFirstMonsterID();
                        if (_local7 != -1){
                            this.monsterMostUniqueFriendTable[_local7] = this.monsterFriendLinks[_local7][0];
                            this.clearFriendID(this.monsterFriendLinks[_local7]);
                            delete this.monsterFriendLinks[_local7];
                            this.clearMonsterID(_local7);
                            _local2++;
                        };
                    };
                };
            };
            this._linksBuilt = true;
        }
        private function getSingleFriendMonsters():Array{
            var _local3:*;
            var _local4:Array;
            var _local1:Array = new Array();
            var _local2:Array = DictionaryUtil.getKeys(this.monsterFriendLinks);
            for each (_local3 in _local2) {
                _local4 = (this.monsterFriendLinks[_local3] as Array);
                if (_local4.length == 1){
                    _local1.push(_local3);
                };
            };
            return (_local1);
        }
        private function clearMonsterID(_arg1:int):void{
            var _local3:String;
            var _local2:Array = DictionaryUtil.getKeys(this.friendMonsterLinks);
            for each (_local3 in _local2) {
                ArrayUtil.removeValueFromArray((this.friendMonsterLinks[_local3] as Array), _arg1);
            };
        }
        private function getSingleMonsterFriends():Array{
            var _local3:*;
            var _local4:Array;
            var _local1:Array = new Array();
            var _local2:Array = DictionaryUtil.getKeys(this.friendMonsterLinks);
            for each (_local3 in _local2) {
                _local4 = (this.friendMonsterLinks[_local3] as Array);
                if (_local4.length == 1){
                    _local1.push(_local3);
                };
            };
            return (_local1);
        }
        private function clearFriendID(_arg1:String):void{
            var _local3:String;
            var _local2:Array = DictionaryUtil.getKeys(this.monsterFriendLinks);
            for each (_local3 in _local2) {
                ArrayUtil.removeValueFromArray((this.monsterFriendLinks[_local3] as Array), _arg1);
            };
        }
        private function getFirstMonsterID():int{
            var _local1:Object;
            for (_local1 in this.monsterFriendLinks) {
                return ((_local1 as int));
            };
            return (-1);
        }

    }
}//package com.gaiaonline.monster.model 
