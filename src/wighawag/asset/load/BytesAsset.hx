/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.asset.load;
import haxe.io.Bytes;
import wighawag.asset.load.AssetManager;

class BytesAsset implements Asset {

	public var id(default,null) : AssetId;

	public var bytes(default,null) : Bytes;

	public function new(id : AssetId, bytes : Bytes) {
		this.id = id;
		this.bytes = bytes;
	}
}
