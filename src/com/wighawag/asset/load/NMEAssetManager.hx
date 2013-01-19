package com.wighawag.asset.load;
import nme.net.URLLoaderDataFormat;
import haxe.io.BytesData;
import haxe.io.Bytes;
import com.wighawag.asset.load.AssetManager;
import nme.net.URLLoader;
import nme.display.Bitmap;
import nme.net.URLRequest;
import nme.display.Loader;
import nme.events.Event;
import nme.events.IOErrorEvent;
import com.wighawag.report.Report;
import promhx.Promise;

class NMEAssetManager implements AssetManager{


    // TODO support binary resourceMap
    public static function bootstrap(url : String) : Promise<ResourceMap>{
        var promise = new Promise<ResourceMap>(); // do not save it
        var textPromise = new Promise<Asset>();
        textPromise.then(function(asset:Asset):Void{
            var textAsset : TextAsset = cast(asset);
            promise.resolve(new ResourceMap(textAsset.text));
        });
        loadText(textPromise,new Resource("resourceMap", url, Text, 0));
        return promise;
    }

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
	        case Bytes: loadBytes(promise, resource);
        }

        return promise;
    }

    private static function loadBitmap(promise : Promise<Asset>, resource : Resource) : Void{
	    if(resource.path.indexOf("://") == -1){
		    var bitmapData = nme.Assets.getBitmapData(resource.path);
		    if(bitmapData != null){
			    promise.resolve(new BitmapAsset(resource.id, bitmapData));
			    return;
		    }
	    }

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


	private static function loadBytes(promise : Promise<Asset>, resource : Resource) : Void{
		if(resource.path.indexOf("://") == -1){
			var byteArray = nme.Assets.getBytes(resource.path);
			if(byteArray != null){
				promise.resolve(new BytesAsset(resource.id,
					#if flash
					haxe.io.Bytes.ofData(byteArray)
					#else
					byteArray
					#end
				));
				return;
			}
		}

		var urlLoader = new URLLoader();
		urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
		urlLoader.addEventListener(Event.COMPLETE, function(event : Event):Void{
			promise.resolve(new BytesAsset(resource.id, Bytes.ofData(urlLoader.data)));
		});
		urlLoader.addEventListener(IOErrorEvent.IO_ERROR, function(event :Event):Void{
			Report.anError("AssetManager", "Error loading " + resource.path);
		});
		urlLoader.load(new URLRequest(resource.path));
	}

    private static function loadText(promise : Promise<Asset>, resource : Resource) : Void{
	    if(resource.path.indexOf("://") == -1){
		    var text = nme.Assets.getText(resource.path);
		    if(text!=null){
			    promise.resolve(new TextAsset(resource.id, text));
			    return;
		    }
		}

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
