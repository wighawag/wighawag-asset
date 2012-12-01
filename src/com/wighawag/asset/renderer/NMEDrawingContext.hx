package com.wighawag.asset.renderer;

//TODO override the interface definition with a class one to avoid the slow access to interface (flash)
import com.wighawag.asset.load.BitmapAsset;

interface NMEDrawingContext {

    function drawTexture(bitmapAsset : BitmapAsset, srcX : Int, srcY : Int, srcWidth : Int, srcHeight : Int, x : Int, y : Int) : Void;
    function drawScaledTexture(bitmapAsset : BitmapAsset, srcX : Int, srcY : Int, srcWidth : Int, srcHeight : Int, x : Int, y : Int, scaleX : Float, scaleY : Float) : Void;

    function translate(xOffset : Int, yOffset : Int) : Void;
    //function scale(x : Float, y : Float) : Void;
    // TODO rotate,..

    function save() : Void;
    function restore() : Void;
}
