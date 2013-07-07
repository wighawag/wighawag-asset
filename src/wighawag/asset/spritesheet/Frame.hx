/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.asset.spritesheet;
import flash.display.BitmapData;
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
