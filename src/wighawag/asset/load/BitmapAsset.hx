/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.asset.load;
import wighawag.asset.load.AssetManager;
import flash.display.BitmapData;
class BitmapAsset implements Asset{

    public var id(default,null) : AssetId;

    public var bitmapData(default,null) : BitmapData;

    public function new(id : AssetId, bitmapData : BitmapData) {
        this.id = id;
        this.bitmapData = bitmapData;
    }
}
