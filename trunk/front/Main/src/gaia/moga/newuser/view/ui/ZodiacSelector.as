//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.newuser.view.ui {
    import flash.display.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import alecmce.services.*;

    public class ZodiacSelector extends AssetDecorator {

        private var ticker:Ticker;
        private var list:ZodiacList;
        private var carousel:SelectionCarousel;
        private var _zodiac:Signal;
        private var _chosen:Signal;
        private var zodiacArrow:MovieClip;
        private var monsterArrow:MovieClip;
        private var _modelChosen:ZodiacMonsterModel;

        public function ZodiacSelector(_arg1:Ticker, _arg2:Asset){
            this.ticker = _arg1;
            this._chosen = new Signal(ZodiacMonsterModel);
            this._zodiac = new Signal(uint);
            super(_arg2);
        }
        override protected function setup(_arg1:MovieClip):void{
            this.zodiacArrow = _arg1.zodiac_arrow;
            this.zodiacArrow.visible = true;
            this.monsterArrow = _arg1.monster_arrow;
            this.monsterArrow.visible = false;
            this.list = new ZodiacList(_arg1.zodiacButtons);
            this.list.selected.add(this.onZodiacSelected);
            this.list.enable();
            this.carousel = new SelectionCarousel(_arg1.carousel);
            this.carousel.chosen.addOnce(this.onChosen);
        }
        public function selectItem(_arg1:uint):void{
            this.carousel.selectItem(_arg1);
        }
        public function selectZodiac(_arg1:uint):void{
            this.list.showZodiacSelected(_arg1);
        }
        private function onZodiacSelected(_arg1:int):void{
            this.zodiacArrow.visible = false;
            this.monsterArrow.visible = true;
            this.carousel.selected.addOnce(this.onItemSelected);
            this._zodiac.dispatch(_arg1);
        }
        private function onItemSelected(_arg1:ZodiacMonsterModel):void{
            this.zodiacArrow.visible = false;
            this.monsterArrow.visible = false;
        }
        public function setItems(_arg1:Vector.<SelectionItem>):void{
            this.carousel.setItems(_arg1);
        }
        private function onChosen(_arg1:ZodiacMonsterModel):void{
            this.list.disable();
            this.zodiacArrow.visible = false;
            this.monsterArrow.visible = false;
            this._modelChosen = _arg1;
            var _local2:FinalSelectionAnim = new FinalSelectionAnim(content, this.carousel, this.carousel.selection);
            _local2.complete.addOnce(this.onFinalSelectionAnimComplete);
            _local2.play();
        }
        private function onFinalSelectionAnimComplete(_arg1:Anim):void{
            this._chosen.dispatch(this._modelChosen);
        }
        public function get chosen():ISignal{
            return (this._chosen);
        }
        public function get zodiac():ISignal{
            return (this._zodiac);
        }

    }
}//package gaia.moga.newuser.view.ui 
