/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.asset.renderer;

interface Renderer<DrawingContextType, TextureType> {
    function lock() : DrawingContextType;
    function unlock() : Void;

    // TODO use ensureTexture ?
    function uploadTextures(textures : Array<TextureType>) : Void;
    function unloadTextures(textures : Array<TextureType>) : Void;
}
