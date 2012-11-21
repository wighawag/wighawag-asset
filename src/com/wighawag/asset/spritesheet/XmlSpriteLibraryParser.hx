package com.wighawag.asset.spritesheet;
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
        var parsedSprites : Hash<Sprite> = new Hash();

        promise.resolve(new SpriteLibrary(parsedSprites));
    }

}
