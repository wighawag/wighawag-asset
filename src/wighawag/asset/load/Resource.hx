/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.asset.load;
import wighawag.asset.load.AssetManager;

enum ResourceType {
    Text;
    Bitmap;
	Bytes;
}

class Resource {

    public var id : AssetId;
    public var path : String;
    public var type : ResourceType;
    public var size : Int;

    public function new(id : AssetId, path : String, type : ResourceType, size : Int) {
        this.id = id;
        this.path = path;
        this.type = type;
        this.size = size;
    }
}
