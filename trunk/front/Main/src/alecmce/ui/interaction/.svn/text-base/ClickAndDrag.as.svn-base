//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.ui.interaction {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;

    public class ClickAndDrag {

        protected var _state:ClickAndDragState;
        protected var _master:InteractiveObject;
        protected var _mouseDown:Signal;
        protected var _beginDrag:Signal;
        protected var _clicked:Signal;
        protected var _dragging:Signal;
        protected var _endDrag:Signal;
        protected var _rollOver:Signal;
        protected var _isDragging:Boolean;
        protected var _offsetX:Number;
        protected var _offsetY:Number;

        public function ClickAndDrag(_arg1:InteractiveObject){
            this._master = _arg1;
            this._mouseDown = new Signal(InteractiveObject);
            this._rollOver = new Signal(InteractiveObject);
            this._beginDrag = new Signal(InteractiveObject);
            this._clicked = new Signal(InteractiveObject);
            this._dragging = new Signal(InteractiveObject);
            this._endDrag = new Signal(InteractiveObject);
            this.state = ClickAndDragState.CLICK_AND_DRAG;
            this.updateListeners();
        }
        public function get state():ClickAndDragState{
            return (this._state);
        }
        public function set state(_arg1:ClickAndDragState):void{
            if (this._state == _arg1){
                return;
            };
            this._state = _arg1;
            this.updateListeners();
        }
        public function finalize():void{
            this._state = null;
            this.removeListeners();
            this._mouseDown.removeAll();
            this._beginDrag.removeAll();
            this._clicked.removeAll();
            this._dragging.removeAll();
            this._endDrag.removeAll();
            this._master = null;
        }
        protected function updateListeners():void{
            if (((this.state) && (!((this.state == ClickAndDragState.NONE))))){
                this._master.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            };
            this._master.addEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
        }
        protected function removeListeners():void{
            this._master.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            this._master.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
            this._master.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        }
        protected function onRollOver(_arg1:MouseEvent):void{
            this._rollOver.dispatch(this._master);
        }
        protected function onMouseDown(_arg1:MouseEvent):void{
            if (this._state != ClickAndDragState.NONE){
                this._mouseDown.dispatch(this._master);
            };
            if (this._state.isDraggable){
                this._master.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
            };
            if (this._state.isClickable){
                this._master.stage.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            };
            this._isDragging = false;
            this._offsetX = (this._master.x - this._master.parent.mouseX);
            this._offsetY = (this._master.y - this._master.parent.mouseY);
        }
        protected function onMouseMove(_arg1:MouseEvent):void{
            this._master.x = (this._master.parent.mouseX + this._offsetX);
            this._master.y = (this._master.parent.mouseY + this._offsetY);
            _arg1.updateAfterEvent();
            if (this._isDragging){
                this._dragging.dispatch(this._master);
            } else {
                this._isDragging = true;
                this._beginDrag.dispatch(this._master);
            };
        }
        protected function onMouseUp(_arg1:MouseEvent):void{
            this._master.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
            this._master.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            if (this._isDragging){
                this._endDrag.dispatch(this._master);
            } else {
                this._clicked.dispatch(this._master);
            };
        }
        public function get dragging():Signal{
            return (this._dragging);
        }
        public function get beginDrag():Signal{
            return (this._beginDrag);
        }
        public function get rollOver():Signal{
            return (this._rollOver);
        }
        public function get endDrag():Signal{
            return (this._endDrag);
        }
        public function get clicked():Signal{
            return (this._clicked);
        }
        public function get mouseDown():Signal{
            return (this._mouseDown);
        }

    }
}//package alecmce.ui.interaction 
