module Nexa

using SimpleDirectMediaLayer
using SimpleDirectMediaLayer.LibSDL2

include("colors.jl")
include("input.jl")
include("context.jl")
include("rendering.jl")
include("texture.jl")
include("window.jl")

function start(update::Function, render::Function, title::String = "Nexa Project", width::Int = 800, height::Int = 800, resizable::Bool = false)
    init()
    window = create_window(title, width, height)
    renderer = create_renderer(window)

    if resizable == true
        SDL_SetWindowResizable(window, SDL_TRUE)
    end

    ctx = Context(renderer)

    dt = 1 / 60

    running = true
    while running
        running = process_events()

        update(dt)

        render(ctx)

        SDL_RenderPresent(ctx.renderer)

        SDL_Delay(16)
    end

    SDL_DestroyWindow(window)
    SDL_DestroyRenderer(ctx.renderer)
    SDL_Quit()
end

end # module Nexa