//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.list {
    import flash.display.*;
    import org.osflash.signals.*;

    public final class ListItem {

        public var mc:MovieClip;
        private var _datum:ListDatum;
        private var _isDefined:Boolean;
        private var _cleared:Signal;
        private var _defined:Signal;

        public function ListItem(_arg1:MovieClip){
            this.mc = _arg1;
            _arg1.visible = false;
            this._cleared = new Signal(ListItem, ListDatum);
            this._defined = new Signal(ListItem, ListDatum);
        }
        public function get datum():ListDatum{
            return (this._datum);
        }
        public function set datum(_arg1:ListDatum):void{
            if (this._datum == _arg1){
                return;
            };
            if (this._datum){
                this._datum.clear(this.mc);
                this._isDefined = false;
                this._cleared.dispatch(this, this._datum);
            };
            this._datum = _arg1;
            this.mc.visible = !((this._datum == null));
            if (this._datum){
                this._datum.apply(this.mc);
                this._isDefined = true;
                this._defined.dispatch(this, this._datum);
            };
        }
        public function get cleared():ISignal{
            return (this._cleared);
        }
        public function get defined():ISignal{
            return (this._defined);
        }
        public function get toString():String{
            return (this._datum.toString());
        }
        public function get isDefined():Boolean{
            return (this._isDefined);
        }

    }
}//package alecmce.list 
