//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.newuser.view.ui {
    import flash.display.*;
    import flash.utils.*;
    import org.osflash.signals.*;
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import gaia.moga.newuser.view.ui.*;
    import alecmce.geom3D.*;
    import alecmce.ui.widget.*;

    class SelectionCarousel {

        private var _ui:MovieClip;
        private var carousel:Carousel;
        private var monsters:Vector.<SelectionItem>;
        private var assetMap:Dictionary;
        private var viewpoint:Viewpoint3D;
        private var stack:AutoAnimStack;
        private var _selection:SelectionItem;
        private var _chosen:Signal;
        private var _selected:Signal;

        static const FAR_AWAY:int = -250;
        static const NEAR:int = -150;
        static const ROTATE:Number = 0.01;

        function SelectionCarousel(_arg1:MovieClip){
            this._ui = _arg1;
            this._ui.alpha = 0;
            this._chosen = new Signal(ZodiacMonsterModel);
            this._selected = new Signal(ZodiacMonsterModel);
            this.viewpoint = new Viewpoint3D(400, 200);
            this.viewpoint.position.y = -40;
            this.viewpoint.position.z = FAR_AWAY;
            this.viewpoint.look.j = 40;
            this.viewpoint.look.k = 100;
            this.viewpoint.theta = (Math.PI / 10);
            this.carousel = new Carousel(this.viewpoint, 25);
            this.carousel.x = 320;
            this.carousel.y = 20;
            _arg1.addChild(this.carousel);
            this.stack = new AutoAnimStack();
        }
        public function setItems(_arg1:Vector.<SelectionItem>):void{
            if (this.monsters){
                this.stack.push(new ClearItems(this, this.viewpoint, this.monsters));
            };
            this.monsters = _arg1;
            if (this.monsters){
                this.stack.push(new SetItems(this, this.viewpoint, this.monsters));
            };
        }
        public function selectItem(_arg1:uint):void{
            var _local2:SelectionItem;
            for each (_local2 in this.monsters) {
                if (_local2.info.id == _arg1){
                    this.onItemSelected(_local2);
                    break;
                };
            };
        }
        function deselect():void{
            if (!this._selection){
                return;
            };
            this._selection.chosen.remove(this.onChosen);
            this._selection.isSelected = false;
            this._selection = null;
        }
        function setupItems(_arg1:Vector.<SelectionItem>):void{
            var _local3:SelectionItem;
            this.assetMap = new Dictionary(true);
            var _local2:int = _arg1.length;
            while (_local2--) {
                _local3 = _arg1[_local2];
                _local3.selected.add(this.onItemSelected);
                this.assetMap[_local3.self] = _local3;
                this.carousel.addItem(_local3.self);
            };
        }
        function clearItems(_arg1:Vector.<SelectionItem>):void{
            var _local3:SelectionItem;
            var _local2:int = _arg1.length;
            while (_local2--) {
                _local3 = _arg1[_local2];
                _local3.selected.removeAll();
                _local3.isSelected = false;
                _local3.dispose();
            };
            this.carousel.clearItems();
        }
        private function onItemSelected(_arg1:SelectionItem):void{
            this.carousel.bringToFront(_arg1);
            this.deselect();
            this._selection = _arg1;
            this._selection.chosen.addOnce(this.onChosen);
            this._selected.dispatch(_arg1.info);
            _arg1.isSelected = true;
        }
        private function onChosen(_arg1:SelectionItem, _arg2:Boolean):void{
            if (!_arg2){
                this._selection.isSelected = false;
                this.carousel.rotate(SelectionCarousel.ROTATE);
                return;
            };
            this._chosen.dispatch(_arg1.info);
        }
        public function rotate(_arg1:Number):void{
            this.carousel.rotate(_arg1);
        }
        public function get chosen():ISignal{
            return (this._chosen);
        }
        public function get selected():ISignal{
            return (this._selected);
        }
        public function get ui():MovieClip{
            return (this._ui);
        }
        public function get selection():SelectionItem{
            return (this._selection);
        }

    }
}//package gaia.moga.newuser.view.ui 
