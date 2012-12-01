package com.wighawag.asset.renderer;

import com.wighawag.view.flambe.FlambeStage3DRenderer;
import nme.display.BitmapData;
import com.wighawag.asset.spritesheet.TextureAtlas;
import com.wighawag.asset.load.Batch;
import com.wighawag.asset.spritesheet.Sprite;
import com.wighawag.view.Renderer;
import flambe.display.DrawingContext;
import flambe.platform.flash.FlashTexture;
class FlambeSpriteRenderer  implements Renderer<NMEDrawingContext>{

    private var context : FlambeTextureAtlasDrawingContext;
    private var flambeRenderer : Renderer<DrawingContext>;

    public function new(renderer : Renderer<DrawingContext>) {
        context = new FlambeTextureAtlasDrawingContext();
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

        var texturesMap : Hash<FlashTexture> = new Hash();
        for (texture in textureAtlases){
            var bitmapAsset = texture.bitmapAsset;
            if (!texturesMap.exists(bitmapAsset.id)){
                var flashTexture = new FlashTexture(bitmapAsset.bitmapData);

                texturesMap.set(bitmapAsset.id, flashTexture);
                if (Std.is(flambeRenderer, FlambeStage3DRenderer)){
                    var stage3DRenderer : FlambeStage3DRenderer = cast(flambeRenderer);
                    stage3DRenderer.uploadTexture(flashTexture);
                }
            }
        }

        context.setUploadedTextures(texturesMap);
    }

    private var flambeContext : DrawingContext;
    // TODO implement lock mechanism
    public function lock():NMEDrawingContext {
        flambeContext = flambeRenderer.lock();
        context.setFlambeContext(flambeContext);
        flambeContext.save();
        return context;
    }

    public function unlock():Void {
        flambeContext.restore();
        flambeContext = null;
        flambeRenderer.unlock();
    }

}
