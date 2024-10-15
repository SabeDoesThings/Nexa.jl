function load_texture(file_path::String)
    width_ref = 0
    height_ref = 0

    surface = IMG_Load(file_path)
    if surface == C_NULL
        error("Failed to load texture! ERROR: $(unsafe_string(SDL_GetError()))")
    end

    return Texture2D(surface, width_ref, height_ref)
end

function load_font(font_path::String, font_size::Int)
    # Initialize the TTF library
    if TTF_Init() == -1
        error("Failed to initialize SDL_ttf: ", SDL_GetError)
    end

    # Load the font
    font = TTF_OpenFont(font_path, font_size)
    
    if font == C_NULL
        error("Failed to load font: ", SDL_GetError())
    end

    return font
end