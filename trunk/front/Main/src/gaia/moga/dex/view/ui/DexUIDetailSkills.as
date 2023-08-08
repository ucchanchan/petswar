//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.view.ui {
    import flash.display.*;
    import gaia.moga.dex.model.*;
    import gaia.moga.monster.model.actions.*;

    public class DexUIDetailSkills {

        private var mc:MovieClip;
        private var physical:DexUIDetailButton;
        private var zodiac:DexUIDetailButton;
        private var buff:DexUIDetailButton;
        private var example:DexUIDetailExample;
        private var target:DexUIDetailButton;

        public function DexUIDetailSkills(_arg1:MovieClip){
            this.mc = _arg1;
            this.physical = new DexUIDetailButton(_arg1.skill_0);
            this.zodiac = new DexUIDetailButton(_arg1.skill_1);
            this.buff = new DexUIDetailButton(_arg1.skill_2);
            this.example = new DexUIDetailExample(_arg1.example);
        }
        public function show(_arg1:DexMogaInstance):void{
            this.mc.description.text = "";
            var _local2:MonsterActions = _arg1.model.actions;
            this.physical.over.add(this.onOver);
            this.physical.out.add(this.onOut);
            this.physical.clicked.add(this.onClicked);
            this.physical.attack = (_local2) ? _local2.physicalAttack : null;
            this.zodiac.over.add(this.onOver);
            this.zodiac.out.add(this.onOut);
            this.zodiac.clicked.add(this.onClicked);
            this.zodiac.attack = (_local2) ? _local2.zodiacAttack : null;
            this.buff.over.add(this.onOver);
            this.buff.out.add(this.onOut);
            this.buff.clicked.add(this.onClicked);
            this.buff.attack = (_local2) ? _local2.buffAttack : null;
            this.target = this.physical;
            this.physical.isSelected = true;
            this.mc.description.text = _local2.physicalAttack.data.description;
        }
        private function onOver(_arg1:DexUIDetailButton):void{
            var _local2:Action = _arg1.attack;
            this.mc.description.text = _local2.data.description;
        }
        private function onOut(_arg1:DexUIDetailButton):void{
            this.mc.description.text = (this.target) ? this.target.attack.data.description : "";
        }
        private function onClicked(_arg1:DexUIDetailButton):void{
            if (this.target){
                this.target.isSelected = false;
            };
            this.target = _arg1;
            this.target.isSelected = true;
            this.mc.description.text = this.target.attack.data.description;
            this.example.show(this.target.attack);
        }
        public function cleanUp():void{
            this.target = null;
            this.mc.description.text = "";
            this.physical.over.removeAll();
            this.physical.out.removeAll();
            this.physical.clicked.removeAll();
            this.physical.attack = null;
            this.zodiac.over.removeAll();
            this.zodiac.out.removeAll();
            this.zodiac.clicked.removeAll();
            this.zodiac.attack = null;
            this.buff.over.removeAll();
            this.buff.out.removeAll();
            this.buff.clicked.removeAll();
            this.buff.attack = null;
        }

    }
}//package gaia.moga.dex.view.ui 
