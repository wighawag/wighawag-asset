package com.wighawag.asset.load;
import haxe.io.Bytes;
import com.wighawag.asset.load.AssetManager;

class BytesAsset implements Asset {

	public var id(default,null) : AssetId;

	public var bytes(default,null) : Bytes;

	public function new(id : AssetId, bytes : Bytes) {
		this.id = id;
		this.bytes = bytes;
	}
}
