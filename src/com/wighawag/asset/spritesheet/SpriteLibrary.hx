package com.wighawag.asset.spritesheet;
import com.wighawag.asset.load.TextAsset;
import com.wighawag.asset.load.Batch;
import com.wighawag.report.Report;
import haxe.xml.Fast;
import promhx.Promise;
class SpriteLibrary {

    private var textureAtlasLibrary : TextureAtlasLibrary;
    private var spriteDefinitions : Hash<Fast>;
    private var textureAtlasSpriteMap : Hash<Array<Promise<Sprite>>>;
    private var promises : Hash<Promise<Sprite>>;
    private var batchPromises : Hash<Promise<Batch<Sprite>>>;

    public function new (xml : String, textureAtlasLibrary : TextureAtlasLibrary) {
        textureAtlasSpriteMap = new Hash();
        promises = new Hash();
        batchPromises = new Hash();
        spriteDefinitions = new Hash();


        this.textureAtlasLibrary = textureAtlasLibrary;
        var x = new Fast( Xml.parse(xml).firstElement() );
        for (spriteDefinition in x.nodes.sprite){
            spriteDefinitions.set(spriteDefinition.att.id, spriteDefinition);
        }
    }


    public function fetch(id : String) : Promise<Sprite>{
        var promise = promises.get(id);
        if (promise == null){
            promise = new Promise();

            var spriteDefinition = spriteDefinitions.get(id);
            if (spriteDefinition == null){
                Report.anError("SpriteLibrary", "Sprite does not exist : ", id);
                return null;
            }

            promises.set(id, promise);
            var textureAtlasId = spriteDefinition.att.textureAtlas;
            var spriteList = textureAtlasSpriteMap.get(textureAtlasId);
            if (spriteList == null){
                spriteList = new Array<Promise<Sprite>>();
                textureAtlasSpriteMap.set(textureAtlasId, spriteList);
            }
            spriteList.push(promise);
            textureAtlasLibrary.fetch(textureAtlasId).then(function (textureAtlas : TextureAtlas) : Void{
                var spriteList = textureAtlasSpriteMap.get(textureAtlas.id);
                for (spritePromise in spriteList){
                    var subTexture : SubTexture = null;
                    var animations : Hash<Animation> = new Hash();
                    for (animationDef in spriteDefinition.nodes.animation){
                        var frames = new Array<Frame>();
                        for (frameDef in animationDef.nodes.frame){
                            var overrideDuration = 0;
                            if (frameDef.has.overrideDuration){
                                overrideDuration = Std.parseInt(frameDef.att.overrideDuration);
                            }
                            var frameX = 0;
                            if (frameDef.has.x){
                                frameX = Std.parseInt(frameDef.att.x);
                            }
                            var frameY = 0;
                            if (frameDef.has.y){
                                frameY = Std.parseInt(frameDef.att.y);
                            }
                            subTexture = textureAtlas.textures.get(frameDef.att.subTexture);
                            frames.push(new Frame(subTexture,frameX, frameY, overrideDuration));
                        }
                        var loopStartFrame = 0;
                        if (animationDef.has.loopStartFrame){
                            loopStartFrame = Std.parseInt(animationDef.att.loopStartFrame);
                        }
                        animations.set(animationDef.att.id, new Animation(animationDef.att.id, frames, Std.parseInt(animationDef.att.defaultDuration), loopStartFrame));
                    }

                    spritePromise.resolve(new Sprite(id, textureAtlas, subTexture.bitmapAsset, animations));
                }
                textureAtlasSpriteMap.remove(textureAtlas.id);
            });
        }

        return promise;
    }



    public function fetchBatch(ids : Array<String>) : Promise<Batch<Sprite>>{
        // TODO sort alphabetically
        var batchId = ids.join("");

        var batchPromise = batchPromises.get(batchId);
        if (batchPromise != null){
            return batchPromise;
        }

        batchPromise = new Promise();
        batchPromises.set(batchId, batchPromise);

        var spritePromises = new Array<Promise<Sprite>>();
        for (id in ids){
            spritePromises.push(fetch(id));
        }

        Promise.when(spritePromises).then(function(sprites : Array<Sprite>): Void{
            batchPromise.resolve(new Batch<Sprite>(sprites));
        });


        return batchPromise;
    }
}
