/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.asset.load;
import wighawag.asset.load.AssetManager;
import wighawag.asset.load.Resource;
import haxe.xml.Fast;
class ResourceMap {

    private var resources : Map<String,Resource>;

    public function new(resourceMapXml : String) {
        resources = new Map();

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
