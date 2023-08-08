//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service {
    import com.gaiaonline.monster.model.vo.*;
    import com.gaiaonline.monster.model.*;
    import gaia.moga.dex.assets.*;
    import com.gaiaonline.monster.model.world.*;
    import gaia.moga.friendlist.model.*;
    import gaia.moga.data.*;
    import com.gaiaonline.monster.model.zodiac.*;
    import com.gaiaonline.monster.view.components.battle.vo.*;
    import com.gaiaonline.monster.view.dialog.vo.*;
    import gaia.moga.capture.assets.*;
    import com.gaiaonline.monster.service.vo.*;
    import gaia.moga.data.attacks.*;
    import com.gaiaonline.monster.*;
    import org.robotlegs.mvcs.*;

    public class TextService extends Actor {

		[Inject]
        public var zodiacs:ZodiacModel;
		[Inject]
        public var data:DataBundle;
        private var miscBlurb:XML;
        private var tipsBlurb:XML;
        private var questsBlurb:XML;
        private var monsterBlurb:XML;
        private var timeBlurb:XML;
        private var modifiersBlurb:XML;
        private var _dexBundle:DexLanguageBundle;
        private var _captureBundle:CaptureLanguageBundle;

        private static const DAYS:String = "DAYS";
        private static const HOURS:String = "HOURS";
        private static const MINUTES:String = "MINUTES";
        private static const SECONDS:String = "SECONDS";
        private static const BUFF_FADES:String = "TARGET's BUFF fades.";
        private static const DEBUFF_FADES:String = "DEBUFF fades from TARGET.";

        public function describeNewBuff(_arg1:BuffVO, _arg2:MonsterModel, _arg3:MonsterModel):String{
            var xml:XMLList;
            var pattern:String;
            var tokens:Object;
            var buff = _arg1;
            var agent = _arg2;
            var target = _arg3;
            this.modifiersBlurb = ((this.modifiersBlurb) || (new XML(this.data.buffsLanguage.data)));
            xml = this.modifiersBlurb.buff.(@id == buff.id);
            if (xml.length() == 0){
                return ("");
            };
            pattern = xml[0].onapplied;
            tokens = {};
            tokens["$agent"] = agent.name;
            tokens["$target"] = target.name;
            tokens["$z"] = agent.zodiac;
            tokens["$y"] = target.zodiac;
            return (this.processText(pattern, tokens));
        }
        public function describeExistingBuffResult(_arg1:BuffResultVO):String{
            var xml:XMLList;
            var pattern:String;
            var tokens:Object;
            var result = _arg1;
            this.modifiersBlurb = ((this.modifiersBlurb) || (new XML(this.data.buffsLanguage.data)));
            xml = this.modifiersBlurb.buff.(@id == result.id);
            if (xml.length() == 0){
                return ("");
            };
            pattern = xml[0].onapplied;
            tokens = {};
            tokens["$agent"] = result.agent.name;
            tokens["$target"] = result.target.name;
            tokens["$x"] = result.value;
            tokens["$z"] = result.agent.zodiac;
            tokens["$y"] = result.target.zodiac;
            return (this.processText(pattern, tokens));
        }
        public function describeAttack(_arg1:AttackResultVO):String{
            var _local3:String;
            var _local2:AttackDataVO = this.data.attacks.getData(_arg1.attackingMove.id);
            if (_arg1.miss){
                _local3 = _local2.missText;
            } else {
                if (_arg1.critical){
                    _local3 = ((_local2.criticalText) || (_local2.hitText));
                } else {
                    if (_arg1.damage > 0){
                        _local3 = _local2.hitText;
                    } else {
                        _local3 = _local2.castText;
                    };
                };
            };
            var _local4:Object = {};
            _local4["$agent"] = _arg1.attacker.name;
            _local4["$target"] = _arg1.target.name;
            _local4["$x"] = _arg1.damage.toString();
            _local4["$z"] = _arg1.attacker.zodiac;
            _local4["$y"] = _arg1.target.zodiac;
            return (this.processText(_local3, _local4));
        }
        public function describeBuffFade(_arg1:BuffVO, _arg2:String):String{
            var _local3:String = BUFF_FADES;
            var _local4:Object = {TARGET:_arg2, BUFF:_arg1.name};
            return (this.processText(_local3, _local4));
        }
        public function describeDebuffFade(_arg1:BuffVO, _arg2:String):String{
            var _local3:String = DEBUFF_FADES;
            var _local4:Object = {TARGET:_arg2, DEBUFF:_arg1.name};
            return (this.processText(_local3, _local4));
        }
        public function get dialogButtonsLanguage():DialogButtonsLanguageVO{
            var _local1:DialogButtonsLanguageVO = new DialogButtonsLanguageVO();
            _local1.yes = this.getText("YES");
            _local1.no = this.getText("NO");
            _local1.ok = this.getText("OK");
            _local1.cancel = this.getText("CANCEL");
            return (_local1);
        }
        public function get rarityBundle():DexLanguageBundle{
            if (this._dexBundle){
                return (this._dexBundle);
            };
            this._dexBundle = new DexLanguageBundle();
            var _local1:int;
            while (_local1 < 9) {
                this._dexBundle.setRarity(_local1, this.getText(("RARITY_" + _local1)));
                _local1++;
            };
            return (this._dexBundle);
        }
        public function get captureBundle():CaptureLanguageBundle{
            if (this._captureBundle){
                return (this._captureBundle);
            };
            this._captureBundle = new CaptureLanguageBundle();
            this._captureBundle.warningTitle = this.getText("CAPTURE_LEVEL_TOO_HIGH_TITLE");
            this._captureBundle.warningBody = this.getText("CAPTURE_LEVEL_TOO_HIGH_BODY");
            this._captureBundle.noStarseeds = this.getText("CAPTURE_NO_STARSEEDS");
            this._captureBundle.alreadyHave = this.getText("CAPTURE_ALREADY_HAVE");
            this._captureBundle.insufficientDamage = this.getText("CAPTURE_INSUFFICIENT_DAMAGE");
            return (this._captureBundle);
        }
        public function getText(_arg1:String, _arg2:Object=null):String{
            var list:XMLList;
            var len:uint;
            var value:String;
            var id = _arg1;
            var replacements = _arg2;
            this.miscBlurb = ((this.miscBlurb) || (new XML(this.data.miscLanguage.data)));
            list = this.miscBlurb.blurb.(@id == id);
            len = list.length();
            if (!len){
                return ("");
            };
            list = list[0].text;
            if (!len){
                return ("");
            };
            value = list[((len == 1)) ? 0 : uint((Math.random() * len))];
            return (this.processText(value, replacements));
        }
        public function getMonsterText(_arg1:int):MonsterTextVO{
            var list:XMLList;
            var len:uint;
            var datum:XML;
            var newVO:MonsterTextVO;
            var id = _arg1;
            this.monsterBlurb = ((this.monsterBlurb) || (new XML(this.data.monstersLanguage.data)));
            list = this.monsterBlurb.monster.(@id == id);
            len = list.length();
            if (len == 0){
                return (null);
            };
            datum = list[0];
            newVO = new MonsterTextVO(datum.@name, datum.description[0]);
            return (newVO);
        }
        public function getTip(_arg1:String, _arg2:Object=null):String{
            var list:XMLList;
            var len:uint;
            var value:String;
            var id = _arg1;
            var replacements = _arg2;
            this.tipsBlurb = ((this.tipsBlurb) || (new XML(this.data.tipsLanguage.data)));
            list = this.tipsBlurb.tip.(@id == id);
            len = list.length();
            if (!len){
                return ("");
            };
            value = list[((len == 1)) ? 0 : uint((Math.random() * len))];
            return (this.processText(value, replacements));
        }
        public function getQuestText(_arg1:String, _arg2:String):String{
            var list:XMLList;
            var len:uint;
            var str:String;
            var id = _arg1;
            var prop = _arg2;
            this.questsBlurb = ((this.questsBlurb) || (new XML(this.data.questsLanguage.data)));
            list = this.questsBlurb.quest.(@id == id);
            len = list.length();
            if (!len){
                return ("");
            };
            list = list[prop];
            str = list[((len == 1)) ? 0 : uint((Math.random() * len))];
            str = str.replace(/\\n/g, "\n");
            return (str);
        }
        public function describeTime(_arg1:int, _arg2:int, _arg3:int, _arg4:int, _arg5:Boolean):String{
            var _local6:Array = [];
            if (_arg1 != -1){
                _local6.push(this.describeTimePart(DAYS, _arg1, _arg5));
            };
            if (_arg2 != -1){
                _local6.push(this.describeTimePart(HOURS, _arg2, _arg5));
            };
            if (_arg3 != -1){
                _local6.push(this.describeTimePart(MINUTES, _arg3, _arg5));
            };
            if (_arg4 != -1){
                _local6.push(this.describeTimePart(SECONDS, _arg4, _arg5));
            };
            return (_local6.join(" "));
        }
        public function describeNow():String{
            this.timeBlurb = ((this.timeBlurb) || (new XML(this.data.timeLanguage.data)));
            return (this.timeBlurb.text.(@id == "NOW").long[0]);
        }
        public function describeBuffName(_arg1:String):String{
            var list:XMLList;
            var len:uint;
            var id = _arg1;
            this.modifiersBlurb = ((this.modifiersBlurb) || (new XML(this.data.buffsLanguage.data)));
            list = this.modifiersBlurb.buff.(@id == id);
            len = list.length();
            if (!len){
                return ("");
            };
            return (list[((Math.random() * len) | 0)].name[0]);
        }
        public function describeBuffDescription(_arg1:int):String{
            var list:XMLList;
            var len:uint;
            var id = _arg1;
            this.modifiersBlurb = ((this.modifiersBlurb) || (new XML(this.data.buffsLanguage.data)));
            list = this.modifiersBlurb.buff.(@id == id);
            len = list.length();
            if (!len){
                return ("");
            };
            return (list[((Math.random() * len) | 0)].description[0]);
        }
        public function describeBuffStatus(_arg1:String):String{
            var list:XMLList;
            var len:uint;
            var id = _arg1;
            this.modifiersBlurb = ((this.modifiersBlurb) || (new XML(this.data.buffsLanguage.data)));
            list = this.modifiersBlurb.buff.(@id == id);
            len = list.length();
            if (!len){
                return ("");
            };
            return (list[((Math.random() * len) | 0)].status[0]);
        }
        private function describeTimePart(_arg1:String, _arg2:int, _arg3:Boolean):String{
            var list:XMLList;
            var tag:XML;
            var str:String;
            var key = _arg1;
            var value = _arg2;
            var short = _arg3;
            this.timeBlurb = ((this.timeBlurb) || (new XML(this.data.timeLanguage.data)));
            list = this.timeBlurb.text.(@id == key);
            tag = (short) ? list.short[0] : list.long[0];
            if (value == 1){
                str = tag.one[0];
            } else {
                if (value == 0){
                    str = tag.none[0];
                } else {
                    str = tag.many[0];
                };
            };
            return (str.replace("#N", value));
        }
        public function getZodiacEffectText(_arg1:Number, _arg2:Boolean=false, _arg3:Boolean=false):String{
            var _local4:String;
            var _local5:String;
            if (_arg1 <= 0.66){
                _local4 = "2x Less";
            } else {
                if (_arg1 <= 0.33){
                    _local4 = "Less";
                } else {
                    if (_arg1 == 1){
                        _local4 = "More";
                    } else {
                        if (_arg1 <= 1.33){
                            _local4 = "2x More";
                        } else {
                            if (_arg1 <= 1.66){
                                _local4 = "3x Super";
                            };
                        };
                    };
                };
            };
            if (!_arg2){
                _local4 = (_local4 + " Effective");
            };
            if (_arg3){
                _local5 = ((_arg1 < 1)) ? "#FF6666" : "#66CC66";
                _local4 = (((("<font color='" + _local5) + "'>") + _local4) + "</font>");
            };
            return (_local4);
        }
        public function getWhistleReportText(_arg1:MonsterModel, _arg2:Friend, _arg3:WhistleReportItemDataVO):String{
            var _local4 = (_arg3.friends.length > 1);
            var _local5:int = (_arg3.friends.length - 1);
            var _local6:String = _arg1.name.replace("\r", "");
            var _local7 = "<span class='friendName'>%friendName%</span>%otherFriendsText% %want% to call in your level %monsterLevel% %mogaType%, named %mogaName%, for a Bonus Attack!";
            _local7 = _local7.replace("%friendName%", _arg2.name);
            _local7 = _local7.replace("%otherFriendsText%", (_local4) ? ((" and <a>" + _local5) + " other friends</a>") : "");
            _local7 = _local7.replace("%want%", (_local4) ? "want" : "wants");
            _local7 = _local7.replace("%mogaType%", _arg1.defaultName);
            _local7 = _local7.replace("%monsterLevel%", (_arg3.levelUp) ? _arg3.levelUp.pre : _arg1.level);
            _local7 = _local7.replace("%mogaName%", _local6);
            return (_local7);
        }
        public function getCaptureFeedMainMessage(_arg1:String, _arg2:uint, _arg3:String):String{
            var _local4:String;
            _local4 = (((_arg3 + " just captured ") + _arg1) + " in Monster Galaxy");
            return (_local4);
        }
        public function getLevelUpFeedMainMessage(_arg1:String, _arg2:uint, _arg3:String):String{
            var _local4:String;
            _local4 = (((_arg3 + " just leveled up ") + _arg1) + " in Monster Galaxy");
            return (_local4);
        }
        public function getCaptureFeedSecondaryMessage(_arg1:String, _arg2:uint, _arg3:String, _arg4:String):String{
            var _local5:String;
            _local5 = (((((((_arg4 + " just captured a ") + _arg1) + " and named it ") + _arg3) + ". ") + _arg4) + " wants to share some Bonus Attack Whistles to call in their new Moga. First 5 to click get a free whistle.");
            return (_local5);
        }
        public function getLevelUpFeedSecondaryMessage(_arg1:String, _arg2:uint, _arg3:uint, _arg4:String):String{
            var _local5:String;
            _local5 = (((((((_arg4 + " just leveled up a ") + _arg1) + " to level ") + _arg3) + "! ") + _arg4) + " wants to share some Bonus Attack Whistles to call in their Moga. First 5 to click get a free whistle.");
            return (_local5);
        }
        public function getQuestHelpMainMessage(_arg1:String, _arg2:String):String{
            return (((("Help " + _arg1) + " with the quest: ") + _arg2));
        }
        public function getQuestHelpSecondaryMessage(_arg1:String, _arg2:String):String{
            return ((((_arg1 + " needs your help to finish the quest \"") + _arg2) + "\". Send bonus attack whistles to help and get one in return."));
        }
        public function getQuestCompleteMainMessage(_arg1:String, _arg2:String):String{
            return ((((_arg1 + " completed the quest '") + _arg2) + "'"));
        }
        public function getQuestCompleteSecondMessage(_arg1:String, _arg2:String):String{
            return ((((_arg1 + " completed the quest '") + _arg2) + "' and wants to celebrate by sharing bonus attack whistles with their friends."));
        }
        public function getStoreTeamMonsterDialog(_arg1:MonsterModel):String{
            return ((((_arg1.name + " is currently on your team. Moving ") + _arg1.name) + " to storage will take them off of the team."));
        }
        public function getLockedStorageDialog():String{
            return ("You need 20 Mogas to unlock moga storage. Capture more moga.");
        }
        public function getNonFriendBasketLinkDialog():String{
            return ("You can only give Starseeds to your friends. Invite more friends and share the love.");
        }
        public function getStarseedRequestMainMessage(_arg1:String):String{
            return ((("Help " + _arg1) + " Get Starseeds!"));
        }
        public function getStarseedRequestSecondaryMessage(_arg1:String):String{
            return ((("Help " + _arg1) + " collect more Moga by sending them a free Starseed!\n\nIf you send a starseed, maybe they'll return the favor"));
        }
        public function getStarseedGiftMainMessage(_arg1:String, _arg2:String):String{
            return ((((_arg1 + " gave ") + _arg2) + " a starseed!"));
        }
        public function getStarseedGiftSecondaryMessage(_arg1:String, _arg2:String):String{
            return ((((("{*actor*} put a Starseed in " + _arg2) + "'s starseed basket. ") + _arg2) + " can visit their ranch in Monster Galaxy to collect the starseed and capture more Moga!"));
        }
        public function getMogaStorageTooltip(_arg1:Boolean, _arg2:Boolean):String{
            if (_arg1){
                return ((_arg2) ? "Your friend has not unlocked Moga storage" : "Click to see your friend's stored Mogas");
                //unresolved jump
            };
            return ((_arg2) ? "Capture 20 Mogas to unlock storage" : "Click to manage your stored Mogas");
        }
        public function getReasonLocationIsLocked(_arg1:Location):String{
            var _local2:Location;
            var _local3:Location;
            var _local4:QuestVO;
            for each (_local2 in _arg1.requiredVisits) {
                if (!_local2.hasVisited){
                    return (("Visit " + _local2.name));
                };
            };
            for each (_local3 in _arg1.requiredVictories) {
                if (!_local3.hasWon){
                    return (("Win a battle at " + _local3.name));
                };
            };
            for each (_local4 in _arg1.requiredQuests) {
                if (!_local4.isComplete){
                    return (("Complete quest " + this.getQuestText(String(_local4.id), "name")));
                };
            };
            return (null);
        }
        public function getStarseedsToCollectText(_arg1:uint, _arg2:Boolean):String{
            if (((!(_arg2)) && ((0 < _arg1)))){
                return (((("You must be at home to collect your " + _arg1) + " Starseed") + ((1 < _arg1)) ? "s." : "."));
            };
            if (1 < _arg1){
                return ((("You have " + _arg1) + " Starseeds in your basket ready to be claimed."));
            };
            if (_arg1 == 1){
                return ("You have 1 Starseed in your basket ready to be claimed.");
            };
            return ("You don't have any Starseeds in your basket right now.");
        }
        public function processText(_arg1:String, _arg2:Object=null):String{
            if (_arg1.indexOf("RED") != -1){
                _arg1 = this.replaceColor(_arg1, "RED", Color.MESSAGE_RED);
            };
            if (_arg1.indexOf("GREEN") != -1){
                _arg1 = this.replaceColor(_arg1, "GREEN", Color.MESSAGE_GREEN);
            };
            if (_arg1.indexOf("BLUE") != -1){
                _arg1 = this.replaceColor(_arg1, "BLUE", Color.MESSAGE_BLUE);
            };
            if (_arg1.indexOf("ORANGE") != -1){
                _arg1 = this.replaceColor(_arg1, "ORANGE", Color.MESSAGE_ORANGE);
            };
            if (_arg1.indexOf("GOLD") != -1){
                _arg1 = this.replaceColor(_arg1, "GOLD", Color.MESSAGE_GOLD);
            };
            return ((_arg2) ? this.replaceTokens(_arg1, _arg2) : _arg1);
        }
        private function replaceColor(_arg1:String, _arg2:String, _arg3:uint):String{
            var _local4:RegExp = new RegExp((("^(.*?)\\{\\$" + _arg2) + " (.+?)\\}(.*?)$"), "g");
            var _local5:String = "$1<font color='#COLOR'>$2</font>$3".replace("COLOR", _arg3.toString(16));
            return (_arg1.replace(_local4, _local5));
        }
        private function replaceTokens(_arg1:String, _arg2:Object):String{
            var _local3:String;
            for (_local3 in _arg2) {
                _arg1 = _arg1.replace(_local3, _arg2[_local3]);
            };
            return (_arg1);
        }

    }
}//package com.gaiaonline.monster.service 
