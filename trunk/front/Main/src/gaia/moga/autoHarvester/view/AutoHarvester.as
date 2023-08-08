//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.autoHarvester.view {
    import flash.display.*;
    import flash.events.*;
    import com.gskinner.motion.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.view.components.app.panel.*;

    public class AutoHarvester extends Panel {

        public var clicked:Signal;
        public var animComplete:Signal;
        private var content:MovieClip;

        public function AutoHarvester(_arg1:Asset){
            this.clicked = new Signal();
            this.animComplete = new Signal();
            if (_arg1.isComplete){
                this.init(_arg1);
            } else {
                _arg1.complete.addOnce(this.init);
            };
        }
        private function init(_arg1:Asset):void{
            addChild(_arg1.self);
            this.content = MovieClip(_arg1.content);
            this.content.addEventListener(MouseEvent.CLICK, this.onClick);
            this.content.buttonMode = true;
            this.content.signal.addOnce(this.onSignal);
        }
        private function onSignal(_arg1:Object):void{
            this.animComplete.dispatch();
        }
        private function onClick(_arg1:MouseEvent):void{
            this.clicked.dispatch();
        }
        public function playAnim(_arg1:String):void{
            this.content.gotoAndPlay(_arg1);
        }
        public function fadeOut():void{
            new GTween(this, 1, {alpha:0}, {onComplete:this.fadeOutComplete});
        }
        private function fadeOutComplete(_arg1:GTween):void{
            this.parent.removeChild(this);
        }

    }
}//package gaia.moga.autoHarvester.view 
