module Nexa

using SimpleDirectMediaLayer
using SimpleDirectMediaLayer.LibSDL2

include("load.jl")
include("colors.jl")
include("input.jl")
include("context.jl")
include("rendering.jl")
include("window.jl")
include("audio.jl")
include("animation.jl")

const global_window_ref = Ref{Ptr{SDL_Window}}(Ptr{SDL_Window}(0))

function start(
    on_run::Function, 
    update::Function, 
    render::Function, 
    title::String = "Nexa Project", 
    width::Int = 800, 
    height::Int = 800, 
    resizable::Bool = false
)
    init()
    global_window_ref[] = create_window(title, width, height)
    renderer = create_renderer(global_window_ref[])

    if resizable == true
        SDL_SetWindowResizable(global_window_ref[], SDL_TRUE)
    end

    ctx = Context(renderer)

    on_run()

    running = true
    last_time = SDL_GetTicks()

    while running
        running = process_events()

        current_time = SDL_GetTicks()
        dt = (current_time - last_time) / 1000.0
        last_time = current_time

        update(dt)

        render(ctx)

        SDL_RenderPresent(ctx.renderer)

        SDL_Delay(16)
    end

    SDL_DestroyWindow(global_window_ref[])
    SDL_DestroyRenderer(ctx.renderer)
    Mix_HaltMusic()
    Mix_HaltChannel(Int32(-1))
    Mix_CloseAudio()
    TTF_Quit()
    Mix_Quit()
    SDL_Quit()
end

function get_window_width()
    width = Ref{Cint}(0)
    height = Ref{Cint}(0)
    SDL_GetWindowSize(global_window_ref[], width, height)
    return width[]
end

function get_window_height()
    width = Ref{Cint}(0)
    height = Ref{Cint}(0)
    SDL_GetWindowSize(global_window_ref[], width, height)
    return height[]
end

end # module Nexa