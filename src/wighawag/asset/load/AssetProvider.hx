/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.asset.load;
import wighawag.asset.load.AssetManager;

interface AssetProvider<T : Asset> {
    function get(assetId : AssetId) : T;
    function all() : Array<T>; // TODO use Iterator
}
