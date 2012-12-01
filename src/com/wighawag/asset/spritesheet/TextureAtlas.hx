package com.wighawag.asset.spritesheet;
import com.wighawag.asset.load.BitmapAsset;
class TextureAtlas {

    public var id : String;

    public var textures : Hash<SubTexture>;

    //duplicate data as it should be present in the individual textures but allow an easy access
    public var bitmapAsset(default,null) : BitmapAsset;

    public function new(id : String, bitmapAsset : BitmapAsset, textures : Hash<SubTexture>) {
        this.id = id;
        this.bitmapAsset = bitmapAsset;
        this.textures = textures;
    }

}
