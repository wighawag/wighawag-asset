/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.asset.spritesheet;
import wighawag.asset.load.BitmapAsset;
import flash.display.BitmapData;
class SubTexture {

    public var id : String;

    public var bitmapAsset : BitmapAsset;
    public var x : Int;
    public var y : Int;
    public var width : Int;
    public var height : Int;

    public var frameX : Int;
    public var frameY : Int;
    public var frameWidth : Int;
    public var frameHeight : Int;

    public function new(id : String, bitmapAsset : BitmapAsset, x : Int, y : Int, width : Int, height : Int, frameX : Int, frameY : Int, frameWidth : Int, frameHeight : Int) {

        this.id = id;
        this.bitmapAsset = bitmapAsset;

        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;

        this.frameX = frameX;
        this.frameY = frameY;
        this.frameWidth = frameWidth;
        this.frameHeight = frameHeight;
    }
}
