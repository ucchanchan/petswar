//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model {
    import flash.display.*;
    import org.osflash.signals.*;

    public class PlayerModel {

        public var main:DisplayObjectContainer;
        private var _premiumCurrencyUpdated:Signal;
        private var _completedTutorials:Object;
        private var _premiumCurrency:int;
        public var id:String;
        public var basicCurrency:int;
        public var zodiac:uint;
        public var userBirthday:int;
        public var email:String;
        public var hasShared:Boolean;

        public static const BATTLE:String = "tut_1";
        public static const NAP:String = "tut_2";
        public static const WHISTLE:String = "tut_3";

        public function PlayerModel(){
            this._premiumCurrencyUpdated = new Signal();
            this._completedTutorials = {};
        }
        public function get premiumCurrency():int{
            return (this._premiumCurrency);
        }
        public function set premiumCurrency(_arg1:int):void{
            if (this._premiumCurrency == _arg1){
                return;
            };
            this._premiumCurrency = _arg1;
            this._premiumCurrencyUpdated.dispatch();
        }
        public function get premiumCurrencyUpdated():Signal{
            return (this._premiumCurrencyUpdated);
        }
        public function completeTutorial(_arg1:String):void{
            this._completedTutorials[_arg1] = true;
        }
        public function hasCompletedTutorial(_arg1:String):Boolean{
            return (!((this._completedTutorials[_arg1] == null)));
        }
        public function hasCompletedAllTutorials():Boolean{
            return (!((this._completedTutorials[WHISTLE] == null)));
        }

    }
}//package com.gaiaonline.monster.model 
