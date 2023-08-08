//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.newuser.view.ui {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.view.components.battle.fight.*;
    import alecmce.services.*;

    public class SelectionItem extends Sprite implements Asset {

        private var _complete:Signal;
        private var _error:Signal;
        private var _chosen:Signal;
        private var _selected:Signal;
        private var _isSelected:Boolean;
        private var _setupComplete:Signal;
        private var ticker:Ticker;
        private var wrapper:Asset;
        private var _monster:FightMonster;
        private var parallel:ParallelAsyncs;
        private var rays:SelectionRays;
        private var particles:SelectionParticles;
        private var plate:MovieClip;
        private var unplate:MovieClip;
        private var _info:ZodiacMonsterModel;
        private var card:SelectionCard;
        private var arrow:MovieClip;

        public function SelectionItem(_arg1:Ticker, _arg2:Asset, _arg3:FightMonster, _arg4:ZodiacMonsterModel){
            this.ticker = _arg1;
            this._complete = new Signal(SelectionItem);
            this._error = new Signal(SelectionItem, String);
            this._selected = new Signal(SelectionItem);
            this._chosen = new Signal(SelectionItem, Boolean);
            this._setupComplete = new Signal();
            this.wrapper = _arg2;
            this._monster = _arg3;
            this._monster.addEventListener(MouseEvent.CLICK, this.onMonsterClick);
            this._monster.buttonMode = true;
            this._monster.useHandCursor = true;
            this._info = _arg4;
            this.parallel = new ParallelAsyncs("SelectionItemParallel");
            this.parallel.add(_arg2);
            this.parallel.add(_arg3);
        }
        private function onMonsterClick(_arg1:MouseEvent):void{
            this._selected.dispatch(this);
        }
        public function init():void{
            if (this.parallel.isComplete){
                this.setup(this.parallel);
                return;
            };
            this.parallel.complete.addOnce(this.setup);
            this.parallel.init();
        }
        public function get isSelected():Boolean{
            return (this._isSelected);
        }
        public function set isSelected(_arg1:Boolean):void{
            if (this._isSelected == _arg1){
                return;
            };
            this._isSelected = _arg1;
            if (this._isSelected){
                this.arrow.visible = true;
            } else {
                this.arrow.visible = false;
            };
            this.rays.isAnimating = _arg1;
            this.particles.isAnimating = _arg1;
            this.plate.visible = _arg1;
            this.unplate.visible = !(_arg1);
            if (this.isSelected){
                this.card.gotoDialog();
                this.card.response.addOnce(this.onResponse);
                this._monster.playAnim("battleIdle");
            } else {
                this.card.response.remove(this.onResponse);
                this.card.gotoStats();
                this._monster.playAnim("stop");
            };
        }
        private function onResponse(_arg1:Boolean):void{
            this._chosen.dispatch(this, _arg1);
        }
        public function dispose(_arg1:Boolean=true):void{
            this.wrapper.dispose(_arg1);
            this._monster.removeEventListener(MouseEvent.CLICK, this.onMonsterClick);
            this._monster.dispose(_arg1);
        }
        public function get self():DisplayObject{
            return (this);
        }
        public function get content():DisplayObject{
            return (this.wrapper.content);
        }
        public function get isComplete():Boolean{
            return (this.parallel.isComplete);
        }
        public function get complete():Signal{
            return (this._complete);
        }
        public function get isError():Boolean{
            return (this.parallel.isError);
        }
        public function get error():Signal{
            return (this._error);
        }
        public function get selected():Signal{
            return (this._selected);
        }
        private function setup(_arg1:Async):void{
            addChild(this.wrapper.self);
            var _local2:MovieClip = MovieClip(this.wrapper.content);
            this.arrow = MovieClip(_local2.card.dialog.monster_arrow);
            this.arrow.visible = false;
            this.rays = new SelectionRays(_local2.rays);
            this.rays.isAnimating = this._isSelected;
            this.particles = new SelectionParticles(_local2.particles);
            this.particles.isAnimating = this._isSelected;
            this.plate = _local2.plate;
            this.plate.visible = this._isSelected;
            this.unplate = _local2.unplate;
            this.unplate.visible = !(this._isSelected);
            this.card = new SelectionCard(this.ticker, _local2.card, this._info);
            _local2.monster.addChild(this._monster.self);
            this.monster.self.scaleX = (this.monster.self.scaleY = (this.monster.self.scaleY * 1.2));
            this._monster.playAnim("stop");
            this._setupComplete.dispatch();
        }
        public function get setupComplete():ISignal{
            return (this._setupComplete);
        }
        public function get chosen():ISignal{
            return (this._chosen);
        }
        public function get info():ZodiacMonsterModel{
            return (this._info);
        }
        public function get monster():Asset{
            return (this._monster);
        }

    }
}//package gaia.moga.newuser.view.ui 
