//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller {
    import alecmce.async.*;
    import com.gaiaonline.monster.service.*;
    import org.robotlegs.mvcs.*;

    public class AsyncCommand extends Command {

		[Inject]
        public var service:AsyncService;
        private var _onComplete:Function;
        private var _onError:Function;

        protected function hook(_arg1:Async, _arg2:Function, _arg3:Function):void{
            this._onComplete = _arg2;
            this._onError = _arg3;
            if (_arg1.isComplete){
                _arg2(_arg1);
            } else {
                if (_arg1.isError){
                    _arg3(_arg1);
                } else {
                    commandMap.detain(this);
                    _arg1.complete.addOnce(this.completeHandler);
                    _arg1.error.addOnce(this.errorHandler);
                    this.service.push(_arg1);
                };
            };
        }
        private function completeHandler(_arg1:Async):void{
            var _local2:Function = this._onComplete;
            this.finalize(_arg1);
            _local2(_arg1);
        }
        private function errorHandler(_arg1:Async, _arg2:String=""):void{
            var _local3:Function = this._onError;
            this.finalize(_arg1);
            _local3(_arg1, _arg2);
        }
        private function finalize(_arg1:Async):void{
            _arg1.error.removeAll();
            _arg1.complete.removeAll();
            commandMap.release(this);
            this._onComplete = null;
            this._onError = null;
        }

    }
}//package com.gaiaonline.monster.controller 
