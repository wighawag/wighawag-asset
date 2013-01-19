package com.wighawag.asset.entity;

import haxe.xml.Fast;
import com.wighawag.system.EntityTypeComponent;
import com.wighawag.system.EntityType;

class EntityTypeLibrary {

    private var types : Hash<EntityType>;


    public function new(xml : String){//TODO? : }, componentFactory : EntityTypeComponentFactory) {
        types = new Hash();

        var x = new Fast( Xml.parse(xml).firstElement() );
        for (typeDefinition in x.nodes.type){
            var typeId : String = typeDefinition.att.id;

            var components : Array<EntityTypeComponent> = new Array();
            for (componentDefinition in typeDefinition.elements){
                var className = componentDefinition.name;
                //TODO have className find their package in some setup in the xml or another one ?
                //TODO? use componentFactory if available
                var clazz = Type.resolveClass(className);
                // TODO find a better mechanism to initialise components:
                var instance : Dynamic = null;
                try{
                    instance = Type.createInstance(clazz, [componentDefinition.x]); // assume the component has an empty constructor
                    components.push(instance);
                }catch(e : Dynamic){
                    Report.anError("EntityTypeLibrary", "EntityType with id " + typeId + " has a component that cannot be instanciated : " + className, "make sure this component has an constrcutor acepting one xml (Xml) argument");
                }

            }

            if(types.exists(typeId)){
                Report.anError("EntityTypeLibrary", "EntityType with id " + typeId + " already exist in the library.");
            }else{
                var type = new EntityType(typeId);
                type.setup(components);
                types.set(typeId, type);
            }
        }
    }

    public function get(typeId : String) : EntityType{
        var type = types.get(typeId);
        if(type == null){
            Report.anError("EntityTypeLibrary", "No EntityType with id " + typeId);
        }
        return type;
    }

}
