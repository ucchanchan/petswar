//Created by Action Script Viewer - http://www.buraks.com/asv
package com.omniture {
    import flash.utils.*;

    public dynamic class ActionSource_Module_Media {

        private var autoTrackDone:Boolean;// = false
        public var playerName:String;
        public var trackVars:String;
        private var list:Object;
        private var monitorList:Array;
        public var trackWhilePlaying:Boolean;// = false
        public var trackMilestones:String;// = ""
        public var trackSeconds:Number;// = 0
        private var autoTrackInterval:Number;
        public var trackEvents:String;
        private var _autoTrack:Boolean;// = false
        private var s:Object;

        public function ActionSource_Module_Media(_arg1:Object){
            var _local2:Object;
            trackWhilePlaying = false;
            trackSeconds = 0;
            trackMilestones = "";
            _autoTrack = false;
            autoTrackDone = false;
            super();
            _local2 = this;
            _local2.s = _arg1;
            _local2.monitorList = null;
        }
        public function listenerMedia_scrubbing(_arg1){
            this.listenerMedia.scrubbing(_arg1);
        }
        public function stop(_arg1:String, _arg2:Number){
            this.event(_arg1, 2, _arg2);
        }
        public function listenerBrightcove_seek(_arg1){
            this.listenerBrightcove.seek(_arg1);
        }
        public function doAutoTrack(){
            var _local1:Object;
            _local1 = this;
            if (((!(_local1.s.isSet(_local1.s.account))) || (!(_local1.s.isSet(_local1.s.movie))))){
                return;
            };
            clearInterval(_local1.autoTrackInterval);
            if (((_local1._autoTrack) && (!(_local1.autoTrackDone)))){
                if (_local1.attach(_local1.s.movie)){
                    _local1.autoTrackDone = true;
                } else {
                    _local1.autoTrackInterval = _local1.s.setupInterval(this, "doAutoTrack", 1000, null);
                };
            };
        }
        public function listenerMedia_click(_arg1){
            this.listenerMedia.click(_arg1);
        }
        private function event(_arg1:String, _arg2:Number, _arg3:Number){
            var _local4:Object;
            var _local5:Object;
            var _local6:Date;
            var _local7:Number;
            var _local8:Number;
            var _local9:String;
            var _local10:Array;
            var _local11:Number;
            var _local12:String;
            var _local13:Boolean;
            var _local14:String;
            var _local15:String;
            var _local16:String;
            var _local17:String;
            var _local18:String;
            var _local19:Object;
            _local4 = this;
            _local6 = new Date();
            _local7 = Math.floor((_local6.getTime() / 1000));
            _local8 = _local4.trackSeconds;
            _local9 = _local4.trackMilestones;
            _local12 = "--**--";
            _local13 = true;
            _local14 = null;
            _local15 = _local4.trackVars;
            _local16 = _local4.trackEvents;
            _local17 = "media";
            _local19 = new Object();
            _arg1 = _local4.cleanName(_arg1);
            _local5 = (((((_local4.s.isSet(_arg1)) && (_local4.s.isSet(_local4.list)))) && (_local4.s.isSet(_local4.list[_arg1])))) ? _local4.list[_arg1] : null;
            if (_local4.s.isSet(_local5)){
                _local19.name = _arg1;
                _local19.length = _local5.length;
                _local19.playerName = _local5.playerName;
                if (_local5.lastTrackOffset < 0){
                    _local19.event = "OPEN";
                } else {
                    _local19.event = ((_arg2 == 1)) ? "PLAY" : ((_arg2 == 2)) ? "STOP" : ((_arg2 == 3)) ? "MONITOR" : "CLOSE";
                };
                _local19.openTime = new Date();
                _local19.openTime.setTime((_local5.timestamp * 1000));
                if ((((_arg2 > 2)) || (((!((_arg2 == _local5.lastEventType))) && (((!((_arg2 == 2))) || ((_local5.lastEventType == 1)))))))){
                    _local14 = ("Media." + _arg1);
                    _local18 = (((((("" + escape(_local5.name)) + _local12) + _local5.length) + _local12) + escape(_local5.playerName)) + _local12);
                    if (_local4.s.isSet(_arg2)){
                        if ((((_arg3 < 0)) && ((_local5.lastEventTimestamp > 0)))){
                            _arg3 = ((_local7 - _local5.lastEventTimestamp) + _local5.lastEventOffset);
                            _arg3 = ((_arg3 < _local5.length)) ? _arg3 : (_local5.length - 1);
                        };
                        _arg3 = Math.floor(_arg3);
                        if ((((_arg2 >= 2)) && ((_local5.lastEventOffset < _arg3)))){
                            _local5.timePlayed = (_local5.timePlayed + (_arg3 - _local5.lastEventOffset));
                            _local5.timePlayedSinseTrack = (_local5.timePlayedSinseTrack + (_arg3 - _local5.lastEventOffset));
                        };
                        if (_arg2 <= 2){
                            _local5.session = (_local5.session + (((_arg2 == 1)) ? "S" : "E" + _arg3));
                            _local5.lastEventType = _arg2;
                        } else {
                            if (_local5.lastEventType != 1){
                                _local4.event(_arg1, 1, _arg3);
                            };
                        };
                        _local5.lastEventTimestamp = _local7;
                        _local5.lastEventOffset = _arg3;
                        _local18 = (_local18 + ((((((("" + _local5.timePlayed) + _local12) + _local5.timestamp) + _local12) + (((_local4.s.isSet(_local4.trackWhilePlaying)) && ((_local5.lastTrackOffset >= 0)))) ? ("L" + _local5.lastTrackOffset) : "") + _local5.session) + ((_arg2)!=2) ? ((_local4.s.isSet(_local4.trackWhilePlaying)) ? "L" : "E" + _arg3) : ""));
                        if (_local4.s.isSet(_local4.trackWhilePlaying)){
                            _local14 = null;
                            _local17 = "m_o";
                            if (_arg2 != 4){
                                _local19.offset = _arg3;
                                _local19.percent = (((_local19.offset + 1) / _local19.length) * 100);
                                _local19.percent = ((_local19.percent > 100)) ? 100 : Math.floor(_local19.percent);
                                _local19.timePlayed = _local5.timePlayed;
                                if (_local4.s.isSet(_local4.monitor)){
                                    _local4.monitor(_local4.s, _local19);
                                };
                            };
                            if (_local5.lastTrackOffset < 0){
                                _local17 = "m_s";
                            } else {
                                if (_arg2 == 4){
                                    _local17 = "m_i";
                                } else {
                                    _local13 = false;
                                    _local16 = "None";
                                    _local15 = _local16;
                                    _local8 = (_local4.s.isSet(_local8)) ? parseInt(("" + _local8)) : 0;
                                    _local10 = (_local4.s.isSet(_local9)) ? _local9.split(",") : null;
                                    if (((_local4.s.isSet(_local8)) && ((_local5.timePlayedSinseTrack >= _local8)))){
                                        _local13 = true;
                                    } else {
                                        if (_local4.s.isSet(_local10)){
                                            if (_arg3 < _local5.lastTrackOffset){
                                                _local5.lastTrackOffset = _arg3;
                                            } else {
                                                _local11 = 0;
                                                while (_local11 < _local10.length) {
                                                    _local8 = (_local4.s.isSet(_local10[_local11])) ? parseInt(("" + _local10[_local11])) : 0;
                                                    if (((((_local4.s.isSet(_local8)) && ((((_local5.lastTrackOffset + 1) / _local5.length) < (_local8 / 100))))) && ((((_arg3 + 1) / _local5.length) >= (_local8 / 100))))){
                                                        _local13 = true;
                                                        _local11 = _local10.length;
                                                    };
                                                    _local11++;
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    } else {
                        _local4.event(_arg1, 2, -1);
                        if (_local4.s.isSet(_local4.trackWhilePlaying)){
                            _local19.offset = _local5.lastEventOffset;
                            _local19.percent = (((_local19.offset + 1) / _local19.length) * 100);
                            _local19.percent = ((_local19.percent > 100)) ? 100 : Math.floor(_local19.percent);
                            _local19.timePlayed = _local5.timePlayed;
                            if (_local4.s.isSet(_local4.monitor)){
                                _local4.monitor(_local4.s, _local19);
                            };
                        };
                        _local4.list[_arg1] = 0;
                        if (_local4.s.isSet(_local5.session)){
                            _local18 = (_local18 + (((((("" + _local5.timePlayed) + _local12) + _local5.timestamp) + _local12) + (((_local4.s.isSet(_local4.trackWhilePlaying)) && ((_local5.lastTrackOffset >= 0)))) ? ("L" + _local5.lastTrackOffset) : "") + _local5.session));
                            if (_local4.s.isSet(_local4.trackWhilePlaying)){
                                _local16 = "None";
                                _local15 = _local16;
                                _local17 = "m_o";
                            } else {
                                _local13 = false;
                                _local4.s.flushBufferedRequest(_local4.s.account, _local14);
                            };
                        } else {
                            _local13 = false;
                        };
                        _local14 = null;
                    };
                    if (_local13){
                        _local4.s.track({linkTrackVars:_local15, linkTrackEvents:_local16, pe:_local17, pev3:_local18}, _local14);
                        if (_local4.s.isSet(_local4.trackWhilePlaying)){
                            _local5.timePlayedSinseTrack = 0;
                            _local5.lastTrackOffset = _arg3;
                            _local5.session = "";
                        };
                    };
                };
            };
        }
        public function listenerMedia_complete(_arg1){
            this.listenerMedia.complete(_arg1);
        }
        public function listenerFLVPlayback_complete(_arg1){
            this.listenerFLVPlayback.complete(_arg1);
        }
        public function variableOverridesApply(_arg1:Object){
            var _local2:Object;
            var _local3:String;
            _local2 = this;
            for (_local3 in _arg1) {
                if ((((_local3 == "autoTrack")) || ((_local3 == "trackWhilePlaying")))){
                    if (typeof(_arg1[_local3]) == "string"){
                        if (_arg1[_local3].toLowerCase() == "true"){
                            _arg1[_local3] = true;
                        } else {
                            _arg1[_local3] = false;
                        };
                    } else {
                        if (typeof(_arg1[_local3]) != "boolean"){
                            _arg1[_local3] = false;
                        };
                    };
                } else {
                    if (_local3 == "trackSeconds"){
                        if (typeof(_arg1[_local3]) == "string"){
                            (_arg1[_local3] == parseInt(_arg1[_local3]));
                        } else {
                            if (typeof(_arg1[_local3]) != "number"){
                                (_arg1[_local3] == 0);
                            };
                        };
                    };
                };
                if ((((((((typeof(_arg1[_local3]) == "string")) || ((typeof(_arg1[_local3]) == "number")))) || ((typeof(_arg1[_local3]) == "boolean")))) && ((((((((((((((_local3 == "autoTrack")) || ((_local3 == "trackWhilePlaying")))) || ((_local3 == "trackSeconds")))) || ((_local3 == "trackMilestones")))) || ((_local3 == "playerName")))) || ((_local3 == "trackVars")))) || ((_local3 == "trackEvents")))))){
                    _local2[_local3] = _arg1[_local3];
                };
            };
        }
        private function startMonitor(_arg1:Object){
            var m:Object;
            var monitorNum:Number;
            var nextMonitorNum:Number;
            var monitor = _arg1;
            m = this;
            nextMonitorNum = 0;
            if (m.s.isSet(m.monitorList)){
                nextMonitorNum = -1;
                monitorNum = 0;
                while (monitorNum < m.monitorList.length) {
                    if (m.s.isSet(m.monitorList[monitorNum])){
                        if (((((((m.s.isSet(m.monitorList[monitorNum].node)) && (m.s.isSet(monitor)))) && (m.s.isSet(monitor.node)))) && ((m.monitorList[monitorNum].node == monitor.node)))){
                            return;
                        };
                    } else {
                        if (nextMonitorNum < 0){
                            nextMonitorNum = monitorNum;
                        };
                    };
                    monitorNum = (monitorNum + 1);
                };
                if (nextMonitorNum < 0){
                    nextMonitorNum = m.monitorList.length;
                };
            } else {
                m.monitorList = new Array();
            };
            monitor.update = function (_arg1:Object){
                if ((((((((((((_arg1.m == null)) || ((_arg1.m == undefined)))) || ((_arg1.m.s == null)))) || ((_arg1.m.s == undefined)))) || ((_arg1.node == null)))) || ((_arg1.node == undefined)))){
                    clearInterval(_arg1.interval);
                    _arg1.m.monitorList[_arg1.num] = null;
                } else {
                    _arg1.monitor();
                };
            };
            monitor.interval = m.s.setupInterval(monitor, "update", 5000, monitor);
            monitor.num = nextMonitorNum;
            m.monitorList[monitor.num] = monitor;
        }
        private function _open(_arg1:String, _arg2:Number, _arg3:String, _arg4:Object){
            var _local5:Object;
            var _local6:Object;
            var _local7:Date;
            var _local8:String;
            var _local9:String;
            _local5 = this;
            _local6 = new Object();
            _local7 = new Date();
            _local8 = "";
            _arg1 = _local5.cleanName(_arg1);
            _arg2 = Math.floor(_arg2);
            if (!_local5.s.isSet(_arg2)){
                _arg2 = 1;
            };
            if (((_local5.s.isSet(_arg1)) && (_local5.s.isSet(_arg3)))){
                if (!_local5.s.isSet(_local5.list)){
                    _local5.list = new Object();
                };
                if (_local5.s.isSet(_local5.list[_arg1])){
                    _local5.close(_arg1);
                };
                if (_local5.s.isSet(_arg4)){
                    _local8 = ("" + _arg4);
                };
                for (_local9 in _local5.list) {
                    if (((_local5.s.isSet(_local5.list[_local9])) && ((_local5.list[_local9].playerID == _local8)))){
                        _local5.close(_local5.list[_local9].name);
                    };
                };
                _local6.name = _arg1;
                _local6.length = _arg2;
                _local6.playerName = _local5.cleanName((_local5.s.isSet(_local5.playerName)) ? _local5.playerName : _arg3);
                _local6.playerID = _local8;
                _local6.timePlayed = 0;
                _local6.timePlayedSinseTrack = 0;
                _local6.timestamp = Math.floor((_local7.getTime() / 1000));
                _local6.lastEventType = 0;
                _local6.lastEventTimestamp = _local6.timestamp;
                _local6.lastEventOffset = 0;
                _local6.session = "";
                _local6.lastTrackOffset = -1;
                _local5.list[_arg1] = _local6;
            };
        }
        private function autoEvent(_arg1:String, _arg2:Number, _arg3:String, _arg4:Number, _arg5:Number, _arg6:Object){
            var _local7:Object;
            _local7 = this;
            _arg1 = _local7.cleanName(_arg1);
            if (((((_local7.s.isSet(_arg1)) && (_local7.s.isSet(_arg2)))) && (_local7.s.isSet(_arg3)))){
                if (((!(_local7.s.isSet(_local7.list))) || (!(_local7.s.isSet(_local7.list[_arg1]))))){
                    _local7.open(_arg1, _arg2, _arg3, _arg6);
                };
                _local7.event(_arg1, _arg4, _arg5);
            };
        }
        public function play(_arg1:String, _arg2:Number){
            var m:Object;
            var media:Object;
            var monitor:Object;
            var name = _arg1;
            var offset = _arg2;
            m = this;
            m.event(name, 1, offset);
            monitor = new Object();
            monitor.m = m;
            monitor.node = m.cleanName(name);
            monitor.monitor = function (){
                var _local1:Object;
                var _local2:Object;
                var _local3:Object;
                _local1 = this.m;
                _local2 = this.node;
                _local3 = (((((_local1.s.isSet(_local2)) && (_local1.s.isSet(_local1.list)))) && (_local1.s.isSet(_local1.list[_local2])))) ? _local1.list[_local2] : null;
                if (_local1.s.isSet(_local3)){
                    if (_local3.lastEventType == 1){
                        _local1.event(_local3.name, 3, -1);
                    };
                } else {
                    this.node = null;
                };
            };
            m.startMonitor(monitor);
        }
        public function set autoTrack(_arg1:Boolean){
            this._autoTrack = _arg1;
            if (this._autoTrack){
                this.autoTrackInterval = this.s.setupInterval(this, "doAutoTrack", 100, null);
            };
        }
        public function listenerFLVPlayback_stateChange(_arg1){
            this.listenerFLVPlayback.stateChange(_arg1);
        }
        public function listenerBrightcove_videoStart(_arg1){
            this.listenerBrightcove.videoStart(_arg1);
        }
        public function listenerMedia_change(_arg1){
            this.listenerMedia.change(_arg1);
        }
        private function attach(_arg1:Object):Boolean{
            var m:Object;
            var member:String;
            var childNum:Number;
            var player:Object;
            var monitor:Object;
            var attached:Boolean;
            var subAttached:Boolean;
            var node = _arg1;
            m = this;
            attached = false;
            if (m.s.isSet(node)){
                if (((m.s.isSet(node, "getModule")) || (m.s.isSet(node, "showBrightcoveMenu")))){
                    player = node;
                    if ((((m.s.flashASVersion > 2)) && (m.s.isSet(node, "getModule")))){
                        player = node.getModule("experience");
                        if (((((m.s.isSet(player)) && (m.s.isSet(player, "getReady")))) && (player.getReady()))){
                            player = node.getModule("videoPlayer");
                        } else {
                            player = undefined;
                        };
                    };
                    if (((s.isSet(player)) && (s.isSet(player, "addEventListener")))){
                        if (!m.s.isSet(m.listenerBrightcove)){
                            m.listenerBrightcove = new Object();
                            m.listenerBrightcove.m = m;
                            m.listenerBrightcove.playerName = "Brightcove";
                            if (m.s.flashASVersion > 2){
                                m.listenerBrightcove.playerName = (m.listenerBrightcove.playerName + " 3");
                            } else {
                                m.listenerBrightcove.playerName = (m.listenerBrightcove.playerName + " 2");
                            };
                            m.listenerBrightcove.handleEvent = function (_arg1:Object, _arg2:Number, _arg3:Number){
                                var _local4:Object;
                                var _local5:String;
                                var _local6:Number;
                                var _local7:Object;
                                _local4 = this.m;
                                if (((_local4.s.isSet(_local4.autoTrack)) && (_local4.s.isSet(_arg1)))){
                                    if (_local4.s.flashASVersion > 2){
                                        _local7 = _arg1.getCurrentVideo();
                                    } else {
                                        _local7 = _arg1.getCurrentTitle();
                                    };
                                    if (((_local4.s.isSet(_local7)) && (_local4.s.isSet(_local7.id)))){
                                        _local5 = ((this.playerName + ":") + _local7.id);
                                        _local6 = (_local7.length / 1000);
                                        if (_arg3 < 0){
                                            _arg3 = _arg1.getVideoPosition();
                                        };
                                        if (!_local4.s.isSet(_arg3)){
                                            _arg3 = 0;
                                        };
                                        _local4.autoEvent(_local5, _local6, this.playerName, _arg2, _arg3, _arg1);
                                    };
                                };
                            };
                            m.listenerBrightcove.videoProgress = (m.listenerBrightcove.videoStart = (m.listenerBrightcove.progress = (m.listenerBrightcove.play = function (_arg1){
                                if (((((((this.m.s.isSet(_arg1)) && (this.m.s.isSet(_arg1.target)))) && (this.m.s.isSet(_arg1.target.isPlaying)))) && (_arg1.target.isPlaying()))){
                                    this.handleEvent(_arg1.target, 1, ((typeof(_arg1.position) == "number")) ? _arg1.position : -1);
                                };
                            })));
                            m.listenerBrightcove.videoStop = (m.listenerBrightcove.startBuffering = (m.listenerBrightcove.pause = (m.listenerBrightcove.buffering = (m.listenerBrightcove.scrubber = (m.listenerBrightcove.seek = function (_arg1){
                                if (this.m.s.isSet(_arg1)){
                                    this.handleEvent(_arg1.target, 2, -1);
                                };
                            })))));
                            m.listenerBrightcove.videoComplete = (m.listenerBrightcove.mediaComplete = function (_arg1){
                                if (this.m.s.isSet(_arg1)){
                                    this.handleEvent(_arg1.target, 0, -1);
                                };
                            });
                        };
                        if (m.s.flashASVersion > 2){
                            player.addEventListener("videoProgress", m.listenerBrightcove_videoProgress);
                            player.addEventListener("videoStart", m.listenerBrightcove_videoStart);
                            player.addEventListener("videoStop", m.listenerBrightcove_videoStop);
                            player.addEventListener("startBuffering", m.listenerBrightcove_startBuffering);
                            player.addEventListener("seek", m.listenerBrightcove_seek);
                            player.addEventListener("videoComplete", m.listenerBrightcove_videoComplete);
                        } else {
                            player.addEventListener("progress", m.listenerBrightcove, "progress");
                            player.addEventListener("play", m.listenerBrightcove, "play");
                            player.addEventListener("pause", m.listenerBrightcove, "pause");
                            player.addEventListener("buffering", m.listenerBrightcove, "buffering");
                            player.addEventListener("scrubber", m.listenerBrightcove, "scrubber");
                            player.addEventListener("seek", m.listenerBrightcove, "seek");
                            player.addEventListener("mediaComplete", m.listenerBrightcove, "mediaComplete");
                        };
                        monitor = new Object();
                        monitor.m = m;
                        monitor.node = player;
                        monitor.monitor = function (){
                            var _local1:Object;
                            var _local2:Object;
                            _local1 = this.m;
                            _local2 = this.node;
                            if (((_local1.s.isSet(_local2.isPlaying)) && (_local2.isPlaying()))){
                                this.m.listenerBrightcove.handleEvent(_local2, 3, -1);
                            };
                        };
                        m.startMonitor(monitor);
                        attached = true;
                        return (attached);
                    };
                };
                if (((((((((0) && (m.s.isSet(node, "flvVideo")))) && (m.s.isSet(node.flvVideo, "mBandwidthDetector")))) && (m.s.isSet(node.flvVideo.mBandwidthDetector, "mVideoPlayer")))) && (m.s.isSet(node.flvVideo.mBandwidthDetector.mVideoPlayer, "addEventListener")))){
                    node = node.flvVideo.mBandwidthDetector.mVideoPlayer;
                    if (!m.s.isSet(m.listenerMaven)){
                        m.listenerMaven = new Object();
                        m.listenerMaven.m = m;
                        m.listenerMaven.playerName = "Maven Networks";
                        m.listenerMaven.handleEvent = function (_arg1:Object, _arg2:Number){
                            var _local3:Object;
                            var _local4:String;
                            var _local5:Number;
                            var _local6:Number;
                            _local3 = this.m;
                            if (((_local3.s.isSet(_local3.autoTrack)) && (_local3.s.isSet(_arg1)))){
                                if (_local3.s.flashASVersion > 2){
                                    _local4 = _arg1.source;
                                } else {
                                    _local4 = _arg1.contentPath;
                                };
                                _local5 = _arg1.totalTime;
                                _local6 = _arg1.playheadTime;
                                _local3.autoEvent(_local4, _local5, this.playerName, _arg2, _local6, _arg1);
                            };
                        };
                        m.listenerMaven.stateChange = function (_arg1){
                            var _local2:Object;
                            var _local3:Number;
                            var _local4:Object;
                            _local2 = this.m;
                            _local3 = -1;
                            if (((_local2.s.isSet(_arg1)) && (_local2.s.isSet(_arg1.target)))){
                                _local4 = _arg1.target;
                                if (_local2.s.isSet(_local4, "state")){
                                    if (_local4.state == "playing"){
                                        _local3 = 1;
                                    } else {
                                        if ((((((((((_local4.state == "stopped")) || ((_local4.state == "paused")))) || ((_local4.state == "buffering")))) || ((_local4.state == "rewinding")))) || ((_local4.state == "seeking")))){
                                            _local3 = 2;
                                        };
                                    };
                                    if (_local3 >= 0){
                                        this.handleEvent(_arg1.target, _local3);
                                    };
                                };
                            };
                        };
                        m.listenerMaven.complete = function (_arg1){
                            if (this.m.s.isSet(_arg1)){
                                this.handleEvent(_arg1.target, 0);
                            };
                        };
                    };
                    if (m.s.flashASVersion > 2){
                        node.addEventListener("complete", m.listenerMaven_complete);
                        node.addEventListener("stateChange", m.listenerMaven_stateChange);
                    } else {
                        node.addEventListener("complete", m.listenerMaven);
                        node.addEventListener("stateChange", m.listenerMaven);
                    };
                    monitor = new Object();
                    monitor.m = m;
                    monitor.node = node;
                    monitor.monitor = function (){
                        var _local1:Object;
                        var _local2:Object;
                        _local1 = this.m;
                        _local2 = this.node;
                        if (((_local1.s.isSet(_local2.state)) && ((_local2.state == "playing")))){
                            this.m.listenerMaven.handleEvent(_local2, 3);
                        };
                    };
                    m.startMonitor(monitor);
                    attached = true;
                    return (attached);
                };
                if (((m.s.isSet(node, "addEventListener")) && (m.s.isSet(node, "isFLVCuePointEnabled")))){
                    if (!m.s.isSet(m.listenerFLVPlayback)){
                        m.listenerFLVPlayback = new Object();
                        m.listenerFLVPlayback.m = m;
                        m.listenerFLVPlayback.playerName = "Flash FLVPlayback";
                        m.listenerFLVPlayback.handleEvent = function (_arg1:Object, _arg2:Number){
                            var _local3:Object;
                            var _local4:String;
                            var _local5:Number;
                            var _local6:Number;
                            _local3 = this.m;
                            if (((_local3.s.isSet(_local3.autoTrack)) && (_local3.s.isSet(_arg1)))){
                                if (_local3.s.flashASVersion > 2){
                                    _local4 = _arg1.source;
                                } else {
                                    _local4 = _arg1.contentPath;
                                };
                                _local5 = _arg1.totalTime;
                                _local6 = _arg1.playheadTime;
                                _local3.autoEvent(_local4, _local5, this.playerName, _arg2, _local6, _arg1);
                            };
                        };
                        m.listenerFLVPlayback.stateChange = function (_arg1){
                            var _local2:Object;
                            var _local3:Number;
                            var _local4:Object;
                            _local2 = this.m;
                            _local3 = -1;
                            if (((_local2.s.isSet(_arg1)) && (_local2.s.isSet(_arg1.target)))){
                                _local4 = _arg1.target;
                                if (_local2.s.isSet(_local4, "state")){
                                    if (_local4.state == "playing"){
                                        _local3 = 1;
                                    } else {
                                        if ((((((((((_local4.state == "stopped")) || ((_local4.state == "paused")))) || ((_local4.state == "buffering")))) || ((_local4.state == "rewinding")))) || ((_local4.state == "seeking")))){
                                            _local3 = 2;
                                        };
                                    };
                                    if (_local3 >= 0){
                                        this.handleEvent(_arg1.target, _local3);
                                    };
                                };
                            };
                        };
                        m.listenerFLVPlayback.complete = function (_arg1){
                            if (this.m.s.isSet(_arg1)){
                                this.handleEvent(_arg1.target, 0);
                            };
                        };
                    };
                    if (m.s.flashASVersion > 2){
                        node.addEventListener("complete", m.listenerFLVPlayback_complete);
                        node.addEventListener("stateChange", m.listenerFLVPlayback_stateChange);
                    } else {
                        node.addEventListener("complete", m.listenerFLVPlayback);
                        node.addEventListener("stateChange", m.listenerFLVPlayback);
                    };
                    monitor = new Object();
                    monitor.m = m;
                    monitor.node = node;
                    monitor.monitor = function (){
                        var _local1:Object;
                        var _local2:Object;
                        _local1 = this.m;
                        _local2 = this.node;
                        if (((_local1.s.isSet(_local2.state)) && ((_local2.state == "playing")))){
                            this.m.listenerFLVPlayback.handleEvent(_local2, 3);
                        };
                    };
                    m.startMonitor(monitor);
                    attached = true;
                    return (attached);
                };
                if (((m.s.isSet(node, "addEventListener")) && (m.s.isSet(node, "addCuePoint")))){
                    if (!m.s.isSet(m.listenerMedia)){
                        m.listenerMedia = new Object();
                        m.listenerMedia.m = m;
                        m.listenerMedia.playerName = "Flash Media";
                        m.listenerMedia.handleEvent = function (_arg1:Object, _arg2:Number){
                            var _local3:Object;
                            var _local4:String;
                            var _local5:Number;
                            var _local6:Number;
                            _local3 = this.m;
                            if (((_local3.s.isSet(_local3.autoTrack)) && (_local3.s.isSet(_arg1)))){
                                _local4 = _arg1.contentPath;
                                _local5 = _arg1.totalTime;
                                _local6 = _arg1.playheadTime;
                                _local3.autoEvent(_local4, _local5, this.playerName, _arg2, _local6, _arg1);
                            };
                        };
                        m.listenerMedia.complete = function (_arg1){
                            if (this.m.s.isSet(_arg1)){
                                this.handleEvent(_arg1.target, 0);
                            };
                        };
                        m.listenerMedia.click = function (_arg1){
                            if (((this.m.s.isSet(_arg1)) && (this.m.s.isSet(_arg1.target)))){
                                this.handleEvent(_arg1.target, (this.m.s.isSet(_arg1.target.playing)) ? 1 : 2);
                            };
                        };
                        m.listenerMedia.change = function (_arg1){
                            if (((this.m.s.isSet(_arg1)) && (this.m.s.isSet(_arg1.target)))){
                                this.handleEvent(_arg1.target, (this.m.s.isSet(_arg1.target.playing)) ? 1 : 2);
                            };
                        };
                        m.listenerMedia.scrubbing = function (_arg1){
                            if (this.m.s.isSet(_arg1)){
                                this.handleEvent(_arg1.target, 2);
                            };
                        };
                    };
                    if (m.s.flashASVersion > 2){
                        node.addEventListener("complete", m.listenerMedia_complete);
                        node.addEventListener("click", m.listenerMedia_click);
                        node.addEventListener("change", m.listenerMedia_change);
                        node.addEventListener("scrubbing", m.listenerMedia_scrubbing);
                    } else {
                        node.addEventListener("complete", m.listenerMedia);
                        node.addEventListener("click", m.listenerMedia);
                        node.addEventListener("change", m.listenerMedia);
                        node.addEventListener("scrubbing", m.listenerMedia);
                    };
                    monitor = new Object();
                    monitor.m = m;
                    monitor.node = node;
                    monitor.monitor = function (){
                        var _local1:Object;
                        var _local2:Object;
                        _local1 = this.m;
                        _local2 = this.node;
                        if (_local1.s.isSet(_local2.playing)){
                            this.m.listenerMedia.handleEvent(_local2, 3);
                        };
                    };
                    m.startMonitor(monitor);
                    attached = true;
                    return (attached);
                };
                if (m.s.flashASVersion > 2){
                    if (((m.s.isSet(node, "numChildren")) && (m.s.isSet(node, "getChildAt")))){
                        childNum = 0;
                        while (childNum < node.numChildren) {
                            subAttached = m.attach(node.getChildAt(childNum));
                            if (m.s.isSet(subAttached)){
                                attached = subAttached;
                            };
                            childNum = (childNum + 1);
                        };
                    };
                } else {
                    for (member in node) {
                        if (((((((m.s.isSet(node[member])) && (m.s.isSet(node[member]._name)))) && ((node[member]._name == member)))) && ((((("" + node) + ".") + member) == ("" + node[member]))))){
                            subAttached = m.attach(node[member]);
                            if (m.s.isSet(subAttached)){
                                attached = subAttached;
                            };
                        };
                    };
                };
            };
            return (attached);
        }
        public function listenerBrightcove_videoStop(_arg1){
            this.listenerBrightcove.videoStop(_arg1);
        }
        public function open(_arg1:String, _arg2:Number, _arg3:String, _arg4:Object=null){
            this._open(_arg1, _arg2, _arg3, _arg4);
        }
        public function track(_arg1:String){
            var _local2:Object;
            _local2 = this;
            if (_local2.s.isSet(_local2.trackWhilePlaying)){
                _local2.event(_arg1, 4, -1);
            };
        }
        public function get autoTrack():Boolean{
            return (this._autoTrack);
        }
        public function listenerBrightcove_videoProgress(_arg1){
            this.listenerBrightcove.videoProgress(_arg1);
        }
        private function cleanName(_arg1:String):String{
            var _local2:Object;
            _local2 = this;
            return (_local2.s.replace(_local2.s.replace(_local2.s.replace(_arg1, "\n", ""), "\r", ""), "--**--", ""));
        }
        public function listenerBrightcove_startBuffering(_arg1){
            this.listenerBrightcove.startBuffering(_arg1);
        }
        public function close(_arg1:String){
            this.event(_arg1, 0, -1);
        }
        public function listenerBrightcove_videoComplete(_arg1){
            this.listenerBrightcove.videoComplete(_arg1);
        }

    }
}//package com.omniture 
