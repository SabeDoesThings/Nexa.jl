mutable struct Context
    renderer::Ptr{SDL_Renderer}
    scale_x::Float64
    scale_y::Float64

    function Context(renderer::Ptr{SDL_Renderer})
        return new(renderer, 1.0, 1.0)
    end
end

mutable struct Texture2D
    surface::Ptr{SDL_Surface}
    width::Int
    height::Int
end
Base.cconvert(::Type{Ptr{SDL_Surface}}, tex::Texture2D) = tex.surface
Base.unsafe_convert(::Type{Ptr{SDL_Surface}}, tex::Texture2D) = tex.surface