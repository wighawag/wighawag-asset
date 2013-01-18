package com.wighawag.asset.entity;

import com.wighawag.system.EntityType;

class EntityTypeLibrary {

    private var types : Hash<EntityType>;

    // TODO use xml ?
    public function new(types : Array<EntityType>) {
        this.types = new Hash();
        for(type in types){
            if(this.types.exists(type.id)){
                Report.anError("EntityTypeLibrary", "EntityType with id " + type.id + " already exist in the library.");
            }else{
                this.types.set(type.id, type);
            }
        }
    }

    public function get(typeName : String) : EntityType{
        return types.get(typeName);
    }

}
