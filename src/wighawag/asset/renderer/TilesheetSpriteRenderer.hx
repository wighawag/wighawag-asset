/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.asset.renderer;
import flash.events.Event;
import flash.display.BitmapData;
import flash.display.Graphics;
import wighawag.asset.load.Batch;
import wighawag.asset.spritesheet.Sprite;
import wighawag.asset.spritesheet.TextureAtlas;
import flash.geom.Point;
import flash.geom.Rectangle;
import wighawag.asset.spritesheet.SubTexture;
import flash.display.Tilesheet;
import com.fermmtools.utils.ObjectHash;
class TilesheetSpriteRenderer implements Renderer<NMEDrawingContext, TextureAtlas>{

    private var context : TilesheetDrawingContext;

    public function new(container : flash.display.Sprite, antiAliasEnabled : Bool) {
        context = new TilesheetDrawingContext(container, antiAliasEnabled);

		// TODO should be specific to container ?
	    onResize(null);
	    flash.Lib.current.stage.addEventListener(Event.RESIZE, onResize);
    }

	private function onResize(event : Event) :Void{
		// TODO should be specific to  container ?
		context.resize(flash.Lib.current.stage.stageWidth, flash.Lib.current.stage.stageHeight);
	}

    public function uploadTextures(textures : Array<TextureAtlas>): Void{
        var texturesMap : Map<String,Tilesheet> = new Map();
        var numTiles : Map<String,Int> = new Map();
        var tileIndexMap : Map<String,Map<String,Int>> = new Map();
        for (texture in textures){
            var bitmapAsset = texture.bitmapAsset;
            var tilesheet : Tilesheet;
            var tiles : Map<String,Int>;
            if (!texturesMap.exists(bitmapAsset.id)){
                numTiles.set(bitmapAsset.id,0);
                tilesheet = new Tilesheet(bitmapAsset.bitmapData);
                texturesMap.set(bitmapAsset.id, tilesheet);
                tiles = new Map();
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
