/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.asset.spritesheet;
import promhx.Promise;
class XmlSpriteLibraryParser {

    private var promise : Promise;
    private var xml : String;


    public function new(xml : String) {
        this.xml = xml;
    }

    public function parseAndLoad() : Promise<SpriteLibrary>{
        if (promise != null){
            return promise;
        }

        promise = new Promise();

        return promise;
    }

    private function onTextureAtlasesPreloaded() : Void{
        var parsedSprites : Map<String,Sprite> = new Map();

        promise.resolve(new SpriteLibrary(parsedSprites));
    }

}
