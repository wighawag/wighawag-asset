package ;
import wighawag.asset.spritesheet.TextureAtlas;
import wighawag.asset.renderer.NMEDrawingContext;
import wighawag.asset.renderer.Renderer;
class DummyRenderer implements Renderer<NMEDrawingContext, TextureAtlas>{
    public function new() {
    }

    public function lock():NMEDrawingContext {
        return null;
    }

    public function unlock():Void {
    }

    public function uploadTextures(textures:Array<TextureAtlas>):Void {
    }

    public function unloadTextures(textures:Array<TextureAtlas>):Void {
    }


}
