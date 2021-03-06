/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.asset.spritesheet;
import wighawag.asset.load.BitmapAsset;
class SparrowTextureAtlasParser {

    private var xml : String;
    private var bitmapAsset : BitmapAsset;

    public function new(bitmapAsset : BitmapAsset, xml : String) {
        this.xml = xml;
        this.bitmapAsset = bitmapAsset;
    }

    public function parse() : TextureAtlas{

        var x = new haxe.xml.Fast( Xml.parse(xml).firstElement() );

        var textures : Map<String,SubTexture> = new Map();

        for (texture in x.nodes.SubTexture){

            var name = texture.att.name;

            var x = Std.parseInt(texture.att.x);
            var y =Std.parseInt(texture.att.y);
            var width = Std.parseInt(texture.att.width);
            var height = Std.parseInt(texture.att.height);

            var frameX = 0;
            var frameY = 0;
            var frameWidth = width;
            var frameHeight = height;

            if (texture.has.frameX){ // trimmed
                frameX = Std.parseInt(texture.att.frameX);
                frameY = Std.parseInt(texture.att.frameY);
                frameWidth = Std.parseInt(texture.att.frameWidth);
                frameHeight = Std.parseInt(texture.att.frameHeight);
            }

            textures.set(name, new SubTexture(name, bitmapAsset,x,y,width,height, frameX, frameY, frameWidth, frameHeight));
        }


        return new TextureAtlas(x.att.id, bitmapAsset, textures);
    }
}
