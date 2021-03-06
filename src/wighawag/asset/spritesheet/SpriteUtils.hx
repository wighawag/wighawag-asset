/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.asset.spritesheet;

import wighawag.asset.load.BitmapAsset;
import wighawag.asset.renderer.NMEDrawingContext;

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



	inline static public function getBitmapAssets(sprites : Array<Sprite>) : Array<BitmapAsset>{
		var bitmapAssets : Array<BitmapAsset> = new Array();
		var hash = new Map<String,Bool>();
		for (sprite in sprites){
			if (!hash.exists(sprite.bitmapAsset.id)){
				bitmapAssets.push(sprite.bitmapAsset);
				hash.set(sprite.bitmapAsset.id, true);
			}
		}
		return bitmapAssets;
	}


    inline static public function draw(sprite : Sprite, context : NMEDrawingContext, animationName : String, elapsedTime : Float, x : Int, y : Int) : Void{
        var frame = sprite.getFrame(animationName,elapsedTime);
        var texture = frame.texture;
        context.drawScaledTexture(
            texture.bitmapAsset,
            texture.x,
            texture.y,
            texture.width,
            texture.height,
            Std.int(x - (frame.x + texture.frameX) + (frame.flipX == -1 ? texture.width : 0)),
            Std.int(y - (frame.y + texture.frameY) + (frame.flipY == -1 ? texture.height : 0)),
            frame.flipX,
            frame.flipY
        );
    }

    inline static public function drawScaled(sprite : Sprite, context : NMEDrawingContext, animationName : String, elapsedTime : Float, x : Int, y : Int, width : Int, height : Int) : Void{
        var frame = sprite.getFrame(animationName, elapsedTime);
        var texture = frame.texture;

        var scaleX = width / texture.width;
        var scaleY = height / texture.height;

        context.drawScaledTexture(
            texture.bitmapAsset,
            texture.x,
            texture.y,
            texture.width,
            texture.height,
            Std.int(x - (frame.x + texture.frameX) * scaleX + (frame.flipX == -1 ? texture.width * scaleX : 0)),
            Std.int(y - (frame.y + texture.frameY) * scaleY + (frame.flipY == -1 ? texture.height * scaleY : 0)),
            scaleX * frame.flipX,
            scaleY * frame.flipY
        );
    }

    inline static public function fill(sprite : Sprite, context : NMEDrawingContext, animationName : String, elapsedTime : Float, x : Int, y : Int, width : Int, height : Int) : Void{
        var frame = sprite.getFrame(animationName,elapsedTime);
        var texture = frame.texture;

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
    }

    inline static public function fillHorizontally(sprite : Sprite, context : NMEDrawingContext, animationName : String, elapsedTime : Float, x : Int, y : Int, width : Int) : Void{
        // TODO
    }

    inline static public function fillVertically(sprite : Sprite, context : NMEDrawingContext, animationName : String, elapsedTime : Float, x : Int, y : Int, height : Int) : Void{
        // TODO
    }


}
