package com.wighawag.asset.load;
import com.wighawag.asset.load.AssetManager;
import nme.display.BitmapData;
class BitmapAsset implements Asset{

    public var id(default,null) : AssetId;

    public var bitmapData(default,null) : BitmapData;

    public function new(id : AssetId, bitmapData : BitmapData) {
        this.id = id;
        this.bitmapData = bitmapData;
    }
}
