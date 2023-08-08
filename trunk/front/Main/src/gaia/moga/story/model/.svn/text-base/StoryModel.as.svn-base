//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.story.model {
    import __AS3__.vec.*;
    import gaia.moga.story.view.ui.*;

    public class StoryModel {

        private var source:String;
        private var _assets:Vector.<StoryAsset>;
        private var _story:Vector.<StoryAction>;
        private var _map:Object;
        private var _index:int;
        private var player:StoryPlayer;
        private var useLeftArrow:Boolean;
        private var actorStaysForPlayerSpeech:Boolean;
        private var actorStaysForAnim:Boolean;
        private var npcBubbleX:int;
        private var npcBubbleY:int;
        private var playerBubbleX:int;
        private var playerBubbleY:int;
        public var canSkip:Boolean;

        private static const BACKGROUND:String = "background";
        private static const FOREGROUND:String = "foreground";
        private static const IGNORED:String = "IGNORED";
        private static const PLAYER:String = "PLAYER";

        public function StoryModel(_arg1:String){
            this.source = _arg1;
            this._assets = new Vector.<StoryAsset>();
            this._story = new Vector.<StoryAction>();
            this._map = {};
            this._index = -1;
            this.canSkip = true;
            this.init();
        }
        private function init():void{
            var _local1:Vector.<String> = this.parseLines();
            this.parseCategories(_local1);
        }
        private function parseLines():Vector.<String>{
            var _local3:String;
            var _local4:int;
            var _local5:Array;
            var _local1:Vector.<String> = Vector.<String>(this.source.split(/\R/));
            var _local2:int = _local1.length;
            while (_local2--) {
                _local3 = _local1[_local2];
                _local4 = _local3.indexOf("#");
                if (_local4 != -1){
                    _local3 = _local3.substr(0, _local4);
                };
                _local5 = _local3.match(/\s*+(.+)\s*+$/);
                if (((!(_local5)) || ((_local5.length == 0)))){
                    _local1.splice(_local2, 1);
                } else {
                    _local1[_local2] = _local5[1];
                };
            };
            return (_local1);
        }
        private function parseCategories(_arg1:Vector.<String>):void{
            var _local6:String;
            var _local7:Array;
            var _local2:int = _arg1.length;
            var _local3:String = IGNORED;
            var _local4:Vector.<String> = new Vector.<String>();
            var _local5:int;
            while (_local5 < _local2) {
                _local6 = _arg1[_local5];
                _local7 = _local6.match(/\[(.+)\]/);
                if (((!(_local7)) || ((_local7.length == 0)))){
                    _local4.push(_local6);
                } else {
                    if (_local3 != IGNORED){
                        this.parseCategory(_local3, _local4);
                    };
                    _local3 = _local7[1];
                    _local4.length = 0;
                };
                _local5++;
            };
            this.parseCategory(_local3, _local4);
        }
        private function parseCategory(_arg1:String, _arg2:Vector.<String>):void{
            var _local3:Array = _arg1.match(/([^\s\-]+)/g);
            _arg1 = _local3[0].toUpperCase();
            var _local4:String = ((_local3.length > 1)) ? _local3[1].toUpperCase() : "";
            switch (_arg1){
                case "SETTINGS":
                    this.parseSettings(_arg2);
                    break;
                case "BACKGROUND":
                    this.parseBackground(_local4, _arg2);
                    break;
                case "FOREGROUND":
                    this.parseForeground(_local4, _arg2);
                    break;
                case "PLAYER":
                    this.parsePlayer(_arg2);
                    break;
                case "CHARACTER":
                    this.parseCharacter(_local4, _arg2);
                    break;
                case "ANIM":
                    this.parseAnim(_local4, _arg2);
                    break;
                case "STORY":
                    this.parseStory(_arg2);
                    break;
            };
        }
        private function parseSettings(_arg1:Vector.<String>):void{
            var _local2:String;
            var _local3:Array;
            for each (_local2 in _arg1) {
                _local3 = _local2.match(/(\S+)\s*+(\S+)/);
                if (((!((_local3 == null))) && ((_local3.length > 1)))){
                    switch (_local3[1]){
                        case "USE_LEFT_ARROW":
                            this.useLeftArrow = (_local3[2].toLowerCase() == "yes");
                            break;
                        case "ACTOR_STAYS_FOR_PLAYER_SPEECH":
                            this.actorStaysForPlayerSpeech = (_local3[2].toLowerCase() == "yes");
                            break;
                        case "ACTOR_STAYS_FOR_ANIM":
                            this.actorStaysForAnim = (_local3[2].toLowerCase() == "yes");
                            break;
                        case "PLAYER_BUBBLE_X":
                            this.playerBubbleX = _local3[2];
                            break;
                        case "PLAYER_BUBBLE_Y":
                            this.playerBubbleY = _local3[2];
                            break;
                        case "NPC_BUBBLE_X":
                            this.npcBubbleX = _local3[2];
                            break;
                        case "NPC_BUBBLE_Y":
                            this.npcBubbleY = _local3[2];
                            break;
                        case "CAN_SKIP":
                            this.canSkip = (_local3[2].toLowerCase() == "yes");
                            break;
                    };
                };
            };
        }
        private function parseBackground(_arg1:String, _arg2:Vector.<String>):void{
            var _local3:Boolean = ((!((_arg1 == null))) && (!((_arg1 == ""))));
            var _local4:StoryBackground = new StoryBackground((_local3) ? _arg1 : BACKGROUND, _arg2[0]);
            this._map[_arg1] = _local4;
            this._assets.push(_local4);
            if (!_local3){
                this._story.push(new StoryAction(_local4, StoryCode.BACKGROUND));
            };
        }
        private function parseForeground(_arg1:String, _arg2:Vector.<String>):void{
            var _local3:Boolean = ((!((_arg1 == null))) && (!((_arg1 == ""))));
            var _local4:StoryBackground = new StoryBackground((_local3) ? _arg1 : FOREGROUND, _arg2[0]);
            this._map[_arg1] = _local4;
            this._assets.push(_local4);
            if (!_local3){
                this._story.push(new StoryAction(_local4, StoryCode.FOREGROUND));
            };
        }
        private function parsePlayer(_arg1:Vector.<String>):void{
            var _local2:String;
            var _local3:String;
            var _local4:Array;
            for each (_local3 in _arg1) {
                _local4 = _local3.match(/NAME\s*(.+)/);
                if (((!((_local4 == null))) && ((_local4.length > 1)))){
                    _local2 = _local4[1];
                };
            };
            this.player = new StoryPlayer(_local2);
            this._map[PLAYER] = this.player;
        }
        private function parseCharacter(_arg1:String, _arg2:Vector.<String>):void{
            var _local3:String;
            var _local4:String;
            var _local5:Array;
            var _local6:String;
            var _local7:StoryCharacter;
            for each (_local6 in _arg2) {
                _local5 = _local6.match(/NAME\s*(.+)/);
                if (((!((_local5 == null))) && ((_local5.length > 1)))){
                    _local3 = _local5[1];
                } else {
                    _local5 = _local6.match(/ASSET\s*(.+)/);
                    if (((!((_local5 == null))) && ((_local5.length > 1)))){
                        _local4 = _local5[1];
                    };
                };
            };
            _local7 = new StoryCharacter(_arg1, _local3, _local4);
            this._map[_arg1] = _local7;
            this._assets.push(_local7);
        }
        private function parseAnim(_arg1:String, _arg2:Vector.<String>):void{
            var _local3:String;
            var _local4:String;
            var _local5:StoryAnim;
            var _local6:Array;
            for each (_local4 in _arg2) {
                _local6 = _local4.match(/ASSET\s*(.+)/);
                if (((!((_local6 == null))) && ((_local6.length > 1)))){
                    _local3 = _local6[1];
                };
            };
            _local5 = new StoryAnim(_arg1, _local3);
            this._map[_arg1] = _local5;
            this._assets.push(_local5);
        }
        private function parseStory(_arg1:Vector.<String>):void{
            var _local5:Array;
            var _local6:String;
            var _local7:StoryAsset;
            var _local2:StorySettings = new StorySettings();
            var _local3:uint = _arg1.length;
            var _local4:int;
            while (_local4 < _local3) {
                _local5 = _arg1[_local4].match(/(\S++)\s*+(.*+)\s*+/);
                if (((!(_local5)) || ((_local5.length < 2)))){
                } else {
                    _local6 = _local5[1];
                    if (_local6 == PLAYER){
                        this.parseStoryPlayer(_local2, _local5[2]);
                    } else {
                        _local7 = this._map[_local5[1]];
                        if (!_local7){
                        } else {
                            switch (_local7.type){
                                case StoryBackground.BACKGROUND:
                                    this.parseStoryBackground(_local2, (_local7 as StoryBackground));
                                    break;
                                case StoryForeground.FOREGROUND:
                                    this.parseStoryForeground(_local2, (_local7 as StoryForeground));
                                    break;
                                case StoryCharacter.CHARACTER:
                                    this.parseStoryCharacter(_local2, (_local7 as StoryCharacter), _local5[2]);
                                    break;
                                case StoryAnim.ANIM:
                                    this.parseStoryAnim(_local2, (_local7 as StoryAnim));
                                    break;
                            };
                        };
                    };
                };
                _local4++;
            };
            this._story.push(new StoryAction(null, StoryCode.END));
        }
        private function parseStoryPlayer(_arg1:StorySettings, _arg2:String):void{
            var _local3:StoryAsset = this.player;
            var _local4:StoryAsset = _arg1.actor;
            if (((!((_local4 == null))) && (!((_local4 == this.player))))){
                if (this.actorStaysForPlayerSpeech){
                    _local3 = _arg1.actor;
                } else {
                    this._story.push(new StoryAction(_arg1.actor, StoryCode.OUT));
                };
            };
            var _local5:StoryAction = new StoryAction(this.player, StoryCode.PLAYER_TALK);
            _local5.name = (this.player as StoryPlayer).name;
            this.parseTextAction(_arg1, _local5, _arg2);
            _local5.x = this.playerBubbleX;
            _local5.y = this.playerBubbleY;
            this._story.push(_local5);
            _arg1.actor = _local3;
        }
        private function parseStoryBackground(_arg1:StorySettings, _arg2:StoryBackground):void{
            var _local3:StoryAction = new StoryAction(_arg2, StoryCode.BACKGROUND);
            _local3.replacement = _arg1.currentBackground;
            _arg1.currentBackground = _arg2;
            this._story.push(_local3);
        }
        private function parseStoryForeground(_arg1:StorySettings, _arg2:StoryForeground):void{
            var _local3:StoryAction = new StoryAction(_arg2, StoryCode.FOREGROUND);
            _local3.replacement = _arg1.currentForeground;
            _arg1.currentForeground = _local3.replacement;
            this._story.push(_local3);
        }
        private function parseStoryCharacter(_arg1:StorySettings, _arg2:StoryCharacter, _arg3:String):void{
            var _local6:StoryAction;
            var _local4 = (_arg3 == "OUT");
            var _local5:StoryAsset = _arg1.actor;
            if (_local5 != _arg2){
                if (((!((_local5 == null))) && (!((_local5 == this.player))))){
                    this._story.push(new StoryAction(_local5, StoryCode.OUT));
                };
                if (!_local4){
                    this._story.push(new StoryAction(_arg2, StoryCode.IN));
                };
            } else {
                if (_local4){
                    this._story.push(new StoryAction(_arg2, StoryCode.OUT));
                };
            };
            if (((((!((_arg3 == ""))) && (!((_arg3 == "IN"))))) && (!(_local4)))){
                _local6 = new StoryAction(_arg2, StoryCode.NPC_TALK);
                _local6.name = (_arg2 as StoryCharacter).name;
                this.parseTextAction(_arg1, _local6, _arg3);
                _local6.x = this.npcBubbleX;
                _local6.y = this.npcBubbleY;
                this._story.push(_local6);
            };
            _arg1.actor = (_local4) ? null : _arg2;
        }
        private function parseTextAction(_arg1:StorySettings, _arg2:StoryAction, _arg3:String):void{
            var _local5:int;
            var _local4:Boolean = ((this.useLeftArrow) && ((_arg1.textCount++ > 0)));
            _local5 = _arg3.indexOf("{OK}");
            if (_local5 != -1){
                _arg2.end = (_local4) ? SpeechBubbleEnd.OK : SpeechBubbleEnd.OK_WITHOUT_LEFT_ARROW;
                _arg2.text = _arg3.replace("{OK}", "");
            } else {
                _local5 = _arg3.indexOf("{ACCEPT}");
                if (_local5 != -1){
                    _arg2.end = (_local4) ? SpeechBubbleEnd.ACCEPT : SpeechBubbleEnd.ACCEPT_WITHOUT_LEFT_ARROW;
                    _arg2.text = _arg3.replace("{ACCEPT}", "");
                } else {
                    _arg2.end = (_local4) ? SpeechBubbleEnd.ARROWS : SpeechBubbleEnd.RIGHT_ARROW;
                    _arg2.text = _arg3;
                };
            };
        }
        private function parseStoryAnim(_arg1:StorySettings, _arg2:StoryAnim):void{
            var _local3:StoryAsset = _arg1.actor;
            if (((((!((_local3 == null))) && (!((_local3 == this.player))))) && (!(this.actorStaysForAnim)))){
                this._story.push(new StoryAction(_local3, StoryCode.OUT));
            };
            this._story.push(new StoryAction(_arg2, StoryCode.PLAY));
            _arg1.actor = (this.actorStaysForAnim) ? _local3 : null;
        }
        public function get assets():Vector.<StoryAsset>{
            return (this._assets);
        }
        public function back():Vector.<StoryAction>{
            var _local2:StoryAction;
            var _local3:StoryCode;
            var _local1:Vector.<StoryAction> = new Vector.<StoryAction>();
            while (--this._index >= 0) {
                _local2 = this._story[this._index];
                _local3 = _local2.code;
                if (_local3 == StoryCode.PLAY){
                } else {
                    _local1.push(_local2);
                    if ((((_local3 == StoryCode.PLAYER_TALK)) || ((_local3 == StoryCode.NPC_TALK)))){
                        break;
                    };
                };
            };
            this.removeRedundantInsAndOuts(_local1);
            return (_local1);
        }
        private function removeRedundantInsAndOuts(_arg1:Vector.<StoryAction>):void{
            var _local2:StoryAsset;
            var _local6:StoryAction;
            var _local7:StoryAsset;
            var _local8:StoryCode;
            var _local9:Boolean;
            var _local10:Boolean;
            var _local3 = -1;
            var _local4 = -1;
            var _local5:int;
            while (_local5 < _arg1.length) {
                _local6 = _arg1[_local5];
                _local7 = _local6.element;
                _local8 = _local6.code;
                _local9 = (_local8 == StoryCode.OUT);
                _local10 = (_local8 == StoryCode.IN);
                if (((!(_local9)) && (!(_local10)))){
                } else {
                    if (_local2 == _local7){
                        if (((_local9) && (!((_local3 == -1))))){
                            var _temp1 = _local5;
                            _local5 = (_local5 - 1);
                            _arg1.splice(_temp1, 1);
                            _arg1.splice(_local3, 1);
                        } else {
                            if (((_local10) && (!((_local4 == -1))))){
                                var _temp2 = _local5;
                                _local5 = (_local5 - 1);
                                _arg1.splice(_temp2, 1);
                                _arg1.splice(_local4, 1);
                            };
                        };
                    };
                    _local2 = _local7;
                    _local3 = (_local10) ? _local5 : -1;
                    _local4 = (_local9) ? _local5 : -1;
                };
                _local5++;
            };
        }
        public function iterate():StoryAction{
            if (++this._index == this._story.length){
                this._index = (this._story.length - 1);
                return (null);
            };
            return (this._story[this._index]);
        }

    }
}//package gaia.moga.story.model 
import gaia.moga.story.model.StoryAsset;
class StorySettings {

    public var actor:StoryAsset;
    public var textCount:uint;
    public var currentBackground:StoryAsset;
    public var currentForeground:StoryAsset;

    public function StorySettings(){
    }
}
