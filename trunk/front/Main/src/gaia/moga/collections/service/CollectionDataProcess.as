//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.collections.service {
    import flash.events.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.collections.model.*;
    import com.gaiaonline.monster.service.process.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.*;

    public class CollectionDataProcess extends GSIProcess {

		[Inject]
        public var gsi:GSIDataService;
		[Inject]
        public var model:MogaCollectionsModel;
		[Inject]
        public var dispatcher:IEventDispatcher;

        public function CollectionDataProcess(){
            super("CollectionDataProcess");
        }
        override protected function onInit():void{
            this.gsi.getCollectionsData(this);
        }
        override protected function parse(_arg1:Object):Boolean{
            if (_arg1.error){
                this.dispatcher.dispatchEvent(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, Errors.GET_COLLECTION_DATA));
                return (false);
            };
            this.model.init(_arg1);
            return (true);
        }

    }
}//package gaia.moga.collections.service 
