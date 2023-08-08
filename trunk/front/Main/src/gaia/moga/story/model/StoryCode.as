//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.story.model {

    public class StoryCode {

        private var id:String;

        public static const BACKGROUND:StoryCode = new StoryCode("BACKGROUND");
;
        public static const FOREGROUND:StoryCode = new StoryCode("FOREGROUND");
;
        public static const IN:StoryCode = new StoryCode("IN");
;
        public static const OUT:StoryCode = new StoryCode("OUT");
;
        public static const PLAY:StoryCode = new StoryCode("PLAY");
;
        public static const NPC_TALK:StoryCode = new StoryCode("NPC_TALK");
;
        public static const PLAYER_TALK:StoryCode = new StoryCode("PLAYER_TALK");
;
        public static const END:StoryCode = new StoryCode("END");
;

        public function StoryCode(_arg1:String){
            this.id = _arg1;
        }
        public function toString():String{
            return (this.id);
        }

    }
}//package gaia.moga.story.model 
