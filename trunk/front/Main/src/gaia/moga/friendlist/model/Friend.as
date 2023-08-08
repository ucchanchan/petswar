//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.friendlist.model {
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.view.components.battle.vo.*;

    public class Friend {

        private var _id:String;
        private var _name:String;
        private var _firstName:String;
        private var _count:uint;
        private var _picture:Asset;
        private var _whistleCount:uint;
        private var _availGifts:uint;
        private var fallback:String;
        private var _changed:Signal;
        public var attack:AttackResultVO;
        public var monster:MonsterModel;

        public function Friend(_arg1:Object, _arg2:Asset, _arg3:String){
            this._id = _arg1.user_id;
            this._name = (_arg1.name) ? _arg1.name : "";
            this._count = (((_arg1.monster_count) && ((_arg1.monster_count > 2)))) ? _arg1.monster_count : 2;
            this._firstName = (_arg1.first_name) ? _arg1.first_name : "";
            this._picture = _arg2;
            this._whistleCount = (this._whistleCount + uint(_arg1.whistle_count));
            this._availGifts = uint(_arg1.avail_gifts);
            this.fallback = _arg3;
            this._changed = new Signal(Friend);
        }
        public function get id():String{
            return (this._id);
        }
        public function get name():String{
            return (this._name);
        }
        public function get firstName():String{
            return (this._firstName);
        }
        public function get count():uint{
            return (this._count);
        }
        public function set count(_arg1:uint):void{
            if (this._count == _arg1){
                return;
            };
            this._count = _arg1;
            this._changed.dispatch(this);
        }
        public function get availableGiftCount():uint{
            return (this._availGifts);
        }
        public function get picture():Asset{
            var useBlankProfile:Boolean;
            try {
                this._picture.init();
            } catch(error:Error) {
                useBlankProfile = true;
                _picture = new MovieClipAssetLoader(fallback);
                _picture.init();
            } finally {
                var _local4:* = this._picture;
                //unresolved jump
                1;
                return (_local4);
            };
        }
        public function get changed():ISignal{
            return (this._changed);
        }
        public function get whistleCount():uint{
            return (this._whistleCount);
        }

    }
}//package gaia.moga.friendlist.model 
