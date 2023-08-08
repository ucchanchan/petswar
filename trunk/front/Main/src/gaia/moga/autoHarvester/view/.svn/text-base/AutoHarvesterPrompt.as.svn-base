//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.autoHarvester.view {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.view.components.app.panel.*;

    public class AutoHarvesterPrompt extends Panel {

        public var confirm:Signal;
        public var close:Signal;
        private var whistles:uint;

        private static const COST:uint = 10;

        public function AutoHarvesterPrompt(_arg1:Asset, _arg2:uint){
            this.confirm = new Signal();
            this.close = new Signal();
            this.whistles = _arg2;
            if (_arg1.isComplete){
                this.init(_arg1);
            } else {
                _arg1.complete.addOnce(this.init);
            };
        }
        private function init(_arg1:Asset):void{
            addChild(_arg1.self);
            var _local2:MovieClip = MovieClip(_arg1.content);
            _local2.confirm.addEventListener(MouseEvent.CLICK, this.onConfirm);
            _local2.close.addEventListener(MouseEvent.CLICK, this.onClose);
            _local2.whistles.text = (this.whistles + " Bonus Attack");
            if (this.whistles > 1){
                _local2.whistles.text = (_local2.whistles.text + "s");
            };
            _local2.coins.text = (COST + " Star Coins");
        }
        private function onConfirm(_arg1:MouseEvent):void{
            this.confirm.dispatch();
        }
        private function onClose(_arg1:MouseEvent):void{
            this.close.dispatch();
        }

    }
}//package gaia.moga.autoHarvester.view 
