package com.wighawag.asset.spritesheet;
class SpriteUtils {
    inline static public function getTextureAtlases(sprites : Array<Sprite>) : Array<TextureAtlas>{
        var textureAtlases : Array<TextureAtlas> = new Array();
        for (sprite in sprites){
            var found = false;
            for (textureAtlas in textureAtlases){
                if (textureAtlas == sprite.textureAtlas){
                    found = true;
                    break;
                }
            }
            if (!found){
                textureAtlases.push(sprite.textureAtlas);
            }
        }
        return textureAtlases;
    }
}
