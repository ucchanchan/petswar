//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.ui.data.item {
    import alecmce.data.item.*;

    public class UIDataItemWrapper implements DataItem {

        private var _item:UIDataItem;

        public function UIDataItemWrapper(_arg1:UIDataItem){
            this._item = _arg1;
        }
        public function get item():UIDataItem{
            return (this._item);
        }
        public function toString():String{
            return (this._item.toString());
        }

    }
}//package alecmce.ui.data.item 
