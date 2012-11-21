package com.wighawag.asset.spritesheet;
import nme.display.BitmapData;
import nme.display.BitmapData;
class SparrowTextureAtlasParser {

    private var xml : String;
    private var bitmapData : BitmapData;

    public function new(bitmapData : BitmapData, xml : String) {
        this.xml = xml;
        this.bitmapData = bitmapData;
    }

    public function parse() : TextureAtlas{

        var x = new haxe.xml.Fast( Xml.parse(xml).firstElement() );

        var textures : Hash<SubTexture> = new Hash();

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

            textures.set(name, new SubTexture(name, bitmapData,x,y,width,height, frameX, frameY, frameWidth, frameHeight));
        }


        return new TextureAtlas(x.att.id, bitmapData, textures);
    }
}
