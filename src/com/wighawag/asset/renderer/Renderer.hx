package com.wighawag.asset.renderer;

interface Renderer<DrawingContextType, TextureType> {
    function lock() : DrawingContextType;
    function unlock() : Void;

    // TODO use ensureTexture ?
    function uploadTextures(textures : Array<TextureType>) : Void;
    function unloadTextures(textures : Array<TextureType>) : Void;
}
