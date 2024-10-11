function init()
    SDL_GL_SetAttribute(SDL_GL_MULTISAMPLEBUFFERS, 16)
    SDL_GL_SetAttribute(SDL_GL_MULTISAMPLESAMPLES, 16)

    @assert SDL_Init(SDL_INIT_VIDEO) == 0 "error initializing SDL: $(unsafe_string(SDL_GetError()))"
    @assert IMG_Init(IMG_INIT_PNG) != 0 "error initializing IMG: $(unsafe_string(SDL_GetError()))"
end

function create_window(title::String, width::Int, height::Int)
    window = SDL_CreateWindow(title, SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, width, height, SDL_WINDOW_SHOWN)
    if window == C_NULL
        error("Window could not be created! ERROR: ", SDL_GetError())
    end

    return window
end

function create_renderer(window)
    renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC)
    if renderer == C_NULL
        error("Renderer could not be created! ERROR: ", SDL_GetError())
    end

    return renderer
end