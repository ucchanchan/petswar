//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.newuser.view.ui {
    import flash.display.*;
    import __AS3__.vec.*;
    import flash.geom.*;
    import gaia.moga.newuser.view.ui.*;

    class SelectionParticles {

        private var particles:Vector.<MovieClip>;
        private var _isAnimating:Boolean;

        function SelectionParticles(_arg1:MovieClip){
            this.particles = this.getParticles(_arg1);
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
                this.setupParticles();
            } else {
                this.teardownParticles();
            };
        }
        private function getParticles(_arg1:MovieClip):Vector.<MovieClip>{
            var _local2:int = _arg1.numChildren;
            var _local3:Vector.<MovieClip> = new Vector.<MovieClip>(_local2, true);
            while (_local2--) {
                _local3[_local2] = MovieClip(_arg1.getChildAt(_local2));
            };
            return (_local3);
        }
        private function setupParticles():void{
            var _local1:int = this.particles.length;
            while (_local1--) {
                this.setupParticle(this.particles[_local1]);
            };
        }
        private function teardownParticles():void{
            var _local1:int = this.particles.length;
            while (_local1--) {
                this.teardownParticle(this.particles[_local1]);
            };
        }
        private function setupParticle(_arg1:MovieClip):void{
            _arg1.gotoAndPlay(Math.ceil((Math.random() * 9)));
            _arg1.signal.add(this.initParticle);
        }
        private function initParticle(_arg1:MovieClip):void{
            _arg1.rotation = ((Math.random() * 20) - 100);
            _arg1.x = ((Math.random() * 80) - 40);
            _arg1.y = (Math.random() * 200);
            _arg1.scaleX = (_arg1.scaleY = ((Math.random() * 0.6) + 0.6));
            var _local2:Number = ((Math.random() * 0.5) + 0.5);
            _arg1.transform.colorTransform = new ColorTransform(_local2, _local2);
            _arg1.alpha = _local2;
            var _local3:String = ("s" + ((Math.random() * 4) | 0));
            _arg1.gotoAndPlay(_local3);
            _arg1.blendMode = "add";
        }
        private function teardownParticle(_arg1:MovieClip):void{
            _arg1.signal.remove(this.initParticle);
            _arg1.signal.add(this.killParticle);
        }
        private function killParticle(_arg1:MovieClip):void{
            _arg1.signal.remove(this.killParticle);
            _arg1.gotoAndStop(10);
        }

    }
}//package gaia.moga.newuser.view.ui 
