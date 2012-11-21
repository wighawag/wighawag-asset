package com.wighawag.asset.load;
import promhx.Promise;

typedef AssetId = String;

interface AssetManager {
    public function load(id : AssetId) : Promise<Asset>;
    public function loadBatch(ids : Array<AssetId>) : Promise<Batch<Asset>>;
}
