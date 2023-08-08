//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.model {
    import org.osflash.signals.*;
    import com.gaiaonline.monster.model.*;

    public class DexMogaInstance {

        public var id:uint;
        public var generic:DexMoga;
        public var model:MonsterModel;
        private var _isOnTeam:Boolean;
        private var _changed:Signal;

        public function DexMogaInstance(_arg1:uint, _arg2:DexMoga, _arg3:MonsterModel){
            this.id = _arg1;
            this.generic = _arg2;
            this.model = _arg3;
            this._changed = new Signal(DexMogaInstance);
        }
        public function get isOnTeam():Boolean{
            return (this._isOnTeam);
        }
        public function set isOnTeam(_arg1:Boolean):void{
            if (this._isOnTeam == _arg1){
                return;
            };
            this._isOnTeam = _arg1;
            this._changed.dispatch(this);
        }
        public function toString():String{
            return ((((((this.model.name + " ") + this.model.level) + " (") + this.generic.genericName) + ")"));
        }
        public function get changed():ISignal{
            return (this._changed);
        }

    }
}//package gaia.moga.dex.model 
