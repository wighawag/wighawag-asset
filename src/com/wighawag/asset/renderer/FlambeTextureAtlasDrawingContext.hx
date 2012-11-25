package com.wighawag.asset.renderer;
import flambe.display.DrawingContext;
import nme.display.BitmapData;
import flambe.platform.flash.FlashTexture;
import com.fermmtools.utils.ObjectHash;
import com.wighawag.asset.load.Batch;
import com.wighawag.asset.spritesheet.TextureAtlas;
import com.wighawag.asset.spritesheet.SubTexture;

class FlambeTextureAtlasDrawingContext {

    private var flambeContext : DrawingContext;
    private var texturesMap : ObjectHash<BitmapData, FlashTexture>;

    public function new() {
    }

    public function setUploadedTextures(texturesMap : ObjectHash<BitmapData, FlashTexture>):Void{
        this.texturesMap = texturesMap;
    }

    public function setFlambeContext(flambeContext : DrawingContext): Void{
        this.flambeContext = flambeContext;
    }

    public function drawTexture(subTexture : SubTexture, x : Int, y : Int) : Void{
        var flashTexture = texturesMap.get(subTexture.bitmapData);
        flambeContext.drawSubImage(flashTexture, x - subTexture.frameX, y - subTexture.frameY, subTexture.x, subTexture.y, subTexture.width, subTexture.height);
    }

    public function willRender() : Void{

    }

    public function didRender() : Void{

    }
}
