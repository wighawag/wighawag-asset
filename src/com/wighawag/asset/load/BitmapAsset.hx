package com.wighawag.asset.load;
import com.wighawag.asset.load.AssetManager;
import nme.display.BitmapData;
class BitmapAsset implements Asset{

    public var id : AssetId;

    public var bitmapData : BitmapData;

    public function new(id : AssetId, bitmapData : BitmapData) {
        this.id = id;
        this.bitmapData = bitmapData;
    }
}
