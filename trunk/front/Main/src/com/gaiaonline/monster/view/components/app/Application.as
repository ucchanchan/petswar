//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.app {
    import flash.display.*;
    import com.gaiaonline.monster.view.components.app.panel.*;
    import gaia.moga.assets.bundle.*;
    import com.gaiaonline.monster.view.components.app.overlay.*;
    import com.gaiaonline.monster.view.dialog.*;
    import com.gaiaonline.monster.view.components.tooltip.*;
    import flash.external.*;

    public class Application extends Sprite {

        private var panel:Panels;
        private var dialog:Dialog;
        private var top:Sprite;
        private var overlay:PanelStack;
        private var tips:ToolTips;
        private var loading:Loading;
        private var pauseLayer:Sprite;
        private var pauseBitmap:Bitmap;

        public function Application(_arg1:AppAssetsBundle){
            ExternalInterface.addCallback("pause", this.pause);
            ExternalInterface.addCallback("resume", this.resume);
            this.top = new Sprite();
            this.panel = new Panels(_arg1.streak, this.top);
            this.dialog = new Dialog(_arg1.dialog);
            this.overlay = new PanelStack();
            this.tips = new ToolTips(_arg1.tips);
            this.loading = new Loading(_arg1.loading);
            addChild(this.panel);
            addChild(this.top);
            addChild(this.overlay);
            addChild(this.tips);
            addChild(this.loading);
            addChild(this.dialog);
            addChild((this.pauseLayer = new Sprite()));
        }
        public function pause():void{
            if (this.pauseBitmap){
                return;
            };
            var _local1:BitmapData = new BitmapData(stage.stageWidth, stage.stageHeight);
            _local1.draw(stage);
            this.pauseBitmap = new Bitmap(_local1);
            this.pauseLayer.addChild(this.pauseBitmap);
        }
        public function resume():void{
            if (this.pauseBitmap == null){
                return;
            };
            this.pauseLayer.removeChild(this.pauseBitmap);
            this.pauseBitmap.bitmapData.dispose();
            this.pauseBitmap = null;
        }

    }
}//package com.gaiaonline.monster.view.components.app 
