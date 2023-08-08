//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.data {
    import alecmce.async.*;
    import gaia.moga.app.*;
    import gaia.moga.data.attacks.*;
    import alecmce.io.*;
    import gaia.moga.data.locations.*;

    public class DataBundle extends AsyncBase {

		[Inject]
        public var config:AppConfig;
        private var parallel:ParallelAsyncs;
        public var attacks:AttackData;
        public var locations:LocationData;
        public var zodiacLanguage:Data;
        public var tipsLanguage:Data;
        public var timeLanguage:Data;
        public var questsLanguage:Data;
        public var monstersLanguage:Data;
        public var miscLanguage:Data;
        public var buffsLanguage:Data;
        public var itemsLanguage:Data;

        override protected function onInit():void{
            this.parallel = new ParallelAsyncs("DataBundle");
            var _local1:DataLoader = new DataLoader(this.config.parseURL("data/attacks.txt"));
            var _local2:DataLoader = new DataLoader(this.config.parseURL("data/{$LANGUAGE}/attacks.txt"));
            this.parallel.add((this.attacks = new AttackData(_local1, _local2)));
            var _local3:DataLoader = new DataLoader(this.config.parseURL("data/locations.txt"));
            this.parallel.add((this.locations = new LocationData(_local3)));
            this.itemsLanguage = new DataLoader(this.config.parseURL("data/{$LANGUAGE}/items.txt"));
            this.buffsLanguage = new DataLoader(this.config.parseURL("data/{$LANGUAGE}/buffs.xml"));
            this.miscLanguage = new DataLoader(this.config.parseURL("data/{$LANGUAGE}/misc.xml"));
            this.questsLanguage = new DataLoader(this.config.parseURL("data/{$LANGUAGE}/quests.xml"));
            this.timeLanguage = new DataLoader(this.config.parseURL("data/{$LANGUAGE}/time.xml"));
            this.tipsLanguage = new DataLoader(this.config.parseURL("data/{$LANGUAGE}/tips.xml"));
            this.zodiacLanguage = new DataLoader(this.config.parseURL("data/{$LANGUAGE}/zodiac.xml"));
            this.monstersLanguage = new DataLoader(this.config.parseURL("data/{$LANGUAGE}/monsters.xml"));
            this.parallel.add(this.itemsLanguage);
            this.parallel.add(this.buffsLanguage);
            this.parallel.add(this.miscLanguage);
            this.parallel.add(this.monstersLanguage);
            this.parallel.add(this.questsLanguage);
            this.parallel.add(this.timeLanguage);
            this.parallel.add(this.tipsLanguage);
            this.parallel.add(this.zodiacLanguage);
            this.parallel.complete.addOnce(this.onParallelComplete);
            this.parallel.error.addOnce(this.onParallelError);
            this.parallel.init();
        }
        private function onParallelComplete(_arg1:Async):void{
            this.parallel.error.removeAll();
            asyncComplete();
        }
        private function onParallelError(_arg1:Async, _arg2:String):void{
            this.parallel.complete.removeAll();
            asyncError(_arg2);
        }

    }
}//package gaia.moga.data 
