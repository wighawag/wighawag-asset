package com.wighawag.asset.spritesheet;
import nme.display.BitmapData;
class TextureAtlas {

    public var id : String;

    public var textures : Hash<SubTexture>;

    //duplicate data as it should be present in the individual textures but allow an easy access
    public var bitmapData(default,null) : BitmapData;

    public function new(id : String, bitmapData : BitmapData, textures : Hash<SubTexture>) {
        this.id = id;
        this.bitmapData = bitmapData;
        this.textures = textures;
    }

}
