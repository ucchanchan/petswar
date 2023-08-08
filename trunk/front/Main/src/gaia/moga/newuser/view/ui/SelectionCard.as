//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.newuser.view.ui {
    import flash.display.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import alecmce.services.*;
    import gaia.moga.newuser.view.ui.*;

    class SelectionCard {

        private var _response:Signal;
        private var stats:SelectionStats;
        private var dialog:SelectionDialog;
        private var playhead:MovieClipPlayhead;

        private static const STATS:String = "STATS";
        private static const DIALOG:String = "DIALOG";

        function SelectionCard(_arg1:Ticker, _arg2:MovieClip, _arg3:ZodiacMonsterModel){
            this._response = new Signal(Boolean);
            this.stats = new SelectionStats(_arg2.stats, _arg3);
            this.dialog = new SelectionDialog(_arg2.dialog, _arg3);
            this.playhead = new MovieClipPlayhead(_arg2, _arg1);
        }
        public function gotoDialog():void{
            this.playhead.playTo(DIALOG);
            this.dialog.enable();
            this.dialog.response.addOnce(this.onResponse);
        }
        private function onResponse(_arg1:Boolean):void{
            this._response.dispatch(_arg1);
            if (!_arg1){
                this.gotoStats();
            };
        }
        public function gotoStats():void{
            this.dialog.response.remove(this.onResponse);
            this.dialog.disable();
            this.playhead.playTo(STATS);
        }
        public function get response():ISignal{
            return (this._response);
        }

    }
}//package gaia.moga.newuser.view.ui 
