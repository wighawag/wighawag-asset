package com.wighawag.asset.renderer;

import com.wighawag.asset.load.BitmapAsset;
import flambe.display.DrawingContext;
import nme.display.BitmapData;
import flambe.platform.flash.FlashTexture;
import com.wighawag.asset.load.Batch;
import com.wighawag.asset.spritesheet.TextureAtlas;
import com.wighawag.asset.spritesheet.SubTexture;

class FlambeTextureAtlasDrawingContext implements NMEDrawingContext{

    private var flambeContext : DrawingContext;
    private var texturesMap : Hash<FlashTexture>;

    public function new() {
    }

    public function setUploadedTextures(texturesMap : Hash<FlashTexture>):Void{
        this.texturesMap = texturesMap;
    }

    public function setFlambeContext(flambeContext : DrawingContext): Void{
        this.flambeContext = flambeContext;
    }

    public function drawTexture(bitmapAsset:BitmapAsset, srcX:Int, srcY:Int, srcWidth:Int, srcHeight:Int, x:Int, y:Int):Void {
        drawScaledTexture(bitmapAsset,srcX, srcY, srcWidth, srcHeight, x, y, 1, 1);
    }

    public function drawScaledTexture(bitmapAsset:BitmapAsset, srcX:Int, srcY:Int, srcWidth:Int, srcHeight:Int, x:Int, y:Int, scaleX:Float, scaleY:Float):Void {
        var flashTexture = texturesMap.get(bitmapAsset.id);
        if(scaleX != 1 || scaleY != 1){
            flambeContext.save();
            flambeContext.translate(x,y);
            flambeContext.scale(scaleX, scaleY);
            flambeContext.drawSubImage(flashTexture, 0, 0, srcX, srcY, srcWidth, srcHeight);
            flambeContext.restore();
        }else{
            flambeContext.drawSubImage(flashTexture, x, y, srcX, srcY, srcWidth, srcHeight);
        }
    }

    public function translate(xOffset:Int, yOffset:Int):Void {
        flambeContext.translate(xOffset, yOffset);
    }

    public function save():Void {
        flambeContext.save();
    }

    public function restore():Void {
        flambeContext.restore();
    }

}
