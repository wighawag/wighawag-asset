package com.wighawag.asset.load;
import com.wighawag.asset.load.AssetManager;
class TextAsset implements Asset {

    public var id : AssetId;

    public var text : String;

    public function new(id : AssetId, data : String) {
        this.id = id;
        this.text = data;
    }
}
