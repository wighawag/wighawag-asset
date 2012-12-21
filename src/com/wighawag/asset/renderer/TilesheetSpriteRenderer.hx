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
class TilesheetSpriteRenderer implements Renderer<NMEDrawingContext, TextureAtlas>{

    private var context : TilesheetDrawingContext;

    public function new(graphics : Graphics) {
        context = new TilesheetDrawingContext(graphics);
    }

    public function uploadTextures(textures : Array<TextureAtlas>): Void{
        var texturesMap : Hash<Tilesheet> = new Hash();
        var numTiles : Hash<Int> = new Hash();
        var tileIndexMap : Hash<Hash<Int>> = new Hash();
        for (texture in textures){
            var bitmapAsset = texture.bitmapAsset;
            var tilesheet : Tilesheet;
            var tiles : Hash<Int>;
            if (!texturesMap.exists(bitmapAsset.id)){
                numTiles.set(bitmapAsset.id,0);
                tilesheet = new Tilesheet(bitmapAsset.bitmapData);
                texturesMap.set(bitmapAsset.id, tilesheet);
                tiles = new Hash();
                tileIndexMap.set(bitmapAsset.id, tiles);
            }else{
                tilesheet = texturesMap.get(bitmapAsset.id);
                tiles = tileIndexMap.get(bitmapAsset.id);
            }

            for (subTexture in texture.textures){

                var subTextureId = DrawingContextUtils.squareId(subTexture.x, subTexture.y, subTexture.width, subTexture.height);
                if (!tiles.exists(subTextureId)){
                    var currentIndex = numTiles.get(bitmapAsset.id);
                    tiles.set(subTextureId, currentIndex);
                    numTiles.set(bitmapAsset.id, currentIndex + 1);
                    tilesheet.addTileRect(new Rectangle(subTexture.x, subTexture.y, subTexture.width, subTexture.height), new Point(0,0));
                }
            }


        }

        context.setUploadedTextures(texturesMap, tileIndexMap);
    }

    public function unloadTextures(textures : Array<TextureAtlas>) : Void{
        //TODO
    }

    // TODO implement lock mechanism
    public function lock():NMEDrawingContext {
        context.prepare();
        return context;
    }

    public function unlock():Void {
        context.render();
    }
}
