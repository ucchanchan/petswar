//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model {
    import org.osflash.signals.*;
    import __AS3__.vec.*;
    import org.robotlegs.mvcs.*;

    public class ApplicationModel extends Actor {

        private var _state:ApplicationState;
        private var _stateChanged:Signal;
        private var _currentTime:int;
        private var _friendRanchID:String;// = ""
        private var _userID:String;
        public var version:String;
        public var openBattleID:String;
        public var email:String;
        public var firstName:String;
        public var picture:String;
        public var thirdPartyId:String;
        public var nanniganAppId:String;
        private var special:Vector.<String>;
        public var appUrl:String;
        public var destUrl:String;
        public var gsiUrl:String;
        public var locale:String;
        public var gender:String;
        public var birthday:String;
        public var partnerID:String;
        public var friendReferral:String;
        public var promo:String;
        public var assumeFirstMonsterEntersBattle:Boolean;
        public var grantCode:String;
        public var hideSplash:Boolean;
        public var ugcEventTime:String;
        public var ugcEventHost:String;
        public var ugcMonsterId:String;
        public var defaultZodiacId:uint;
        public var defaultMonsterId:uint;
        public var defaultFriendID:String;// = ""
        public var showBasketPanel:Boolean;// = false
        public var oneTimeAnnouncements:Array;

        public static const STICKMAN:String = "stickman";
        public static const SNOW:String = "snow";
        public static const SNOWING:String = "snowing";
        public static const BUTT_FIGHT:String = "butt";

        public function ApplicationModel(){
            this._stateChanged = new Signal(ApplicationState);
            this.assumeFirstMonsterEntersBattle = false;
        }
        public function get state():ApplicationState{
            return (this._state);
        }
        public function set state(_arg1:ApplicationState):void{
            var _local2:Boolean = ((!((this._state == _arg1))) || (this.state.stateCanBeOverwrittenWithSame));
            if (!_local2){
                return;
            };
            this._state = _arg1;
            this._stateChanged.dispatch(this._state);
        }
        public function get stateChanged():Signal{
            return (this._stateChanged);
        }
        public function get currentTime():int{
            return (this._currentTime);
        }
        public function set currentTime(_arg1:int):void{
            this._currentTime = _arg1;
        }
        public function set friendRanchID(_arg1:String):void{
            this._friendRanchID = _arg1;
        }
        public function get friendRanchID():String{
            return (this._friendRanchID);
        }
        public function get userID():String{
            return (this._userID);
        }
        public function set userID(_arg1:String):void{
            this._userID = _arg1;
            this._friendRanchID = _arg1;
        }
        public function setSpecial(_arg1:String):void{
            this.special = Vector.<String>(_arg1.split(","));
        }
        public function hasSpecial(_arg1:String):Boolean{
            return (!((this.special.indexOf(_arg1) == -1)));
        }

    }
}//package com.gaiaonline.monster.model 
