package com.wighawag.asset.spritesheet;

import com.wighawag.asset.load.Batch;
import com.wighawag.asset.load.Asset;
import com.wighawag.asset.load.TextAsset;
import com.wighawag.asset.load.BitmapAsset;
import com.wighawag.asset.load.AssetManager;
import com.wighawag.report.Report;
import promhx.Promise;
class TextureAtlasLibrary {


    private var assetManager : AssetManager;
    public var promises : Hash<Promise<TextureAtlas>>;


    public function new (assetManager : AssetManager) {
        this.assetManager = assetManager;
        promises = new Hash();
    }


    public function fetch(id : String) : Promise<TextureAtlas>{
        var promise = promises.get(id);
        if (promise == null){
            promise = new Promise();

            promises.set(id, promise);

            assetManager.loadBatch([id+".texture", id+".atlas"]).then(function(assets : Batch<Asset>): Void{
                var bitmapAsset : BitmapAsset = cast(assets.get(id+".texture"));
                var textAsset : TextAsset = cast(assets.get(id+".atlas"));
                var subTextures = new Hash<SubTexture>();
                var parser = new SparrowTextureAtlasParser(bitmapAsset.bitmapData, textAsset.text);
                var textureAtlas = parser.parse();
                promise.resolve(textureAtlas);

            });
        }

        return promise;
    }



}
