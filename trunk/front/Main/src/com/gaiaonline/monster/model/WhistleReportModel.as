//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model {
    import com.gaiaonline.monster.model.vo.*;
    import __AS3__.vec.*;
    import org.robotlegs.mvcs.*;

    public class WhistleReportModel extends Actor {

        public var friends:Vector.<WhistleReportFriendVO>;
        public var whistleReportItems:Vector.<WhistleReportItemDataVO>;
        private var itemManager:Object;

        public function update(_arg1:Object):void{
            var _local2:String;
            var _local3:WhistleReportFriendVO;
            if (this.friends){
                return;
            };
            this.friends = new Vector.<WhistleReportFriendVO>();
            for (_local2 in _arg1) {
                if (_local2 == "whistle_level_up"){
                } else {
                    _local3 = new WhistleReportFriendVO(_arg1[_local2], _local2, _arg1.whistle_level_up);
                    this.friends.push(_local3);
                };
            };
            this.organizeByMonster();
        }
        private function organizeByMonster():void{
            var _local2:WhistleReportFriendVO;
            var _local3:int;
            var _local4:WhistleReportMonsterVO;
            var _local5:WhistleReportItemDataVO;
            this.whistleReportItems = new Vector.<WhistleReportItemDataVO>();
            this.itemManager = {};
            var _local1:int;
            while (_local1 < this.friends.length) {
                _local2 = this.friends[_local1];
                _local3 = 0;
                while (_local3 < _local2.monsters.length) {
                    _local4 = _local2.monsters[_local3];
                    if (this.itemManager[_local4.id]){
                        this.itemManager[_local4.id].addFriend(_local2.id);
                        this.itemManager[_local4.id].addXP(_local4.xp, _local4.bonus);
                    } else {
                        _local5 = new WhistleReportItemDataVO(_local4.id, _local4.levelUp);
                        this.itemManager[_local4.id] = _local5;
                        _local5.addFriend(_local2.id);
                        _local5.addXP(_local4.xp, _local4.bonus);
                        this.whistleReportItems.push(this.itemManager[_local4.id]);
                    };
                    _local3++;
                };
                _local1++;
            };
        }
        public function reset():void{
            this.whistleReportItems = new Vector.<WhistleReportItemDataVO>();
            this.friends = new Vector.<WhistleReportFriendVO>();
        }

    }
}//package com.gaiaonline.monster.model 
