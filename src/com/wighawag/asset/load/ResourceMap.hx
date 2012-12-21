package com.wighawag.asset.load;
import com.wighawag.asset.load.AssetManager;
import com.wighawag.asset.load.Resource;
import haxe.xml.Fast;
class ResourceMap {

    private var resources : Hash<Resource>;

    public function new(resourceMapXml : String) {
        resources = new Hash();

        var fast = new Fast(Xml.parse(resourceMapXml).firstElement());
        var pathPrefix = fast.att.pathPrefix;
        for (resource in fast.nodes.resource){
            var type : ResourceType;
            if (resource.att.type == "bitmap"){
                type = ResourceType.Bitmap;
            }
            else if (resource.att.type == "text"){
                type = ResourceType.Text;
            }else if (resource.att.type == "bytes"){
	            type = ResourceType.Bytes;
            }else{
                type = ResourceType.Text;
            }
            var resource = new Resource(resource.att.id,pathPrefix + resource.att.path, type, Std.parseInt(resource.att.size));
            resources.set(resource.id, resource);
        }

    }

    public function get(assetId : AssetId) : Resource {
        return resources.get(assetId);
    }
}
