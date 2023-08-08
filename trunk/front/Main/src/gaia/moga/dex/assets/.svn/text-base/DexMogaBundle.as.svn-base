//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.assets {
    import flash.display.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.view.components.battle.fight.*;
    import flash.geom.*;
    import gaia.moga.assets.bundle.*;

    public class DexMogaBundle extends GenericBundle {

        private var _icon:BitmapData;
        private var _team:BitmapData;
        private var _fight:FightMonster;

        private static const TEAM:String = "TEAM";
        private static const ICON:String = "ICON";

        public function DexMogaBundle(_arg1:Asset, _arg2:Asset, _arg3:FightMonster){
            super("DexMogaBundle");
            this._fight = _arg3;
            collection.add(_arg1, ICON);
            collection.add(_arg2, TEAM);
            this._fight = _arg3;
        }
        public function get icon():BitmapData{
            return (this._icon);
        }
        public function get team():BitmapData{
            return (this._team);
        }
        public function get fight():FightMonster{
            return (this._fight);
        }
        override protected function assetComplete():void{
            this._icon = this.generateBitmapData(collection.getAsset(ICON));
            this._team = this.generateBitmapData(collection.getAsset(TEAM));
            super.assetComplete();
        }
        private function generateBitmapData(_arg1:Asset, _arg2:int=0, _arg3:int=0):BitmapData{
            var _local4:DisplayObject = _arg1.self;
            var _local5:BitmapData = new BitmapData(_local4.width, _local4.height, true, 0);
            var _local6:Matrix = new Matrix(1, 0, 0, 1, _arg2, _arg3);
            _local5.draw(_local4, _local6, null, null, null, true);
            return (_local5);
        }

    }
}//package gaia.moga.dex.assets 
