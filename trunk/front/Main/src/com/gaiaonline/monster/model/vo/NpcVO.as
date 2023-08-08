//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model.vo {
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;

    public class NpcVO {

        public var id:int;
        public var description:String;
        public var name:String;
        public var type:String;
        public var monsters:Vector.<MonsterModel>;
        public var index:int;
        public var monster:MonsterModel;

        public function NpcVO(_arg1:Object, _arg2:Vector.<MonsterModel>){
            if (_arg1){
                this.id = _arg1.id;
                this.name = _arg1.name;
                this.description = _arg1.description;
                this.type = _arg1.npc_type;
            } else {
                this.id = -1;
                this.name = _arg2[0].name;
                this.description = _arg2[0].description;
                this.type = "-1";
            };
            this.monsters = _arg2;
            this.index = 0;
            this.monster = _arg2[0];
            while (this.monster.hp == 0) {
                this.monster = _arg2[++this.index];
            };
        }
        public function getCurrentMonster():void{
            while ((((this.index < this.monsters.length)) && ((this.monster.hp == 0)))) {
                this.monster = ((++this.index == this.monsters.length)) ? this.monsters[(this.monsters.length - 1)] : this.monsters[this.index];
            };
        }

    }
}//package com.gaiaonline.monster.model.vo 
