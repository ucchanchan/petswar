//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.ui.interaction {

    public class ClickAndDragState {

        private var _isDraggable:Boolean;
        private var _isClickable:Boolean;

        public static const CLICK_AND_DRAG:ClickAndDragState = new ClickAndDragState(true, true);
;
        public static const CLICK:ClickAndDragState = new ClickAndDragState(true, false);
;
        public static const DRAG:ClickAndDragState = new ClickAndDragState(false, true);
;
        public static const NONE:ClickAndDragState = new ClickAndDragState(false, false);
;

        public function ClickAndDragState(_arg1:Boolean, _arg2:Boolean){
            this._isClickable = _arg1;
            this._isDraggable = _arg2;
        }
        public function get isDraggable():Boolean{
            return (this._isDraggable);
        }
        public function get isClickable():Boolean{
            return (this._isClickable);
        }

    }
}//package alecmce.ui.interaction 
