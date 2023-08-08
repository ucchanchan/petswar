//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.view.ui {
    import flash.display.*;
    import com.gaiaonline.monster.model.*;
    import gaia.moga.dex.model.*;
    import gaia.moga.dex.assets.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.view.components.battle.fight.*;
    import flash.geom.*;
    import com.gaiaonline.monster.*;
    import gaia.moga.ui.bar.*;

    public class DexUIDetailStats {

        private var mc:MovieClip;
        private var language:DexLanguageBundle;
        private var zodiacs:ZodiacFactory;
        private var ct:ColorTransform;
        private var hp:MovieClipBar;
        private var xp:MovieClipBar;
        private var image:Bitmap;
        private var rect:Rectangle;
        private var _fight:FightMonster;

        private static const ELEMENTS:Array = ["air", "earth", "fire", "water"];

        public function DexUIDetailStats(_arg1:MovieClip, _arg2:DexLanguageBundle, _arg3:ZodiacFactory):void{
            this.mc = _arg1;
            this.language = _arg2;
            this.zodiacs = _arg3;
            this.ct = new ColorTransform();
            this.hp = new TintedMovieClipBar(_arg1.hp.bar, _arg1.hp.bar, Color.fromHealth);
            this.xp = new TintedMovieClipBar(_arg1.xp.bar, _arg1.xp.bar, Color.fromXP);
            this.rect = _arg1.mogaImage.getRect(_arg1.mogaImage);
            this.image = new Bitmap();
            this.image.x = this.rect.left;
            this.image.y = this.rect.top;
            _arg1.mogaImage.addChild(this.image);
        }
        public function show(_arg1:DexMogaInstance):void{
            var _local2:DexMoga = _arg1.generic;
            var _local3:MonsterModel = _arg1.model;
            this.mc.mogaName.text = _local3.name;
            this.mc.level.text = ("Lv. " + _local3.level.toString());
            this.mc.description.text = _local2.description;
            Color.setTransform(this.ct, Color.fromRarity(_local2.rarity));
            this.mc.rarity.rarity.text = this.language.getRarity(_local2.rarity);
            this.mc.rarity.pill.transform.colorTransform = this.ct;
            this.mc.strength.gotoAndStop(_local2.strengthRating);
            this.mc.toughness.gotoAndStop(_local2.toughnessRating);
            this.mc.zodiac.gotoAndStop(_local2.zodiacRating);
            this.hp.setBounds(_local3.hp, 0, _local3.maxHP);
            this.mc.hp.value.text = ((_local3.hp + "/") + _local3.maxHP);
            var _local4:ExperienceVO = _local3.xp;
            this.xp.setBounds(_local4.value, 0, _local4.max);
            this.mc.xp.value.text = ((_local4.value + "/") + _local4.max);
            var _local5:int = ((_local2.zodiac >> 1) % 4);
            this.mc.background.gotoAndStop(ELEMENTS[_local5]);
            var _local6:DexMogaBundle = _local2.bundle;
            if (_local6.isComplete){
                this.displayMoga(_local6);
            } else {
                _local6.complete.addOnce(this.displayMoga);
            };
            if (this.mc.zodiac.numChildren){
                (this.mc.zodiac.removeChildAt(0) as Bitmap).bitmapData.dispose();
            };
            var _local7:Bitmap = this.zodiacs.generate(_local2.zodiac, 22);
            var _local8:ColorTransform = new ColorTransform();
            Color.setTransform(_local8, 4282763498);
            _local7.transform.colorTransform = _local8;
            this.mc.zodiac.addChild(_local7);
        }
        private function displayMoga(_arg1:DexMogaBundle):void{
            var _local2:FightMonster = _arg1.fight;
            if (this._fight == _local2){
                return;
            };
            this.image.bitmapData = null;
            this._fight = _local2;
            if (!this._fight){
                return;
            };
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
        public function cleanUp(_arg1:DexMogaInstance):void{
            var _local2:DexMoga;
            if (_arg1){
                _local2 = _arg1.generic;
                _local2.bundle.complete.remove(this.displayMoga);
            };
            this.mc.mogaName.text = "";
            this.mc.level.text = "";
            this.mc.description.text = "";
            this.mc.rarity.text = "";
            this.mc.strength.gotoAndStop(1);
            this.mc.toughness.gotoAndStop(1);
            this.mc.zodiac.gotoAndStop(1);
            this.hp.value = 0;
            this.mc.hp.value.text = "";
            this.xp.value = 0;
            this.mc.xp.value.text = "";
            while (this.mc.zodiac.numChildren) {
                this.mc.zodiac.removeChildAt(0);
            };
        }

    }
}//package gaia.moga.dex.view.ui 
