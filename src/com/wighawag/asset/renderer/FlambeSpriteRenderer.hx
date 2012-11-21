package com.wighawag.asset.renderer;

import com.wighawag.view.flambe.FlambeStage3DRenderer;
import nme.display.BitmapData;
import com.fermmtools.utils.ObjectHash;
import com.wighawag.asset.spritesheet.TextureAtlas;
import com.wighawag.asset.load.Batch;
import com.wighawag.asset.spritesheet.Sprite;
import com.wighawag.view.Renderer;
import flambe.display.DrawingContext;
import flambe.platform.flash.FlashTexture;
class FlambeSpriteRenderer  implements Renderer<SpriteDrawingContext>{

    private var context : SpriteDrawingContext;
    private var flambeRenderer : Renderer<DrawingContext>;

    public function new(renderer : Renderer<DrawingContext>) {
        context = new SpriteDrawingContext();
        flambeRenderer = renderer;
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

        var texturesMap : ObjectHash<BitmapData, FlashTexture> = new ObjectHash();
        for (texture in textureAtlases){
            var bitmapData = texture.bitmapData;
            if (!texturesMap.exists(bitmapData)){
                var flashTexture = new FlashTexture(bitmapData);

                texturesMap.set(bitmapData, flashTexture);
                if (Std.is(flambeRenderer, FlambeStage3DRenderer)){
                    var stage3DRenderer : FlambeStage3DRenderer = cast(flambeRenderer);
                    stage3DRenderer.uploadTexture(flashTexture);
                }
            }
        }

        context.setUploadedTextures(texturesMap);
        context.setUploadedSprites(sprites);

    }

    // TODO implement lock mechanism
    public function lock():SpriteDrawingContext {
        var flambeContext = flambeRenderer.lock();
        context.setFlambeContext(flambeContext);
        return context;
    }

    public function unlock():Void {
        flambeRenderer.unlock();
    }

}
