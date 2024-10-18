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

function create_viewport(ctx::Nexa.Context, width::Int, height::Int)
    window_width = Nexa.get_window_width()
    window_height = Nexa.get_window_height()

    scale_x = window_width / width
    scale_y = window_height / height

    ctx.scale_x = scale_x
    ctx.scale_y = scale_y
end