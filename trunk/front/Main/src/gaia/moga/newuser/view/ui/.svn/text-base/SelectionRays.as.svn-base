//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.newuser.view.ui {
    import flash.display.*;
    import __AS3__.vec.*;
    import gaia.moga.newuser.view.ui.*;

    class SelectionRays {

        private var rays:Vector.<MovieClip>;
        private var rayCount:Number;
        private var _isAnimating:Boolean;

        function SelectionRays(_arg1:MovieClip){
            this.rays = this.getRays(_arg1);
            this.rayCount = this.rays.length;
            this._isAnimating = true;
        }
        public function get isAnimating():Boolean{
            return (this._isAnimating);
        }
        public function set isAnimating(_arg1:Boolean):void{
            if (this._isAnimating == _arg1){
                return;
            };
            this._isAnimating = _arg1;
            if (_arg1){
                this.setupRays();
            } else {
                this.teardownRays();
            };
        }
        private function getRays(_arg1:MovieClip):Vector.<MovieClip>{
            var _local2:int = _arg1.numChildren;
            var _local3:Vector.<MovieClip> = new Vector.<MovieClip>(_local2, true);
            while (_local2--) {
                _local3[_local2] = MovieClip(_arg1.getChildAt(_local2));
            };
            return (_local3);
        }
        private function setupRays():void{
            var _local1:int = this.rayCount;
            while (_local1--) {
                this.setupRay(this.rays[_local1], _local1);
            };
        }
        private function teardownRays():void{
            var _local1:int = this.rayCount;
            while (_local1--) {
                this.teardownRay(this.rays[_local1]);
            };
        }
        private function setupRay(_arg1:MovieClip, _arg2:int):void{
            var _local3:Number = (_arg2 / this.rayCount);
            _arg1.gotoAndPlay(Math.ceil((_local3 * _arg1.totalFrames)));
        }
        private function teardownRay(_arg1:MovieClip):void{
            _arg1.gotoAndStop(1);
        }

    }
}//package gaia.moga.newuser.view.ui 
