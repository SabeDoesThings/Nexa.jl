mutable struct Context
    renderer::Ptr{SDL_Renderer}

    function Context(renderer::Ptr{SDL_Renderer})
        return new(renderer)
    end
end

mutable struct Texture2D
    surface::Ptr{SDL_Surface}
    width::Int
    height::Int
end
Base.cconvert(::Type{Ptr{SDL_Surface}}, tex::Texture2D) = tex.surface
Base.unsafe_convert(::Type{Ptr{SDL_Surface}}, tex::Texture2D) = tex.surface