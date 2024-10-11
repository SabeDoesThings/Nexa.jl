struct Context
    renderer::Ptr{SDL_Renderer}
end

mutable struct Texture2D
    surface::Ptr{SDL_Surface}
end
Base.cconvert(::Type{Ptr{SDL_Surface}}, tex::Texture2D) = tex.surface
Base.unsafe_convert(::Type{Ptr{SDL_Surface}}, tex::Texture2D) = tex.surface