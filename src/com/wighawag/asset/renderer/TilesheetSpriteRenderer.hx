package com.wighawag.asset.renderer;
import nme.display.BitmapData;
import nme.display.Graphics;
import com.wighawag.asset.load.Batch;
import com.wighawag.asset.spritesheet.Sprite;
import com.wighawag.asset.spritesheet.TextureAtlas;
import nme.geom.Point;
import nme.geom.Rectangle;
import com.wighawag.asset.spritesheet.SubTexture;
import neash.display.Tilesheet;
import com.fermmtools.utils.ObjectHash;
import com.wighawag.view.Renderer;
class TilesheetSpriteRenderer implements Renderer<SpriteDrawingContext>{

    private var context : SpriteDrawingContext;

    public function new(graphics : Graphics) {
        context = new SpriteDrawingContext(graphics);
    }

    public function uploadSprites(sprites : Batch<Sprite>): Void{
        var textureAtlases : Array<TextureAtlas> = new Array();
        var allSprites = sprites.all();
        for (sprite in allSprites){
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

        var texturesMap : ObjectHash<BitmapData, Tilesheet> = new ObjectHash();
        var texturesIndexMap : ObjectHash<BitmapData, Int> = new ObjectHash();
        var tileIndexMap : ObjectHash<SubTexture, Int> = new ObjectHash();
        for (texture in textureAtlases){
            var bitmapData = texture.bitmapData;
            var tilesheet : Tilesheet;
            if (!texturesMap.exists(bitmapData)){
                texturesIndexMap.set(bitmapData,0);
                tilesheet = new Tilesheet(bitmapData);
                texturesMap.set(bitmapData, tilesheet);
            }else{
                tilesheet = texturesMap.get(bitmapData);
            }

            for (subTexture in texture.textures){
                if (!tileIndexMap.exists(subTexture)){
                    var currentIndex = texturesIndexMap.get(bitmapData);
                    tileIndexMap.set(subTexture, currentIndex);
                    texturesIndexMap.set(bitmapData, currentIndex + 1);
                    tilesheet.addTileRect(new Rectangle(subTexture.x, subTexture.y, subTexture.width, subTexture.height), new Point(0,0));
                }
            }


        }

        context.setUploadedTextures(texturesMap, tileIndexMap);
        context.setUploadedSprites(sprites);

    }

    // TODO implement lock mechanism
    public function lock():SpriteDrawingContext {
        context.willRender();
        return context;
    }

    public function unlock():Void {
        context.didRender();
    }
}
