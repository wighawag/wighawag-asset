package com.wighawag.asset.renderer;
import nme.display.BitmapData;
import com.wighawag.asset.load.AssetProvider;
import com.fermmtools.utils.ObjectHash;
import com.wighawag.asset.load.Batch;
import com.wighawag.asset.spritesheet.Sprite;
import com.wighawag.asset.spritesheet.SubTexture;

class SpriteDrawingContext
    #if flash
        extends FlambeTextureAtlasDrawingContext{
    #elseif cpp
        extends TilesheetDrawingContext{
    #end

    private var sprites : AssetProvider<Sprite>;

    // TODO replace with a full stack based state
    private var currentTranslationX : Int;
    private var currentTranslationY : Int;
    //////////////////////////////////////////////

    #if cpp
    public function new(graphics : nme.display.Graphics) {
        super(graphics);
    }
    #else
    public function new() {
        super();
    }
    #end


    public function setUploadedSprites(sprites : AssetProvider<Sprite>) : Void{
        this.sprites = sprites;

    }

    public function drawSprite(name : String, animation : String, timeElapsed : Float, x : Int, y : Int): Void{

        var sprite = sprites.get(name);
        var animation = sprite.get(animation);
        var frame = animation.get(timeElapsed);
        var texture : SubTexture = frame.texture;

        drawTexture(texture, currentTranslationX + x - frame.x, currentTranslationY + y - frame.y);
    }

    public function fillSprite(name : String, animation : String, timeElapsed : Float, x : Int, y : Int, width : Int, height : Int) : Void{

        // TODO remove duplication betwwen drawSprite and fillSprite
        // TODO deal with non multiple width (especially problematic with tilesheet API
        var sprite = sprites.get(name);
        var animation = sprite.get(animation);
        var frame = animation.get(timeElapsed);
        var texture : SubTexture = frame.texture;

        var totalWidth = 0;
        var totalHeight = 0;
        var maxWidth = width;
        var maxHeight = height;
        while(totalHeight < maxHeight){
            totalWidth = 0;
            while(totalWidth < maxWidth){
                drawTexture(texture,currentTranslationX+ x + totalWidth - frame.x,currentTranslationY + y + totalHeight - frame.y);
                totalWidth += texture.width;
            }
            totalHeight += texture.height   ;
        }
    }

    public function translate(x : Int, y : Int) : Void{
        currentTranslationX +=x;
        currentTranslationY +=y;
    }

    override public function didRender() : Void{
        super.didRender();
        currentTranslationX = 0;
        currentTranslationY = 0;
    }


}