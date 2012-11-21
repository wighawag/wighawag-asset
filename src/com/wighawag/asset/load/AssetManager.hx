package com.wighawag.asset.load;
import nme.net.URLLoader;
import nme.display.Bitmap;
import nme.net.URLRequest;
import nme.display.Loader;
import nme.events.Event;
import nme.events.IOErrorEvent;
import com.wighawag.report.Report;
import promhx.Promise;

typedef AssetId = String;

class AssetManager {

    private var resourceMap : ResourceMap;

    private var promises : Hash<Promise<Asset>>;
    private var batchPromises : Hash<Promise<Batch<Asset>>>;

    public function new(resourceMap : ResourceMap) {
        this.resourceMap = resourceMap;
        promises = new Hash();
        batchPromises = new Hash();
    }

    public function load(id : AssetId) : Promise<Asset>{
        var promise = promises.get(id);
        if (promise != null){
            return promise;
        }

        var resource = resourceMap.get(id);
        if (resource == null){
            Report.anError("AssetManager", "No Resource for ", id);
            return null;
        }

        promise = new Promise();
        promises.set(id, promise);

        switch(resource.type){
            case Text: loadText(promise, resource);
            case Bitmap: loadBitmap(promise, resource);
        }

        return promise;
    }

    private function loadBitmap(promise : Promise<Asset>, resource : Resource) : Void{
        var loader = new Loader();

        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(event : Event):Void{
            var bitmap : Bitmap = cast(loader.content);
            promise.resolve(new BitmapAsset(resource.id, bitmap.bitmapData));
        });
        loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function(event :Event):Void{
            Report.anError("AssetManager", "Error loading " + resource.path);
        });

        loader.load(new URLRequest(resource.path));
    }

    private function loadText(promise : Promise<Asset>, resource : Resource) : Void{
        var urlLoader = new URLLoader();
        urlLoader.addEventListener(Event.COMPLETE, function(event : Event):Void{
            promise.resolve(new TextAsset(resource.id, urlLoader.data));
        });
        urlLoader.addEventListener(IOErrorEvent.IO_ERROR, function(event :Event):Void{
            Report.anError("AssetManager", "Error loading " + resource.path);
        });
        urlLoader.load(new URLRequest(resource.path));
    }

    public function loadBatch(ids : Array<AssetId>) : Promise<Batch<Asset>>{

        // TODO sort alphabetically
        var batchId = ids.join("");

        var batchPromise = batchPromises.get(batchId);
        if (batchPromise != null){
            return batchPromise;
        }

        batchPromise = new Promise();
        batchPromises.set(batchId, batchPromise);

        var assetPromises = new Array<Promise<Asset>>();
        for (id in ids){
            assetPromises.push(load(id));
        }

        Promise.when(assetPromises).then(function(assets : Array<Asset>): Void{
            batchPromise.resolve(new Batch<Asset>(assets));
        });


        return batchPromise;
    }


}
