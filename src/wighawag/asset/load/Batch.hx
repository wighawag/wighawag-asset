/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.asset.load;
import wighawag.asset.load.AssetManager;
class Batch<T : Asset> implements AssetProvider<T> {

    private var dict : Map<String,T>;

    public function new(items : Array<T>) {
        dict = new Map();
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
