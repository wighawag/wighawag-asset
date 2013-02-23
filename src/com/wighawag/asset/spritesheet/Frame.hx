package com.wighawag.asset.spritesheet;
import nme.display.BitmapData;
class Frame {

    public var texture : SubTexture;
    public var x : Int;
    public var y : Int;
    public var overrideMsDuration : Int; // seconds
    public var flipX : Float;
    public var flipY : Float;

    public function new(texture : SubTexture, frameX : Int, frameY : Int, ?overrideMsDuration : Int = 0, ?flipX : Float = 1, ?flipY : Float = 1) {
        this.texture = texture;
        this.x = frameX;
        this.y = frameY;
        this.overrideMsDuration = overrideMsDuration;
        this.flipX = flipX;
        this.flipY = flipY;
    }
}
