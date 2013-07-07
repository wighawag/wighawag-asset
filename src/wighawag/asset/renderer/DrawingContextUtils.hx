/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.asset.renderer;
class DrawingContextUtils {
    public inline static function squareId(x:Int,y:Int,width:Int,height:Int)  : String{
        return ""+x+","+y+";"+width+"x"+height;
    }
}
