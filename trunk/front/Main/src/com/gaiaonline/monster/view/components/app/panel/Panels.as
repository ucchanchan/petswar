//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.app.panel {
    import flash.display.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;

    public class Panels extends Sprite {

        private var _swapped:Signal;
        private var _anims:AutoAnimStack;
        private var _streak:Asset;
        private var _above:DisplayObjectContainer;
        private var _panel:Panel;
        private var _transitioning:Panel;
        private var _previous:Panel;

        public function Panels(_arg1:Asset, _arg2:DisplayObjectContainer){
            this._swapped = new Signal();
            this._anims = new AutoAnimStack();
            this._streak = _arg1;
            this._above = _arg2;
        }
        public function get panel():Panel{
            return (this._panel);
        }
        public function set panel(_arg1:Panel):void{
            if (this._panel == _arg1){
                return;
            };
            this._transitioning = this._panel;
            this._panel = _arg1;
            this._anims.complete.addOnce(this.onAllAnimsComplete);
            this._anims.push(new PanelSwapAnim(this, this._transitioning, _arg1, this._above, this._streak));
        }
        public function get previous():Panel{
            return (this._previous);
        }
        public function clearPrevious():void{
            this._previous = null;
        }
        private function onAllAnimsComplete(_arg1:Anim):void{
            this._previous = this._transitioning;
            this._transitioning = null;
            this._swapped.dispatch();
        }
        public function get swapped():ISignal{
            return (this._swapped);
        }

    }
}//package com.gaiaonline.monster.view.components.app.panel 
