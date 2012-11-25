package com.wighawag.asset.renderer;
import com.wighawag.asset.spritesheet.SubTexture;
import nme.display.Graphics;
import nme.display.Tilesheet;
import nme.display.BitmapData;
import com.fermmtools.utils.ObjectHash;
class TilesheetDrawingContext {

    private var texturesMap : ObjectHash<BitmapData, Tilesheet>;
    private var tileIndexMap : ObjectHash<SubTexture, Int>;

    private var graphics : Graphics;

    private var tilesheetsToDraw : ObjectHash<Tilesheet, Array<Float>>;
    private var orderedTilesheets : Array<Tilesheet>;

    public function new(graphics : Graphics) {
        this.graphics = graphics;
    }

    public function setUploadedTextures(texturesMap : ObjectHash<BitmapData, Tilesheet>, tileIndexMap : ObjectHash<SubTexture, Int>):Void{
        this.texturesMap = texturesMap;
        this.tileIndexMap = tileIndexMap;
    }

    public function drawTexture(subTexture : SubTexture, x : Int, y : Int) : Void{
        var tilesheet = texturesMap.get(subTexture.bitmapData);
        var index = tileIndexMap.get(subTexture);

        var values : Array<Float>;
        if (tilesheetsToDraw.exists(tilesheet)){
          values = tilesheetsToDraw.get(tilesheet);
        }else{
            values = new Array();
            tilesheetsToDraw.set(tilesheet, values);
            orderedTilesheets.push(tilesheet);
        }
        values.push(x - subTexture.frameX);
        values.push(y - subTexture.frameY);
        values.push(index);
    }

    public function willRender() : Void{
        tilesheetsToDraw = new ObjectHash();
        orderedTilesheets = new Array();
    }

    public function didRender() : Void{
        graphics.clear();
        for (toDraw in orderedTilesheets){
            toDraw.drawTiles(graphics,tilesheetsToDraw.get(toDraw)); // TODO support flags
        }
    }

}

