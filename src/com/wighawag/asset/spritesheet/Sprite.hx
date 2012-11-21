package com.wighawag.asset.spritesheet;
import com.wighawag.asset.spritesheet.TextureAtlas;
import nme.display.BitmapData;
import nme.display.BitmapData;
import com.wighawag.asset.load.Asset;
import com.wighawag.asset.load.AssetManager;
class Sprite implements Asset {

    public var id : AssetId;

    // TODO  since Sprite should only reference one bitmapData, maybe we should remove bitmapData from frame/subtexture ?
    public var bitmapData(default, null) : BitmapData;

    private var animations : Hash<Animation>;

    // duplication of data (as it already in the frames) but ease of access
    public var textureAtlas(default, null) : TextureAtlas;

    public function new(id : AssetId, textureAtlas : TextureAtlas, bitmapData : BitmapData, animations : Hash<Animation>) {
        this.id = id;
        this.textureAtlas = textureAtlas;
        this.bitmapData = bitmapData;
        this.animations = animations;
    }

    public function get(animationId : String): Animation{
        return animations.get(animationId);
    }
}
