//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.ui {
    import flash.display.*;
    import flash.events.*;
    import com.gskinner.motion.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import flash.geom.*;
    import alecmce.ui.data.item.*;
    import com.gskinner.motion.easing.*;

    public class BuffListItem implements UIDataItem {

        private var _name:String;
        private var _asset:Asset;
        private var _isDragging:Boolean;
        private var _rollOver:Signal;
        private var _rollOut:Signal;
        private var buffContainer:MovieClip;
        private var position:Point;

        private static const DURATION:Number = 0.5;

        public function BuffListItem(_arg1:String, _arg2:Asset){
            this._name = _arg1;
            this._asset = _arg2;
            this._rollOver = new Signal();
            this._rollOut = new Signal();
        }
        public function count(_arg1:int):void{
        }
        public function apply(_arg1:Sprite, _arg2:Rectangle, _arg3:UIDataItemState):void{
            switch (_arg3){
                case UIDataItemState.ADD:
                    this.addTo(_arg1, _arg2);
                    break;
                case UIDataItemState.PRIMARY:
                    _arg1.setChildIndex(this._asset.self, (_arg1.numChildren - 1));
                case UIDataItemState.MOVE:
                    this.moveTo(_arg2);
                    break;
                case UIDataItemState.REMOVE:
                    this.removeFrom(_arg1);
                    break;
                case UIDataItemState.SWAP:
                    break;
            };
        }
        private function addTo(_arg1:Sprite, _arg2:Rectangle):void{
            var _local3:DisplayObject = this._asset.self;
            var _local4:DisplayObjectContainer = _local3.parent;
            this.buffContainer = MovieClip(_arg1);
            _local3.addEventListener(MouseEvent.ROLL_OVER, this.onRollOver, false, 0, true);
            _local3.addEventListener(MouseEvent.ROLL_OUT, this.onRollOut, false, 0, true);
            if (!_local4){
                _local3.x = _arg2.left;
                _local3.y = _arg2.top;
                _arg1.addChild(_local3);
            } else {
                if (((_local4) && (!((_local4 == _arg1))))){
                    this.position = new Point(_local3.x, _local3.y);
                    this.position = _local4.localToGlobal(this.position);
                    _local4.removeChild(_local3);
                    this.position = _arg1.globalToLocal(this.position);
                    _local3.x = this.position.x;
                    _local3.y = this.position.y;
                    _arg1.addChild(_local3);
                };
                this.moveTo(_arg2);
            };
        }
        public function showDescription(_arg1:MovieClip, _arg2:String, _arg3:String):void{
            _arg1.title.htmlText = _arg2;
            _arg1.main.htmlText = _arg3;
        }
        private function moveTo(_arg1:Rectangle):void{
            new GTween(this._asset.self, DURATION, {x:_arg1.left, y:_arg1.y}, {ease:Quadratic.easeInOut});
        }
        private function removeFrom(_arg1:Sprite):void{
            new GTween(this._asset.self, DURATION, {alpha:0}, {ease:Quadratic.easeIn, onComplete:this.onRemoveComplete});
        }
        private function onRemoveComplete(_arg1:GTween):void{
            var _local2:DisplayObject = this._asset.self;
            if (_local2.parent){
                _local2.parent.removeChild(_local2);
            };
        }
        private function onRollOver(_arg1:MouseEvent):void{
            this._rollOver.dispatch(this);
        }
        private function onRollOut(_arg1:MouseEvent):void{
            this._rollOut.dispatch(this);
        }
        public function get ui():Sprite{
            return (Sprite(this._asset.self));
        }
        public function get name():String{
            return (this._name);
        }
        public function toString():String{
            return (this._name);
        }
        public function get isDragging():Boolean{
            return (this._isDragging);
        }
        public function set isDragging(_arg1:Boolean):void{
            this._isDragging = _arg1;
        }
        public function get rollOver():Signal{
            return (this._rollOver);
        }
        public function get rollOut():Signal{
            return (this._rollOut);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.ui 
