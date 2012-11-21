package com.wighawag.asset.load;

import nme.display.BitmapData;
import com.wighawag.asset.load.AssetManager;
import promhx.Promise;

class NMEEmbededAssetManager extends NMERemoteAssetManager, implements AssetManager {



//    private var resourceMap : ResourceMap;
//
//    private var promises : Hash<Promise<Asset>>;
//    private var batchPromises : Hash<Promise<Batch<Asset>>>;
//
//    public function new(resourceMap : ResourceMap) {
//        this.resourceMap = resourceMap;
//        promises = new Hash();
//        batchPromises = new Hash();
//    }

//    public function load(id:AssetId):Promise<Asset> {
//        var promise = promises.get(id);
//        if (promise != null){
//            return promise;
//        }
//
//        var resource = resourceMap.get(id);
//        if (resource == null){
//            Report.anError("AssetManager", "No Resource for ", id);
//            return null;
//        }
//
//        promise = new Promise();
//        promises.set(id, promise);
//
//        switch(resource.type){
//            case Text:
//                var text = nme.Assets.getText(resource.path);
//                promise.resolve(new TextAsset(resource.id, text));
//            case Bitmap:
//                var bitmapData = nme.Assets.getBitmapData(resource.path);
//                promise.resolve(new BitmapAsset(resource.id, bitmapData));
//        }
//
//        return promise;
//    }

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
