//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.ui {
    import flash.display.*;
    import org.osflash.signals.*;
    import alecmce.services.*;

    public class MovieClipPlayhead {

        private var _target:MovieClip;
        private var _ticker:Ticker;
        private var _at:Signal;
        private var _map:Object;
        private var dFrame:int;
        private var targetFrame:int;

        public function MovieClipPlayhead(_arg1:MovieClip, _arg2:Ticker){
            this._ticker = _arg2;
            this._target = _arg1;
            this._at = new Signal(MovieClipPlayhead, String);
            this._map = this.getFrames(this._target);
        }
        public function get target():MovieClip{
            return (this._target);
        }
        public function get at():Signal{
            return (this._at);
        }
        public function goto(_arg1:String):Boolean{
            if (!this._map[_arg1]){
                return (false);
            };
            this.targetFrame = this._map[_arg1];
            this._target.gotoAndStop(this.targetFrame);
            this._at.dispatch(this, _arg1);
            return (true);
        }
        public function playTo(_arg1:String):Boolean{
            if (!this._map[_arg1]){
                return (false);
            };
            this.targetFrame = this._map[_arg1];
            var _local2:int = this._target.currentFrame;
            if (this.targetFrame == _local2){
                this._at.dispatch(this, _arg1);
                return (true);
            };
            this.dFrame = ((this.targetFrame > _local2)) ? 1 : -1;
            this._ticker.add(this.animate);
            return (true);
        }
        private function animate():void{
            if (this._target.currentFrame == this.targetFrame){
                this._ticker.remove(this.animate);
                this._at.dispatch(this, this._target.currentFrameLabel);
                return;
            };
            if (this.dFrame == 1){
                this._target.nextFrame();
            } else {
                this._target.prevFrame();
            };
        }
        private function getFrames(_arg1:MovieClip):Object{
            var _local3:FrameLabel;
            var _local2:Object = {};
            for each (_local3 in _arg1.currentLabels) {
                _local2[_local3.name] = _local3.frame;
            };
            return (_local2);
        }

    }
}//package alecmce.ui 
