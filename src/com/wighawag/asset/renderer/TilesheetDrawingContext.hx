package com.wighawag.asset.renderer;
import com.wighawag.asset.renderer.DrawingContextUtils;
import com.wighawag.asset.load.BitmapAsset;
import com.wighawag.asset.spritesheet.SubTexture;
import nme.display.Graphics;
import nme.display.Tilesheet;
import nme.display.BitmapData;
import com.fermmtools.utils.ObjectHash;

class TilesheetDrawingContext implements NMEDrawingContext{

    private var texturesMap : Hash<Tilesheet>;
    private var tileIndexMap : Hash<Hash<Int>>;

    private var graphics : Graphics;

    private var tilesheetsToDraw : ObjectHash<Tilesheet, Array<Float>>;
    private var orderedTilesheets : Array<Tilesheet>;


    // TODO use a stack based state
    private var translationX : Int;
    private var translationY : Int;

    public function new(graphics : Graphics) {
        this.graphics = graphics;
        texturesMap = new Hash();
        tileIndexMap = new Hash();
    }

    public function prepare()  : Void{
        tilesheetsToDraw = new ObjectHash();
        orderedTilesheets = new Array();
        translationX = 0;
        translationY = 0;
    }

    public function drawTexture(bitmapAsset:BitmapAsset, srcX:Int, srcY:Int, srcWidth:Int, srcHeight:Int, x:Int, y:Int):Void {
        drawScaledTexture(bitmapAsset,srcX, srcY, srcWidth, srcHeight, x, y, srcWidth, srcHeight);
    }



    public function drawScaledTexture(bitmapAsset:BitmapAsset, srcX:Int, srcY:Int, srcWidth:Int, srcHeight:Int, x:Int, y:Int, scaleX:Float, scaleY:Float):Void {

        var tilesheet = texturesMap.get(bitmapAsset.id);
        var tiles = tileIndexMap.get(bitmapAsset.id);
        var index : Int;
        var tileId = DrawingContextUtils.squareId(srcX,srcY,srcWidth,srcHeight);
        if (tiles.exists(tileId)){
            index = tiles.get(tileId);
            drawUsingTilesheet(tilesheet,index, x + translationX, y + translationY, scaleX, scaleY);
        }else{
            // TODO use drawTriangles
            Report.anError("TilesheetDrawingContext", "no index for " + bitmapAsset.id + " (" + tileId  + ")");
            drawUsingTriangles();
        }

    }

    private function drawUsingTilesheet(tilesheet : Tilesheet, tileIndex : Int, x : Int, y: Int, scaleX : Float, scaleY : Float):Void{

        var values : Array<Float>;
        if (tilesheetsToDraw.exists(tilesheet)){
            values = tilesheetsToDraw.get(tilesheet);
        }else{
            values = new Array();
            tilesheetsToDraw.set(tilesheet, values);
            orderedTilesheets.push(tilesheet);
        }

        values.push(x);
        values.push(y);
        values.push(tileIndex);

        // TODO deal with rotation
        values.push(scaleX);
        values.push(0);
        values.push(0);
        values.push(scaleY);
    }

    private function drawUsingTriangles() : Void{

    }

    public function translate(xOffset : Int, yOffset : Int) : Void {
        translationX += xOffset;
        translationY += yOffset;
    }

    public function render()  : Void {
        graphics.clear();
        for (toDraw in orderedTilesheets){
            toDraw.drawTiles(graphics,tilesheetsToDraw.get(toDraw),true, Graphics.TILE_TRANS_2x2); // TODO support the other flags
        }
    }

    public function save():Void {
    }

    public function restore():Void {
    }


    public function setUploadedTextures(texturesMap : Hash<Tilesheet>, tileIndexMap : Hash<Hash<Int>>):Void{
        this.texturesMap = texturesMap;
        this.tileIndexMap = tileIndexMap;
    }

}

