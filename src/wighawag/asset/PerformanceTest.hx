/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.asset;

import haxe.Timer;
import flash.events.Event;
import flash.geom.Rectangle;
import wighawag.asset.spritesheet.SubTexture;
import flash.display.BitmapData;
import wighawag.asset.load.BitmapAsset;
import wighawag.asset.spritesheet.TextureAtlas;
import wighawag.asset.renderer.NMEDrawingContext;
import wighawag.asset.renderer.Renderer;

class PerformanceTest {

	private var renderer : Renderer<NMEDrawingContext, TextureAtlas>;
	private var bitmapAsset : BitmapAsset;

	public static function main():Void{
	    trace("main starting");
		new PerformanceTest();
	}

	public function new(){
		#if cpp
            renderer = new wighawag.asset.renderer.TilesheetSpriteRenderer(flash.Lib.current.graphics);
            ready();
        #end

	}

	private function onEnterFrame(event : Event) : Void{
		var start = Timer.stamp();
		var context = renderer.lock();
		for(i in 0...416){
			context.drawTexture(bitmapAsset, 0, 0, bitmapAsset.bitmapData.width, bitmapAsset.bitmapData.height, 0, 0);
		}
		renderer.unlock();
		var end = Timer.stamp();
		trace("time taken : " + (end -start));
	}

	private function ready() : Void{

		bitmapAsset = new BitmapAsset("testBitmapAsset", new BitmapData(10,10));
		var textures = new Map<String,SubTexture>();
		bitmapAsset.bitmapData.fillRect(new Rectangle(0,0,bitmapAsset.bitmapData.width, bitmapAsset.bitmapData.height), 0x56ff00);
		var subTexture = new SubTexture("subTextureTest", bitmapAsset, 0 , 0, bitmapAsset.bitmapData.width, bitmapAsset.bitmapData.height, 0, 0, 0, 0);
		textures.set(subTexture.id, subTexture);
		var textureAtlas = new TextureAtlas("textureAtlasTest", bitmapAsset, textures);
		renderer.uploadTextures([textureAtlas]);

		flash.Lib.current.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}

}
