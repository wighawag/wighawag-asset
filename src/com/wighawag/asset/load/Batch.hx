package com.wighawag.asset.load;
import com.wighawag.asset.load.AssetManager;
class Batch<T : Asset> implements AssetProvider<T> {

    private var dict : Hash<T>;

    public function new(items : Array<T>) {
        dict = new Hash();
        for (item in items){
            dict.set(item.id, item);
        }
    }

    public function get(assetId : AssetId) : T{
        return dict.get(assetId);
    }

    public function all() : Array<T>{
        var allT : Array<T> = new Array();
        for ( t in dict){
            allT.push(t);
        }
        return allT;
    }

}
