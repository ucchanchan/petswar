//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.story.view.assets {
    import alecmce.ui.*;
    import gaia.moga.story.view.ui.*;
    import gaia.moga.story.model.*;
    import flash.text.*;
    import gaia.moga.app.*;

    public class WebStoryAssetFactory implements StoryAssetFactory {

		[Inject]
        public var config:AppConfig;
        private var speech:Speech;
        private var playerBubble:SpeechBubble;
        private var npcBubble:SpeechBubble;
        private var skip:Asset;

        public function getNPCBubble():Asset{
            return ((this.npcBubble = ((this.npcBubble) || (this.generateNPCBubble()))));
        }
        public function getPlayerBubble():Asset{
            return ((this.playerBubble = ((this.playerBubble) || (this.generatePlayerBubble()))));
        }
        public function getSkip():Asset{
            return ((this.skip = ((this.skip) || (new MovieClipAssetLoader(this.config.parseURL("assets/story/skip.swf"))))));
        }
        public function createWrapper(_arg1:String):Asset{
            _arg1 = this.config.parseURL(_arg1);
            var _local2:Asset = new MovieClipAssetLoader(_arg1);
            _local2.init();
            return (_local2);
        }
        private function generateNPCBubble():SpeechBubble{
            var _local1:String = this.config.parseURL("assets/story/npcSpeechBubble.swf");
            var _local2:Asset = new MovieClipAssetLoader(_local1);
            _local2.init();
            this.speech = ((this.speech) || (this.generateSpeech()));
            return (new SpeechBubble(_local2, this.speech));
        }
        private function generatePlayerBubble():SpeechBubble{
            var _local1:String = this.config.parseURL("assets/story/playerSpeechBubble.swf");
            var _local2:Asset = new MovieClipAssetLoader(_local1);
            _local2.init();
            this.speech = ((this.speech) || (this.generateSpeech()));
            return (new SpeechBubble(_local2, this.speech));
        }
        private function generateSpeech():Speech{
            var _local1:TextField = this.generateSpeechTextfield();
            return (new Speech(_local1, 1, 1000));
        }
        private function generateSpeechTextfield():TextField{
            var _local1:TextField = new TextField();
            _local1.width = 250;
            _local1.height = 100;
            _local1.multiline = true;
            _local1.wordWrap = true;
            _local1.embedFonts = true;
            _local1.antiAliasType = AntiAliasType.NORMAL;
            _local1.defaultTextFormat = new TextFormat("Hey Gorgeous", 12, 0);
            return (_local1);
        }
        public function createLoader(_arg1:String):StoryLoader{
            _arg1 = this.config.parseURL(_arg1);
            var _local2:WebStoryLoader = new WebStoryLoader();
            _local2.url = _arg1;
            return (_local2);
        }

    }
}//package gaia.moga.story.view.assets 
