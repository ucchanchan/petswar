//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model {

    public class ApplicationState {

        private var _value:String;
        private var _stateCanBeOverwrittenWithSame:Boolean;

        public static const SPLASH:ApplicationState = new ApplicationState("splash");
;
        public static const HOME:ApplicationState = new ApplicationState("home");
;
        public static const WORLD:ApplicationState = new ApplicationState("world", true);
;
        public static const BATTLE:ApplicationState = new ApplicationState("battle");
;
        public static const NEW_USER_ZODIAC:ApplicationState = new ApplicationState("newUserZodiac");
;
        public static const NEW_USER_INTRO:ApplicationState = new ApplicationState("newUserIntro");
;
        public static const FRIEND_RANCH:ApplicationState = new ApplicationState("friendRanch", true);
;
        public static const STORY_LOCATION:ApplicationState = new ApplicationState("storyLocation", true);
;
        public static const CONGRAZZLES_STORY_LOCATION:ApplicationState = new ApplicationState("congrazzlesStoryLocation");
;
        public static const NEWQUEST_STORY_LOCATION:ApplicationState = new ApplicationState("newQuestStoryLocation");
;
        public static const WIN_STORY_LOCATION:ApplicationState = new ApplicationState("winStoryLocation");
;
        public static const CAPTURE_STORY_LOCATION:ApplicationState = new ApplicationState("captureStoryLocation");
;
        public static const LOSE_STORY_LOCATION:ApplicationState = new ApplicationState("loseStoryLocation");
;

        public function ApplicationState(_arg1:String, _arg2:Boolean=false){
            this._value = _arg1;
            this._stateCanBeOverwrittenWithSame = _arg2;
        }
        public function get stateCanBeOverwrittenWithSame():Boolean{
            return (this._stateCanBeOverwrittenWithSame);
        }
        public function toString():String{
            return (this._value);
        }

    }
}//package com.gaiaonline.monster.model 
