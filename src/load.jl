function load_texture(ctx::Nexa.Context, filepath::String)
    surface = SDL_LoadBMP(filepath)
    if surface == C_NULL
        error("Failed to load texture! ERROR: $(unsafe_string(SDL_GetError()))")
    end
    
    texture = SDL_CreateTextureFromSurface(ctx.renderer, surface)
    if texture == C_NULL
        error("Failed to create texture! ERROR: $(unsafe_string(SDL_GetError()))")
    end
    
    width = SDL_Surface.w[Ptr{Int32}(surface)]
    height = SDL_Surface.h[Ptr{Int32}(surface)]

    return Texture2D(surface, texture, width, height)
end

function load_font(font_path::String, font_size::Int)
    if TTF_Init() == -1
        error("Failed to initialize SDL_ttf: ", SDL_GetError)
    end

    font = TTF_OpenFont(font_path, font_size)
    
    if font == C_NULL
        error("Failed to load font: ", SDL_GetError())
    end

    return font
end