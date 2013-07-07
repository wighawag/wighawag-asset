/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.asset.spritesheet;

import wighawag.asset.load.AssetManager;
import wighawag.asset.load.Batch;
import wighawag.asset.load.Asset;
import wighawag.asset.load.TextAsset;
import wighawag.asset.load.BitmapAsset;
import wighawag.report.Report;
import promhx.Promise;
class TextureAtlasLibrary {


    private var assetManager : AssetManager;
    public var promises : Map<String,Promise<TextureAtlas>>;


    public function new (assetManager : AssetManager) {
        this.assetManager = assetManager;
        promises = new Map();
    }


    public function fetch(id : String) : Promise<TextureAtlas>{
        var promise = promises.get(id);
        if (promise == null){
            promise = new Promise();

            promises.set(id, promise);

            assetManager.loadBatch([id+".texture", id+".atlas"]).then(function(assets : Batch<Asset>): Void{
                var bitmapAsset : BitmapAsset = cast(assets.get(id+".texture"));
                var textAsset : TextAsset = cast(assets.get(id+".atlas"));
                var subTextures = new Map<String,SubTexture>();
                var parser = new SparrowTextureAtlasParser(bitmapAsset, textAsset.text);
                var textureAtlas = parser.parse();
                promise.resolve(textureAtlas);

            });
        }

        return promise;
    }



}
