/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.asset.load;
import wighawag.asset.load.AssetManager;
class TextAsset implements Asset {

    public var id : AssetId;

    public var text : String;

    public function new(id : AssetId, data : String) {
        this.id = id;
        this.text = data;
    }
}
