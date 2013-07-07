/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.asset.spritesheet;
import wighawag.asset.load.BitmapAsset;
class TextureAtlas {

    public var id : String;

    public var textures : Map<String,SubTexture>;

    //duplicate data as it should be present in the individual textures but allow an easy access
    public var bitmapAsset(default,null) : BitmapAsset;

    public function new(id : String, bitmapAsset : BitmapAsset, textures : Map<String,SubTexture>) {
        this.id = id;
        this.bitmapAsset = bitmapAsset;
        this.textures = textures;
    }

}
