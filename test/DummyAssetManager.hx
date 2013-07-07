package ;

import promhx.Promise;
import wighawag.asset.load.Batch;
import wighawag.asset.load.Asset;
import wighawag.asset.load.AssetManager;

class DummyAssetManager implements AssetManager{

    public function new() {
    }

    public function load(id:AssetId):Promise<Asset> {
        var promise = new Promise<Asset>();
        return promise;
    }

    public function loadBatch(ids:Array<AssetId>):Promise<Batch<Asset>> {
        var promise = new Promise<Batch<Asset>>();
        return promise;
    }


}
