function init()
    SimpleDirectMediaLayer.init()
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