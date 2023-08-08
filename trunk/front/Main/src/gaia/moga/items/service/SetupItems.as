//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.items.service {
    import __AS3__.vec.*;
    import alecmce.async.*;
    import gaia.moga.data.*;
    import gaia.moga.items.model.*;
    import gaia.moga.data.parser.*;
    import gaia.moga.app.*;

    public class SetupItems extends AsyncBase {

		[Inject]
        public var config:AppConfig;
		[Inject]
        public var data:DataBundle;
		[Inject]
        public var factory:ItemFactory;

        override protected function onInit():void{
            if (this.data.isComplete){
                this.setup(this.data);
            } else {
                if (this.data.isError){
                    this.onError(this.data, "Unable to load data");
                } else {
                    this.data.error.addOnce(this.onError);
                    this.data.complete.addOnce(this.setup);
                    this.data.init();
                };
            };
        }
        private function setup(_arg1:DataBundle):void{
            _arg1.error.removeAll();
            this.parseData(_arg1.itemsLanguage.data);
            asyncComplete();
        }
        private function onError(_arg1:DataBundle, _arg2:String):void{
            _arg1.complete.removeAll();
            asyncError(_arg2);
        }
        private function parseData(_arg1:String):void{
            var _local4:CategoryData;
            var _local2:ParseData = new ParseData();
            var _local3:Vector.<CategoryData> = _local2.parse(_arg1);
            for each (_local4 in _local3) {
                this.factory.create(_local4);
            };
        }

    }
}//package gaia.moga.items.service 
