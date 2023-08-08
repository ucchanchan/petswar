//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.service {
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import gaia.moga.dex.model.*;
    import gaia.moga.dex.assets.*;
    import com.gaiaonline.monster.service.process.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.model.zodiac.*;
    import com.gaiaonline.monster.view.components.battle.fight.*;
    import gaia.moga.monster.model.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.service.vo.*;

    public class DexSetupProcess extends GSIProcess {

		[Inject]
        public var server:GSIDataService;
		[Inject]
        public var dexModel:DexModel;
		[Inject]
        public var assets:MonsterAssetsFactory;
		[Inject]
        public var text:TextService;
		[Inject]
        public var ranch:HomeRanchModel;
		[Inject]
        public var mogas:MogaFactory;
		[Inject]
        public var zodiac:ZodiacModel;

        public var collection:AssetCollection;

        public function DexSetupProcess(_arg1:String="DexSetupProcess"){
            super(_arg1);
        }
        override protected function onInit():void{
            this.server.getMonsterDexData(this);
        }
        override protected function parse(_arg1:Object):Boolean{
            var _local2:*;
            this.collection = new AssetCollection("DexSetupProcess-Collection");
            for (_local2 in _arg1) {
                this.parseID(_local2, _arg1);
            };
            this.dexModel.isSetup = true;
            return (true);
        }
        protected function parseID(_arg1, _arg2:Object):void{
            var _local3:DexMoga = this.dexModel.getMoga(_arg1);
            if (_local3){
                this.updateInstances(_local3, _arg2[_arg1].mogas);
            } else {
                this.dexModel.addMoga(this.generateMoga(_arg1, _arg2[_arg1]));
            };
        }
        protected function generateMoga(_arg1:uint, _arg2:Object):DexMoga{
            var _local3:DexMogaBundle = this.generateBundle(_arg1);
            var _local4:DexMoga = new DexMoga(_local3);
            _local4.id = _arg1;
            _local4.series = 0;
            _local4.rarity = _arg2.rarity;
            _local4.zodiac = _arg2.zodiac;
            _local4.effectiveness = this.zodiac.getZodiacByID(_local4.zodiac).effectiveness;
            var _local5:MonsterTextVO = this.text.getMonsterText(_arg1);
            _local4.genericName = _local5.name;
            _local4.description = _local5.description;
            this.updateInstances(_local4, _arg2.mogas);
            return (_local4);
        }
        protected function updateInstances(_arg1:DexMoga, _arg2:Object):void{
            var _local3:*;
            var _local4:MonsterModel;
            var _local5:DexMogaInstance;
            for (_local3 in _arg2) {
                _local4 = this.mogas.read(_local3);
                _local5 = _arg1.getInstanceByID(_local3);
                if (!_local5){
                    _local5 = new DexMogaInstance(_local3, _arg1, _local4);
                    _arg1.addInstance(_local5);
                };
            };
        }
        private function generateBundle(_arg1:uint):DexMogaBundle{
            var _local2:Asset = this.assets.monsterIconByID(_arg1);
            var _local3:Asset = this.assets.monsterTeamIconByID(_arg1);
            var _local4:FightMonster = this.assets.monsterFightByID(_arg1, false);
            var _local5:DexMogaBundle = new DexMogaBundle(_local2, _local3, _local4);
            this.collection.add(_local5);
            return (_local5);
        }

    }
}//package gaia.moga.dex.service 
