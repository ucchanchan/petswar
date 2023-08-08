//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.view.ui {
    import flash.display.*;
    import org.osflash.signals.*;
    import alecmce.ui.button.*;
    import gaia.moga.monster.model.actions.*;

    public class DexUIDetailButton {

        private var button:MovieClipButton;
        private var _attack:Action;
        private var _clicked:Signal;
        private var _over:Signal;
        private var _out:Signal;

        public function DexUIDetailButton(_arg1:MovieClip){
            this.button = new MovieClipButton(_arg1, 1, 2, 2, 3);
            this._out = new Signal(DexUIDetailButton);
            this._over = new Signal(DexUIDetailButton);
            this._clicked = new Signal(DexUIDetailButton);
        }
        public function get attack():Action{
            return (this._attack);
        }
        public function set attack(_arg1:Action):void{
            this._attack = _arg1;
            if (this._attack){
                this.updateData();
            } else {
                this.cleanUp();
            };
        }
        public function get isSelected():Boolean{
            return (!(this.button.isEnabled));
        }
        public function set isSelected(_arg1:Boolean):void{
            this.button.isEnabled = !(_arg1);
        }
        private function updateData():void{
            var _local1:MovieClip = this.button.ui;
            _local1.skillName.text = this.attack.data.name;
            _local1.skillCount.text = ((this.attack.quantity + "/") + this.attack.max);
            this.button.over.add(this.onOver);
            this.button.out.add(this.onOut);
            this.button.clicked.add(this.onClick);
            this.button.isEnabled = true;
        }
        private function cleanUp():void{
            var _local1:MovieClip = this.button.ui;
            _local1.skillName.text = "";
            _local1.skillCount.text = "";
            this.button.clicked.removeAll();
            this.button.isEnabled = true;
        }
        private function onOver(_arg1:MovieClipButton):void{
            this._over.dispatch(this);
        }
        private function onOut(_arg1:MovieClipButton):void{
            this._out.dispatch(this);
        }
        private function onClick(_arg1:MovieClipButton):void{
            this._clicked.dispatch(this);
        }
        public function get clicked():ISignal{
            return (this._clicked);
        }
        public function get over():ISignal{
            return (this._over);
        }
        public function get out():ISignal{
            return (this._out);
        }

    }
}//package gaia.moga.dex.view.ui 
