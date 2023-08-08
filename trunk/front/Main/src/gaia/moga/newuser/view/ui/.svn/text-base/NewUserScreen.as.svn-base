//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.newuser.view.ui {
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.view.components.app.panel.*;
    import alecmce.services.*;

    public class NewUserScreen extends Panel {

        private var ticker:Ticker;
        private var asset:Asset;
        private var selector:ZodiacSelector;
        private var _chosen:Signal;
        public var _zodiac:Signal;

        public function NewUserScreen(_arg1:Ticker, _arg2:Asset){
            this.ticker = _arg1;
            this.asset = _arg2;
            this._chosen = new Signal(ZodiacMonsterModel);
            this._zodiac = new Signal(uint);
            _arg2 = new MovieClipAssetLoader("assets/newUser/newZodiacSelection.swf");
            _arg2.init();
        }
        override public function setup():void{
            this.selector = new ZodiacSelector(this.ticker, this.asset);
            this.selector.chosen.addOnce(this.onChosen);
            this.selector.zodiac.add(this.onZodiac);
            addChild(this.asset.self);
        }
        public function selectItem(_arg1:uint):void{
            this.selector.selectItem(_arg1);
        }
        public function selectZodiac(_arg1:uint):void{
            this.selector.selectZodiac(_arg1);
        }
        public function setItems(_arg1:Vector.<SelectionItem>):void{
            this.selector.setItems(_arg1);
        }
        override public function dispose(_arg1:Boolean=true):void{
            this.selector.chosen.remove(this.onChosen);
            this.selector.zodiac.remove(this.onZodiac);
            super.dispose(_arg1);
        }
        private function onZodiac(_arg1:uint):void{
            this._zodiac.dispatch(_arg1);
        }
        private function onChosen(_arg1:ZodiacMonsterModel):void{
            this._chosen.dispatch(_arg1);
        }
        public function get chosen():ISignal{
            return (this._chosen);
        }
        public function get zodiac():ISignal{
            return (this._zodiac);
        }

    }
}//package gaia.moga.newuser.view.ui 
