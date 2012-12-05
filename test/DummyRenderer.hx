package ;
import com.wighawag.asset.spritesheet.TextureAtlas;
import com.wighawag.asset.renderer.NMEDrawingContext;
import com.wighawag.asset.renderer.Renderer;
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
