package com.wighawag.asset.load;

import nme.display.BitmapData;
import com.wighawag.asset.load.AssetManager;
import promhx.Promise;

class NMEEmbededAssetManager extends NMERemoteAssetManager, implements AssetManager {

    public function new(resourceMap : ResourceMap) {
        super(resourceMap);
    }

    override private function loadText(promise : Promise<Asset>, resource : Resource) : Void{
        var text = nme.Assets.getText(resource.path);
        promise.resolve(new TextAsset(resource.id, text));
    }

    override private function loadBitmap(promise : Promise<Asset>, resource : Resource) : Void{
        var bitmapData = nme.Assets.getBitmapData(resource.path);
        promise.resolve(new BitmapAsset(resource.id, bitmapData));
    }

}
