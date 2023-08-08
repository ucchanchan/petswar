//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.gwitter {
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.controller.*;
    import gaia.moga.*;

    public class PostToGwitterCommand extends AsyncCommand {

		[Inject]
        public var event:GwitterEvent;
		[Inject]
        public var process:PostToGwitter;

        override public function execute():void{
            this.process.moga = this.event.moga;
            hook(this.process, this.onComplete, this.onError);
        }
        private function onComplete(_arg1:Async):void{
        }
        private function onError(_arg1:Async, _arg2:String):void{
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, Errors.GWITTER_FAILED));
        }

    }
}//package gaia.moga.gwitter 
