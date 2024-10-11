module Nexa

using SimpleDirectMediaLayer
using SimpleDirectMediaLayer.LibSDL2

include("colors.jl")
include("input.jl")
include("context.jl")
include("rendering.jl")
include("load.jl")
include("window.jl")
include("audio.jl")

function start(on_start::Function, update::Function, render::Function, title::String = "Nexa Project", width::Int = 800, height::Int = 800, resizable::Bool = false)
    init()
    window = create_window(title, width, height)
    renderer = create_renderer(window)

    if resizable == true
        SDL_SetWindowResizable(window, SDL_TRUE)
    end

    ctx = Context(renderer)

    on_start()

    running = true
    while running
        running = process_events()

        update()

        render(ctx)

        SDL_RenderPresent(ctx.renderer)

        SDL_Delay(16)
    end

    SDL_DestroyWindow(window)
    SDL_DestroyRenderer(ctx.renderer)
    Mix_HaltMusic()
    Mix_HaltChannel(Int32(-1))
    Mix_CloseAudio()
    TTF_Quit()
    Mix_Quit()
    SDL_Quit()
end

end # module Nexa