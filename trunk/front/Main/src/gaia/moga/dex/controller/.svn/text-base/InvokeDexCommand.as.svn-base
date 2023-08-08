//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.controller {
    import com.gaiaonline.monster.model.*;
    import gaia.moga.dex.model.*;
    import gaia.moga.dex.assets.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.assets.*;
    import alecmce.services.*;
    import gaia.moga.dex.view.ui.*;
    import gaia.moga.dex.service.*;
    import com.gaiaonline.monster.controller.*;
    import gaia.moga.*;

    public class InvokeDexCommand extends AsyncCommand {

		[Inject]
        public var event:DexEvent;
		[Inject]
        public var app:ApplicationModel;
		[Inject]
        public var process:DexSetupProcess;
		[Inject]
        public var bundle:DexAssetBundle;
		[Inject]
        public var model:DexModel;
		[Inject]
        public var ticker:Ticker;
		[Inject]
        public var zodiac:ZodiacFactory;

        override public function execute():void{
            dispatch(new ApplicationEvent(ApplicationEvent.LOADING));
            var _local1:ParallelAsyncs = new ParallelAsyncs("InvokeDex-Async");
            _local1.add(this.process);
            _local1.add(this.bundle);
            hook(_local1, this.onComplete, this.onError);
        }
        private function onComplete(_arg1:Async):void{
            var _local2:DexUI = new DexUI(this.bundle, this.ticker, this.zodiac);
            _local2.limit = 3;
            _local2.data = this.model;
            _local2.isLocked = !((this.app.state == ApplicationState.HOME));
            var _local3:MonsterModel = this.event.monster;
            if (_local3){
                _local2.instance = this.model.getInstance(uint(_local3.id));
            };
            dispatch(new PanelsEvent(PanelsEvent.ADD_OVERLAY, _local2));
            dispatch(new ApplicationEvent(ApplicationEvent.NOT_LOADING));
            if (this.process.collection){
                this.process.collection.init();
            };
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, Errors.UNABLE_TO_LOAD_DEX_ASSETS));
            dispatch(new ApplicationEvent(ApplicationEvent.NOT_LOADING));
        }

    }
}//package gaia.moga.dex.controller 
