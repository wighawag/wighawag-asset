/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.asset.load;
import promhx.Promise;

typedef AssetId = String;

interface AssetManager {
    public function load(id : AssetId) : Promise<Asset>;
    public function loadBatch(ids : Array<AssetId>) : Promise<Batch<Asset>>;
}
