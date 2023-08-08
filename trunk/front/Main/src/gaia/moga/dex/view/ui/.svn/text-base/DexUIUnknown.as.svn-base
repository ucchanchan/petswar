//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.view.ui {
    import flash.display.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import gaia.moga.dex.model.*;
    import gaia.moga.dex.assets.*;
    import gaia.moga.assets.*;
    import alecmce.ui.button.*;
    import com.gaiaonline.monster.view.components.battle.fight.*;
    import flash.geom.*;
    import com.gaiaonline.monster.*;

    public class DexUIUnknown extends Sprite {

        private var ui:Asset;
        private var language:DexLanguageBundle;
        private var zodiacs:ZodiacFactory;
        private var _fight:FightMonster;
        private var _closed:Signal;
        private var mc:MovieClip;
        private var ct:ColorTransform;
        private var outline:MovieClip;
        private var closeButton:MovieClipButton;
        private var rect:Rectangle;
        private var image:Bitmap;

        private static const ELEMENTS:Array = ["air", "earth", "fire", "water"];

        public function DexUIUnknown(_arg1:Asset, _arg2:DexLanguageBundle, _arg3:ZodiacFactory){
            this.ui = _arg1;
            this.language = _arg2;
            this.zodiacs = _arg3;
            this._closed = new Signal();
            this.mc = (_arg1.content as MovieClip);
            this.setup(this.mc);
            _arg1.self.visible = false;
            addChild(_arg1.self);
        }
        private function setup(_arg1:MovieClip):void{
            this.ct = new ColorTransform();
            this.outline = _arg1.outline;
            this.closeButton = new MovieClipButton(_arg1.close);
            this.rect = _arg1.mogaImage.getRect(_arg1.mogaImage);
            this.image = new Bitmap();
            this.image.x = this.rect.left;
            this.image.y = this.rect.top;
            _arg1.mogaImage.addChild(this.image);
        }
        public function show(_arg1:DexMoga):void{
            this.closeButton.clicked.addOnce(this.onClose);
            this.mc.mogaName.text = _arg1.genericName;
            this.mc.description.text = _arg1.description;
            Color.setTransform(this.ct, Color.fromRarity(_arg1.rarity));
            this.outline.transform.colorTransform = this.ct;
            this.mc.rarity.rarity.text = this.language.getRarity(_arg1.rarity);
            this.mc.rarity.pill.transform.colorTransform = this.ct;
            this.mc.strength.gotoAndStop(_arg1.strengthRating);
            this.mc.toughness.gotoAndStop(_arg1.toughnessRating);
            this.mc.zodiac.gotoAndStop(_arg1.zodiacRating);
            var _local2:int = ((_arg1.zodiac >> 1) % 4);
            this.mc.background.gotoAndStop(ELEMENTS[_local2]);
            var _local3:DexMogaBundle = _arg1.bundle;
            if (_local3.isComplete){
                this.displayMoga(_local3);
            } else {
                _local3.complete.addOnce(this.displayMoga);
            };
            var _local4:Bitmap = this.zodiacs.generate(_arg1.zodiac, 22);
            var _local5:ColorTransform = new ColorTransform();
            Color.setTransform(_local5, 4282763498);
            _local4.transform.colorTransform = _local5;
            this.mc.zodiac.addChild(_local4);
            this.ui.self.visible = true;
        }
        private function displayMoga(_arg1:DexMogaBundle):void{
            var _local2:FightMonster = _arg1.fight;
            if (this._fight == _local2){
                return;
            };
            this.image.bitmapData = null;
            this._fight = _local2;
            if (this._fight.isComplete){
                this.setupFight(this._fight);
            } else {
                this._fight.complete.addOnce(this.setupFight);
                this._fight.error.addOnce(this.fightError);
            };
            this._fight.init();
        }
        private function setupFight(_arg1:FightMonster):void{
            _arg1.error.removeAll();
            var _local2:Rectangle = _arg1.getRect(_arg1);
            var _local3:Number = Math.min(1, (this.rect.width / _local2.width), (this.rect.height / _local2.height));
            var _local4:int = ((-(_local2.left) * _local3) + ((this.rect.width - (_local2.width * _local3)) * 0.5));
            var _local5:int = ((-(_local2.top) * _local3) + (this.rect.height - (_local2.height * _local3)));
            var _local6:BitmapData = new BitmapData(this.rect.width, this.rect.height, true, 0);
            var _local7:Matrix = new Matrix(_local3, 0, 0, _local3, _local4, _local5);
            _local6.draw(_arg1, _local7, null, null, null, true);
            this.image.bitmapData = _local6;
        }
        private function fightError(_arg1:FightMonster, _arg2:String=""):void{
            _arg1.complete.removeAll();
        }
        private function onClose(_arg1:MovieClipButton):void{
            this._closed.dispatch();
            this.ui.self.visible = false;
            this.cleanUp();
        }
        public function cleanUp():void{
            this.mc.mogaName.text = "";
            this.mc.description.text = "";
            this.mc.rarity.text = "";
            this.mc.strength.gotoAndStop(1);
            this.mc.toughness.gotoAndStop(1);
            this.mc.zodiac.gotoAndStop(1);
            while (this.mc.zodiac.numChildren) {
                this.mc.zodiac.removeChildAt(0);
            };
        }
        public function get closed():ISignal{
            return (this._closed);
        }

    }
}//package gaia.moga.dex.view.ui 
