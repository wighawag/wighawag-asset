/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.asset.renderer;

//TODO override the interface definition with a class one to avoid the slow access to interface (flash)
import wighawag.asset.load.BitmapAsset;

interface NMEDrawingContext {

	// TODO use matrix here or State
	var xTranslation(default, null) : Float;
	var yTranslation(default, null) : Float;
    var scaleX(default, null) : Float;
    var scaleY(default, null) : Float;

	var width(default,null) : Int;
	var height(default,null) : Int;

    function drawTexture(bitmapAsset : BitmapAsset, srcX : Int, srcY : Int, srcWidth : Int, srcHeight : Int, x : Int, y : Int) : Void;
    function drawScaledTexture(bitmapAsset : BitmapAsset, srcX : Int, srcY : Int, srcWidth : Int, srcHeight : Int, x : Int, y : Int, scaleX : Float, scaleY : Float) : Void;

    function translate(xOffset : Float, yOffset : Float) : Void;
    function scale(x : Float, y : Float) : Void;
    // TODO rotate,..

    function save() : Void;
    function restore() : Void;
}
