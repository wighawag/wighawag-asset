/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.asset.spritesheet;
class Animation {

    public var id : String;

    public var frames : Array<Frame>;
    public var defaultMsDuration : Int;  // seconds
    public var loopStartFrame : Int;

    private var totalMsDuration : Int;
    private var loopMsDuration : Int;
    private var averageMsDuration : Int;

    public function new(id : String, framesProvided : Array<Frame>, defaultMsDuration : Int, ?loopStartFrame = 0 ) {

        // TODO optimize ?

        this.id = id;
        this.defaultMsDuration = defaultMsDuration;
        this.loopStartFrame = loopStartFrame;

        var gcd : Int = 0;

        totalMsDuration = 0;
        this.frames = new Array<Frame>();
        for (frame in framesProvided){
            var frameMsDuration : Int = getFrameDuration(frame);

            if(gcd == 0){
                gcd = frameMsDuration;
            }
            else{
                gcd = computeGCD(gcd, frameMsDuration);
            }
            totalMsDuration += frameMsDuration;
        }

        for (frame in framesProvided){
            var frameMsDuration : Int = getFrameDuration(frame);
            var numFrames = Std.int(frameMsDuration / gcd);
            for (i in 0...numFrames){
                this.frames.push(frame);
            }
        }

        // Work as GCD calculated
        averageMsDuration = Std.int(totalMsDuration / this.frames.length);
        loopMsDuration = (this.frames.length - loopStartFrame) * averageMsDuration;
    }

    inline private function getFrameDuration(frame : Frame) : Int{
        if (frame.overrideMsDuration > 0){
            return frame.overrideMsDuration;
        }else{
            return this.defaultMsDuration;
        }
    }

    inline private function computeGCD(a : Int, b : Int) : Int{

        while (a != 0 && b != 0)
        {
            if (a > b){
                a = a % b;
            }else{
                b = b % a;
            }
        }

        if (a == 0){
            return b;
        }else{
            return a;
        }
    }

    inline public function get(timeElapsed : Float) : Frame{
	    var frameIndex : Int;
	    if(frames.length == 1){
	        frameIndex = 0;
        }else{
		    var msTimeElapsed = timeElapsed * 1000;
		    if (msTimeElapsed >= totalMsDuration){
			    if (loopStartFrame >= 0){
				    var time = (msTimeElapsed - totalMsDuration) % loopMsDuration;
				    frameIndex = Std.int(time / averageMsDuration);
			    }else{
				    frameIndex = frames.length - 1; // return last frame if not loop (loopStartFrame < 0)
			    }
		    }else{
			    frameIndex = Std.int(msTimeElapsed / averageMsDuration);
		    }
	    }
	    return frames[frameIndex];
    }
}
