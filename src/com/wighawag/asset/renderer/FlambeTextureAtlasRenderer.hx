package com.wighawag.asset.renderer;
import flambe.display.DrawingContext;
import flambe.platform.flash.FlashTexture;
import nme.display.BitmapData;
import com.fermmtools.utils.ObjectHash;
import flambe.platform.flash.Stage3DRenderer;
import com.wighawag.asset.spritesheet.TextureAtlas;
import com.wighawag.view.Renderer;

class FlambeTextureAtlasRenderer implements Renderer<FlambeTextureAtlasDrawingContext>{

    private var context : FlambeTextureAtlasDrawingContext;
    private var flambeRenderer : Renderer<DrawingContext>;

    public function new(renderer : Renderer<DrawingContext>) {
        super();
        context = new FlambeTextureAtlasDrawingContext();
        flambeRenderer = renderer;
    }

    public function uploadTextures(textures : Array<TextureAtlas>): Void{
       var texturesMap : ObjectHash<BitmapData, FlashTexture> = new ObjectHash();
       for (texture in textures){
           var bitmapData = texture.bitmapData;
           if (!texturesMap.exists(bitmapData)){
               var flashTexture = new FlashTexture(bitmapData);
               uploadTexture(flashTexture);
               texturesMap.set(bitmapData, flashTexture);
           }
       }
       context.setUploadedTextures(texturesMap);
    }

    // TODO implement lock mechanism
    public function lock():FlambeTextureAtlasDrawingContext {
        var flambeContext = flambeRenderer.lock();
        context.setFlambeContext(flambeContext);
        return context;
    }

    public function unlock():Void {
        flambeRenderer.unlock();
    }


}
