//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.tutorial {
    import flash.display.*;
    import com.gaiaonline.monster.model.vo.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.view.components.app.panel.*;
    import gaia.moga.monster.model.actions.*;
    import flash.text.*;
    import gaia.lib.assets.*;

    public class BattleTutorial extends Panel {

        private var _tutorialAsset:Asset;
        private var _complete:Signal;
        private var _monsterModel:MonsterModel;
        private var _fightMonster:Asset;
        private var _zodiacIcon:Asset;
        private var _monsterPortrait:Asset;
        private var _monsterCallOut:Asset;
        private var _numRecharges:int;
        private var _numWhistles:int;
        private var _numSeeds:int;
        private var _zodiacBackground:Asset;
        private var _track:Signal;
        private var _nameMonster:Signal;
        private var _friendPic:Asset;
        private var _friendName:String;
        private var _inviteClick:Signal;
        private var _inviteCancel:Signal;
        private var _captureShare:Signal;

        public function BattleTutorial(_arg1:BattleTutorialVO){
            this._monsterPortrait = _arg1.bundle.portrait;
            this._monsterCallOut = _arg1.bundle.large;
            this._tutorialAsset = _arg1.tutorialAsset;
            this._monsterModel = _arg1.monsterModel;
            this._fightMonster = _arg1.bundle.fight;
            this._zodiacIcon = _arg1.bundle.zodiac;
            this._numRecharges = _arg1.numRecharges;
            this._numWhistles = _arg1.numWhistles;
            this._numSeeds = _arg1.numSeeds;
            this._tutorialAsset = _arg1.tutorialAsset;
            this._zodiacBackground = _arg1.bundle.zodiacBackground;
            this._friendPic = _arg1.friendPic;
            this._friendName = _arg1.friendName;
            addChild(this._tutorialAsset.self);
            if (this._tutorialAsset.isComplete){
                this.init();
            } else {
                this._tutorialAsset.complete.addOnce(this.init);
            };
            this._complete = new Signal();
            this._track = new Signal();
            this._nameMonster = new Signal();
            this._inviteClick = new Signal();
            this._inviteCancel = new Signal();
            this._captureShare = new Signal();
        }
        public function init(_arg1:Asset=null):void{
            var _local2:Action;
            var _local3:MovieClip = MovieClip(this._tutorialAsset.content);
            _local3.gotoAndPlay(1);
            _local3.seeds.label.text = this._numSeeds;
            _local3.whistles.label.text = this._numWhistles;
            _local3.recharges.label.text = this._numRecharges;
            _local2 = this._monsterModel.actions.physicalAttack;
            if (_local2){
                _local3.buttons.bigButton1.label.text = _local2.data.name;
                _local3.buttons.bigButton1.points.text = ((_local2.quantity + "/") + _local2.max);
            };
            _local2 = this._monsterModel.actions.zodiacAttack;
            if (_local2){
                _local3.buttons.bigButton2.label.text = _local2.data.name;
                _local3.buttons.bigButton2.points.text = ((_local2.quantity + "/") + _local2.max);
            };
            _local2 = this._monsterModel.actions.buffAttack;
            if (_local2){
                _local3.buttons.bigButton3.label.text = _local2.data.name;
                _local3.buttons.bigButton3.points.text = ((_local2.quantity + "/") + _local2.max);
            };
            _local3.monsterPortrait.addChild(this._monsterPortrait.self);
            _local3.background.addChild(this._zodiacBackground);
            _local3.zodiacIcon.addChild(this._zodiacIcon);
            _local3.playerMonsterName.text = this._monsterModel.name;
            SignallingAsset(this._tutorialAsset.content).signal.add(this.onAssetSignal);
        }
        private function onAssetSignal(_arg1:Object, _arg2:Object=null):void{
            var _local4:MovieClip;
            var _local5:MovieClip;
            var _local6:TextField;
            var _local3:MovieClip = MovieClip(this._tutorialAsset.content);
            if (_arg1 == "complete"){
                this._complete.dispatch();
            } else {
                if (_arg1 == "playerMonster"){
                    _local3.monster.addChild(this._fightMonster.self);
                    if (this._fightMonster.isComplete){
                        this.animateMonster();
                    } else {
                        this._fightMonster.complete.addOnce(this.animateMonster);
                    };
                } else {
                    if (_arg1 == "introMonster"){
                        _local3.monster_fullsize.addChild(this._monsterCallOut.self);
                        _local3.text.callOutText.text = (this._monsterModel.name + ", go!");
                    } else {
                        if (_arg1 == "nameMonster"){
                            this._nameMonster.dispatch(_arg2);
                        } else {
                            if (_arg1 == "track_win_level"){
                                this._track.dispatch(_arg1);
                                _local4 = MovieClip(_local3.winMC.monster1);
                                _local4.addChild(this._fightMonster.self);
                                _local3.winMC.gotoAndPlay(1);
                            } else {
                                if (_arg1 == "inviteClick"){
                                    this._inviteClick.dispatch();
                                } else {
                                    if (_arg1 == "inviteCancel"){
                                        this._inviteCancel.dispatch();
                                    } else {
                                        if (_arg1 == "captureShare"){
                                            this._captureShare.dispatch();
                                        } else {
                                            if (_arg1 == "bonusAttack"){
                                                _local5 = MovieClip(_local3.friendTab.icon);
                                                if (this._friendPic){
                                                    _local5.addChild(this._friendPic.self);
                                                };
                                                _local6 = TextField(_local3.friendTab.message);
                                                if (this._friendName){
                                                    _local6.text = this._friendName;
                                                };
                                            } else {
                                                if (_arg1.indexOf("track") != -1){
                                                    this._track.dispatch(_arg1);
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
        }
        private function animateMonster(_arg1:Asset=null):void{
            MovieClip(this._fightMonster.content).gotoAndPlay("battleIdle");
        }
        public function continueAfterShare():void{
            var _local1:MovieClip = MovieClip(this._tutorialAsset.content);
            _local1.gotoAndPlay("captureDone");
        }
        public function get track():Signal{
            return (this._track);
        }
        public function get complete():Signal{
            return (this._complete);
        }
        public function get nameMonster():Signal{
            return (this._nameMonster);
        }
        public function get inviteClick():Signal{
            return (this._inviteClick);
        }
        public function get inviteCancel():Signal{
            return (this._inviteCancel);
        }
        public function get captureShare():Signal{
            return (this._captureShare);
        }

    }
}//package com.gaiaonline.monster.view.components.tutorial 
