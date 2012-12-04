package com.wighawag.asset.spritesheet;

import com.wighawag.asset.renderer.NMEDrawingContext;
enum SpriteDraw {
    NoScale;
    FillAll;
    FillVertically;
    FillHorizontally;
    Scale;
}

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



    inline static public function draw(sprite : Sprite, context : NMEDrawingContext, animationName : String, elapsedTime : Float, x : Int, y : Int, width : Int, height : Int, drawMode : SpriteDraw) : Void{
        var animation = sprite.get(animationName);
        var frame = animation.get(elapsedTime);
        var texture = frame.texture;

        switch(drawMode){
            case SpriteDraw.FillAll, SpriteDraw.FillVertically, SpriteDraw.FillHorizontally:
                // TODO switch betwwen vertical/horizontal or both filling
                var totalWidth = 0;
                var totalHeight = 0;
                var maxWidth = width;
                var maxHeight = height;
                while(totalHeight < maxHeight){
                    totalWidth = 0;
                    while(totalWidth < maxWidth){
                        context.drawTexture(
                            texture.bitmapAsset,
                            texture.x,
                            texture.y,
                            texture.width,
                            texture.height,
                            x + totalWidth - frame.x - texture.frameX,
                            y + totalHeight - frame.y - texture.frameY
                        );
                        totalWidth += texture.width;
                    }
                    totalHeight += texture.height   ;
                }
            case SpriteDraw.NoScale, SpriteDraw.Scale:

                var scaleX = 1.0;
                var scaleY = 1.0;
                if (drawMode == SpriteDraw.Scale){
                    scaleX = width / texture.width;
                    scaleY = height / texture.height;
                }

                context.drawScaledTexture(
                    texture.bitmapAsset,
                    texture.x,
                    texture.y,
                    texture.width,
                    texture.height,
                    Std.int(x - (frame.x + texture.frameX) * scaleX),
                    Std.int(y - (frame.y + texture.frameY) * scaleY),
                    scaleX,
                    scaleY
                );
        }
    }
}
