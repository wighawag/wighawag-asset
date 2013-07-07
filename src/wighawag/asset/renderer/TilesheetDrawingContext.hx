/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.asset.renderer;
import wighawag.asset.renderer.DrawingContextUtils;
import wighawag.asset.load.BitmapAsset;
import wighawag.asset.spritesheet.SubTexture;
import flash.display.Graphics;
import flash.display.Tilesheet;
import flash.display.BitmapData;
import com.fermmtools.utils.ObjectHash;

class TilesheetDrawingContext implements NMEDrawingContext{

    private var texturesMap : Map<String,Tilesheet>;
    private var tileIndexMap : Map<String,Map<String,Int>>;

    private var container : flash.display.Sprite;

    private var tilesheetsToDraw : ObjectMap<String,Tilesheet, Array<Float>>;
    private var orderedTilesheets : Array<Tilesheet>;


	// TODO use matrix here or State
	public var xTranslation(default, null) : Float;
	public var yTranslation(default, null) : Float;
    public var scaleX(default, null) : Float;
    public var scaleY(default, null) : Float;

	public var width(default,null) : Int;
	public var height(default,null) : Int;

    private var antiAliasEnabled : Bool;

    public function new(container : flash.display.Sprite, antiAliasEnabled : Bool) {
        this.antiAliasEnabled = antiAliasEnabled;
        this.container = container;
        texturesMap = new Map();
        tileIndexMap = new Map();
    }

	// TODO improve this relation with the renderer ()
	public function resize(width : Int, height : Int) : Void{
		this.width = width;
		this.height = height;
	}

    public function prepare()  : Void{
        tilesheetsToDraw = new ObjectMap();
        orderedTilesheets = new Array();
        xTranslation = 0;
        yTranslation = 0;
        scaleX = 1;
        scaleY = 1;
    }

    inline public function drawTexture(bitmapAsset:BitmapAsset, srcX:Int, srcY:Int, srcWidth:Int, srcHeight:Int, x:Int, y:Int):Void {
        drawScaledTexture(bitmapAsset,srcX, srcY, srcWidth, srcHeight, x, y, 1, 1);
    }



    inline public function drawScaledTexture(bitmapAsset:BitmapAsset, srcX:Int, srcY:Int, srcWidth:Int, srcHeight:Int, x:Int, y:Int, scaleX:Float, scaleY:Float):Void {

        var tilesheet = texturesMap.get(bitmapAsset.id);
        var tiles = tileIndexMap.get(bitmapAsset.id);
        var index : Int;
        var tileId = DrawingContextUtils.squareId(srcX,srcY,srcWidth,srcHeight);
        if (tiles.exists(tileId)){
            index = tiles.get(tileId);
            drawUsingTilesheet(tilesheet,index, x, y, scaleX, scaleY);
        }else{
            // TODO use drawTriangles
            Report.anError("TilesheetDrawingContext", "no index for " + bitmapAsset.id + " (" + tileId  + ")");
            drawUsingTriangles();
        }

    }

    inline private function drawUsingTilesheet(tilesheet : Tilesheet, tileIndex : Int, x : Int, y: Int, scaleX : Float, scaleY : Float):Void{

        var values : Array<Float>;
        if (tilesheetsToDraw.exists(tilesheet)){
            values = tilesheetsToDraw.get(tilesheet);
        }else{
            values = new Array();
            tilesheetsToDraw.set(tilesheet, values);
            orderedTilesheets.push(tilesheet);
        }

        setValues(values, x, y, tileIndex, scaleX, scaleY);
    }

    inline private function setValues(values : Array<Float>, x : Float, y : Float, tileIndex : Int, scaleX : Float, scaleY : Float) : Void{
        values.push(x);
        values.push(y );
        values.push(tileIndex);

        // TODO deal with rotation
        values.push(scaleX);
        values.push(0);
        values.push(0);
        values.push(scaleY);
    }

    private function drawUsingTriangles() : Void{
	    // TODO
    }

    public function translate(xOffset : Float, yOffset : Float) : Void {
        xTranslation += xOffset * scaleX;
        yTranslation += yOffset * scaleY;
    }

    public function scale(scaleX : Float, scaleY : Float) : Void {
        this.scaleX *= scaleX;
        this.scaleY *= scaleY;
    }

    public function render()  : Void {
        container.x = xTranslation;
        container.y = yTranslation;
        container.scaleX = this.scaleX;
        container.scaleY = this.scaleY;
        container.graphics.clear();
        for (toDraw in orderedTilesheets){
            toDraw.drawTiles(container.graphics,tilesheetsToDraw.get(toDraw),antiAliasEnabled, Tilesheet.TILE_TRANS_2x2); // TODO support the other flags
        }
    }

    // TODO remove this
    public function registerBatch(bitmapAsset : BitmapAsset, array : Array<Float>) : Array<Float>{
        var transformedArray : Array<Float> = new Array();
        var numValues = 8;
        var tilesheet = texturesMap.get(bitmapAsset.id);
        for (i in 0...Std.int(array.length / numValues)){
            var tiles = tileIndexMap.get(bitmapAsset.id);
            var index : Int;
            var tileId = DrawingContextUtils.squareId(Std.int(array[i * numValues]), Std.int(array[i * numValues + 1]), Std.int(array[i * numValues + 2]), Std.int(array[i * numValues + 3]));
            if (tiles.exists(tileId)){
                index = tiles.get(tileId);
                setValues(transformedArray, array[i * numValues + 4], array[i * numValues + 5], index, array[i * numValues + 6], array[i * numValues + 7]);
            }else{
                Report.anError("TilesheetDrawingContext", "no index for " + bitmapAsset.id + " (" + tileId  + ")");
            }
        }
        return transformedArray;
    }

    // TODO remove this
    public function renderBatch(bitmapAsset : BitmapAsset, array : Array<Float>) : Void{
        var tilesheet = texturesMap.get(bitmapAsset.id);
        orderedTilesheets.push(tilesheet);
        tilesheetsToDraw.set(tilesheet,array);
    }

    // TODO save
    public function save():Void {
    }

    // TODO restore
    public function restore():Void {
    }


    public function setUploadedTextures(texturesMap : Map<String,Tilesheet>, tileIndexMap : Map<String,Map<String,Int>>):Void{
        this.texturesMap = texturesMap;
        this.tileIndexMap = tileIndexMap;
    }

}

