package com.wighawag.asset.load;
import com.wighawag.asset.load.AssetManager;

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
