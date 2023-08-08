//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.app.view.ui {
    import flash.display.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.service.sound.*;
    import com.gaiaonline.monster.view.components.app.panel.*;
    import flash.text.*;
    import gaia.lib.assets.*;

    public class Splash extends Panel implements Async {

        private var ui:Asset;
        private var music:MusicProxy;
        private var version:String;
        private var parallel:ParallelAsyncs;
        private var _complete:Signal;
        private var _alwaysSkip:Signal;
        private var _error:Signal;
        private var _isComplete:Boolean;
        private var _isError:Boolean;
        private var _isInited:Boolean;

        public function Splash(_arg1:Asset, _arg2:String, _arg3:MusicProxy){
            this._complete = new Signal(Async);
            this._error = new Signal(Async, String);
            this._alwaysSkip = new Signal();
            this.ui = _arg1;
            this.version = _arg2;
            this.music = _arg3;
            this.parallel = new ParallelAsyncs("Splash-Parallel");
            this.parallel.add(_arg1);
            this.parallel.add(_arg3);
        }
        override public function setup():void{
            this.init();
        }
        public function init():void{
            if (this._isInited){
                return;
            };
            this._isInited = true;
            if (this.parallel.isComplete){
                this.play(this.parallel);
            } else {
                this.parallel.complete.addOnce(this.play);
            };
            this.parallel.init();
        }
        override public function dispose(_arg1:Boolean=true):void{
            super.dispose(_arg1);
            if (!this.ui){
                return;
            };
            if (this.ui.self.parent == this){
                removeChild(this.ui.self);
            };
            this.ui.dispose(_arg1);
            this.ui = null;
            this.parallel.dispose(_arg1);
            this.parallel = null;
        }
        private function play(_arg1:Async):void{
            var _local2:MovieClip = MovieClip(this.ui.content);
            var _local3:SignallingAsset = SignallingAsset(_local2);
            var _local4:TextField = TextField(_local2.version);
            _local4.text = this.version;
            _local3.signal.addOnce(this.onAssetSignal);
            addChild(this.ui.self);
            _local2.gotoAndPlay(1);
            if (this.music){
                this.music.play();
            };
        }
        private function onAssetSignal(_arg1:Object):void{
            if (_arg1 == "skipIntro"){
                this._alwaysSkip.dispatch();
            };
            this._isComplete = true;
            this._complete.dispatch(this);
        }
        public function get alwaysSkip():Signal{
            return (this._alwaysSkip);
        }
        public function get isComplete():Boolean{
            return (this._isComplete);
        }
        public function get complete():Signal{
            return (this._complete);
        }
        public function get isError():Boolean{
            return (this._isError);
        }
        public function get error():Signal{
            return (this._error);
        }

    }
}//package gaia.moga.app.view.ui 
