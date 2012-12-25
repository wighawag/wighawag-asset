package com.wighawag.asset.spritesheet;
import com.wighawag.asset.load.BitmapAsset;
import com.wighawag.asset.spritesheet.TextureAtlas;
import com.wighawag.asset.load.Asset;
import com.wighawag.asset.load.AssetManager;
class Sprite implements Asset {

    public var id : AssetId;

    // TODO  since Sprite should only reference one bitmapData, maybe we should remove bitmapData from frame/subtexture ?
    public var bitmapAsset(default, null) : BitmapAsset;

    private var animations : Hash<Animation>;

    // duplication of data (as it already in the frames) but ease of access
    public var textureAtlas(default, null) : TextureAtlas;

	// these are set for potential optimization
	private var uniqueAnimation : Animation;
	private var uniqueFrame : Frame;


    public function new(id : AssetId, textureAtlas : TextureAtlas, bitmapAsset : BitmapAsset, animations : Hash<Animation>) {
        this.id = id;
        this.textureAtlas = textureAtlas;
        this.bitmapAsset = bitmapAsset;
        this.animations = animations;
	    var counter = 0;
	    for (animation in animations){
		    uniqueAnimation = animation;
		    counter ++;
	    }
	    if(counter > 1){
		    uniqueAnimation = null;
	    }else if (uniqueAnimation.frames.length == 1){
			uniqueFrame = uniqueAnimation.frames[0];
	    }
    }

    inline public function get(animationId : String): Animation{
	    var animation;
	    if(uniqueAnimation != null){
		    animation = uniqueAnimation;
	    }else{
		    animation =  animations.get(animationId);
	    }
        return animation;
    }

	inline public function getFrame(animationId : String, elapsedTime : Float) : Frame{
		var frame : Frame;
		if(uniqueFrame != null){
			frame = uniqueFrame;
		}else{
			frame = get(animationId).get(elapsedTime);
		}
		return frame;
	}
}
