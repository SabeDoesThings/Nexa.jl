function load_texture(file_path::String)
    surface = IMG_Load(file_path)
    if surface == C_NULL
        error("Failed to load texture! ERROR: $(unsafe_string(SDL_GetError()))")
    end

    return Texture2D(surface)
end