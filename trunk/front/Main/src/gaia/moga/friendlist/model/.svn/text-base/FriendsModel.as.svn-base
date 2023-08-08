//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.friendlist.model {
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.assets.*;
    import org.robotlegs.mvcs.*;

    public class FriendsModel extends Actor {

        public var isInited:Boolean;
        private var _friends:Vector.<Friend>;
        private var _fbFriends:Vector.<Friend>;
        private var _friendMap:Object;
        private var _whistleCount:int;
        public var me:Friend;
        private var assets:AssetService;
        public var viewOffset:uint;
        private var app:ApplicationModel;
        private var meIsSet:Boolean;
        private var fallback:String;
        private var _meCreated:Signal;

        public static const NOVA_ID:String = "100001591722543";

        public function FriendsModel(_arg1:ApplicationModel, _arg2:AssetService){
            this._friends = new Vector.<Friend>();
            this._fbFriends = new Vector.<Friend>();
            this._friendMap = {};
            this.assets = _arg2;
            this.app = _arg1;
            this.fallback = _arg2.config.parseURL("images/blankProfileImage.png");
            this._meCreated = new Signal(Friend);
        }
        public function setMe():void{
            this.me = this.generateMe(this.app, this.assets);
            this._friends.push(this.me);
            this._meCreated.dispatch(this.me);
        }
        private function generateMe(_arg1:ApplicationModel, _arg2:AssetService):Friend{
            var _local3:String = _arg1.userID;
            var _local4:String = _arg1.picture;
            if (((!(_local4)) || ((_local4 == "")))){
                _local4 = "images/blankProfileImage.png";
            };
            var _local5:Asset = _arg2.createWrapper(_local4, false);
            return (new Friend({user_id:_local3, first_name:_arg1.firstName}, _local5, this.fallback));
        }
        public function update(_arg1:Object):void{
            var _local2:String;
            var _local3:Friend;
            var _local4:Object;
            var _local5:String;
            var _local6:Asset;
            if (!this.meIsSet){
                this.setMe();
                this.meIsSet = true;
            };
            if (_arg1.error){
                eventDispatcher.dispatchEvent(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 302));
                return;
            };
            for (_local2 in _arg1) {
                _local3 = this._friendMap[_local2];
                if (!_local3){
                    _local4 = _arg1[_local2];
                    _local5 = _local4.picture;
                    if (((((!(_local5)) || ((_local5 == "")))) || (!((_local5.indexOf(".gif") == -1))))){
                        _local5 = "images/blankProfileImage.png";
                    };
                    _local6 = this.assets.createWrapper(_local5, false);
                    _local3 = new Friend(_local4, _local6, this.fallback);
                    this._whistleCount = (this._whistleCount + _local3.whistleCount);
                    this._friendMap[_local2] = _local3;
                    this._friends.push(_local3);
                    if (((!((_local2 == NOVA_ID))) && (!((_local2 == "123"))))){
                        this._fbFriends.push(_local3);
                    };
                };
            };
        }
        public function onWhistleHarvested(_arg1:int):void{
            this._whistleCount = (this._whistleCount - _arg1);
        }
        public function get whistleCount():int{
            return (this._whistleCount);
        }
        public function set whistleCount(_arg1:int):void{
            this._whistleCount = _arg1;
        }
        public function get friends():Vector.<Friend>{
            return (this._friends);
        }
        public function get fbFriends():Vector.<Friend>{
            return (this._fbFriends);
        }
        public function getFriendByID(_arg1:String):Friend{
            return (this._friendMap[_arg1]);
        }
        public function get meCreated():ISignal{
            return (this._meCreated);
        }

    }
}//package gaia.moga.friendlist.model 
