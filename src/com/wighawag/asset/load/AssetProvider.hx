package com.wighawag.asset.load;
import com.wighawag.asset.load.AssetManager;

interface AssetProvider<T : Asset> {
    function get(assetId : AssetId) : T;
    function all() : Array<T>;
}
