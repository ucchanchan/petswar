//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.newuser.view.ui {
    import flash.display.*;
    import org.osflash.signals.*;
    import com.gaiaonline.monster.view.components.app.panel.*;
    import gaia.moga.newuser.view.assets.*;
    import gaia.lib.assets.*;

    public class NewUserIntro extends Panel {

        private var _event:Signal;
        private var _bundle:NewUserIntroBundle;

        private static const SCALE:Number = 2;

        public function NewUserIntro(_arg1:NewUserIntroBundle){
            this._bundle = _arg1;
            this._event = new Signal(Object);
        }
        override public function setup():void{
            this.startStarFalls();
        }
        private function startStarFalls():void{
            var _local1:MovieClip = MovieClip(this._bundle.starFalls.content);
            var _local2:SignallingAsset = SignallingAsset(_local1);
            _local2.signal.addOnce(this.onStarFallsComplete);
            addChild(this._bundle.starFalls.self);
            _local1.play();
        }
        private function endStarFalls():void{
            MovieClip(this._bundle.starFalls.content).stop();
            removeChild(this._bundle.starFalls.self);
        }
        private function onStarFallsComplete(_arg1:Object):void{
            this.endStarFalls();
            this._event.dispatch(_arg1);
            this.startEnterBattle();
        }
        private function startEnterBattle():void{
            var _local1:MovieClip = MovieClip(this._bundle.enterBattle.content);
            var _local2:SignallingAsset = SignallingAsset(_local1);
            _local2.signal.addOnce(this.onEnterBattleComplete);
            MovieClip(this._bundle.monster.content).monster.stop();
            var _local3:MovieClip = _local1.monster;
            _local3.scaleX = SCALE;
            _local3.scaleY = SCALE;
            _local3.addChild(this._bundle.monster.self);
            addChild(this._bundle.enterBattle.self);
            _local1.play();
        }
        private function endEnterBattle():void{
            MovieClip(this._bundle.enterBattle.content).stop();
        }
        private function onEnterBattleComplete(_arg1:Object):void{
            this.endEnterBattle();
            this._event.dispatch(_arg1);
        }
        public function get event():Signal{
            return (this._event);
        }
        override public function dispose(_arg1:Boolean=true):void{
            if (this._bundle){
                removeChild(this._bundle.enterBattle.self);
                this._bundle.dispose(_arg1);
                this._bundle = null;
            };
        }

    }
}//package gaia.moga.newuser.view.ui 
