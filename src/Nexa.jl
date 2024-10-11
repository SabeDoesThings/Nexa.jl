module Nexa

using SimpleDirectMediaLayer
using SimpleDirectMediaLayer.LibSDL2

struct Color
    r::Int
    g::Int
    b::Int
    a::Int
end

const LIGHTGRAY = Color(200, 200, 200, 255)
const GRAY = Color(130, 130, 130, 255)
const DARKGRAY = Color(80, 80, 80, 255)
const YELLOW = Color(253, 249, 0, 255)
const GOLD = Color(255, 203, 0, 255)
const ORANGE = Color(255, 161, 0, 255)
const PINK = Color(255, 109, 194, 255)
const RED = Color(230, 41, 55, 255)
const MAROON = Color(190, 33, 55, 255)
const GREEN = Color(0, 228, 48, 255)
const LIME = Color(0, 158, 47, 255)
const DARKGREEN = Color(0, 117, 44, 255)
const SKYBLUE = Color(102, 191, 255, 255)
const BLUE = Color(0, 121, 241, 255)
const DARKBLUE = Color(0, 82, 172, 255)
const PURPLE = Color(200, 122, 255, 255)
const VIOLET = Color(200, 122, 255, 255)
const DARKPURPLE = Color(112, 31, 126, 255)
const BEIGE = Color(211, 176, 131, 255)
const BROWN = Color(127, 106, 79, 255)
const DARKBROWN = Color(76, 63, 47, 255)
const WHITE = Color(255, 255, 255, 255)
const BLACK = Color(0, 0, 0, 255)
const BLANK = Color(0, 0, 0, 0)
const MEGENTA = Color(255, 0, 255, 255)

const key_map = Dict(
    "a" => SDL_SCANCODE_A,
    "b" => SDL_SCANCODE_B,
    "c" => SDL_SCANCODE_C,
    "d" => SDL_SCANCODE_D,
    "e" => SDL_SCANCODE_E,
    "f" => SDL_SCANCODE_F,
    "g" => SDL_SCANCODE_G,
    "h" => SDL_SCANCODE_H,
    "i" => SDL_SCANCODE_I,
    "j" => SDL_SCANCODE_J,
    "k" => SDL_SCANCODE_K,
    "l" => SDL_SCANCODE_L,
    "m" => SDL_SCANCODE_M,
    "n" => SDL_SCANCODE_N,
    "o" => SDL_SCANCODE_O,
    "p" => SDL_SCANCODE_P,
    "q" => SDL_SCANCODE_Q,
    "r" => SDL_SCANCODE_R,
    "s" => SDL_SCANCODE_S,
    "t" => SDL_SCANCODE_T,
    "u" => SDL_SCANCODE_U,
    "v" => SDL_SCANCODE_V,
    "w" => SDL_SCANCODE_W,
    "x" => SDL_SCANCODE_X,
    "y" => SDL_SCANCODE_Y,
    "z" => SDL_SCANCODE_Z,
    "space" => SDL_SCANCODE_SPACE,
    "escape" => SDL_SCANCODE_ESCAPE
)

struct Context
    renderer::Ptr{SDL_Renderer}
end

mutable struct Texture2D
    surface::Ptr{SDL_Surface}
end
Base.cconvert(::Type{Ptr{SDL_Surface}}, tex::Texture2D) = tex.surface
Base.unsafe_convert(::Type{Ptr{SDL_Surface}}, tex::Texture2D) = tex.surface

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

function load_texture(file_path::String)
    surface = IMG_Load(file_path)
    if surface == C_NULL
        error("Failed to load texture! ERROR: $(unsafe_string(SDL_GetError()))")
    end

    return Texture2D(surface)
end

function render_texture(ctx::Context, tex::Texture2D, tex_x::Int, tex_y::Int)
    tex = SDL_CreateTextureFromSurface(ctx.renderer, tex)

    width = Ref{Cint}(0)
    height = Ref{Cint}(0)

    if SDL_QueryTexture(tex, C_NULL, C_NULL, width, height) != 0
        error("Failed to render texture! ERROR: $(unsafe_string(SDL_GetError()))")
    end

    dst = SDL_Rect(tex_x, tex_y, width[], height[])

    SDL_RenderCopy(ctx.renderer, tex, C_NULL, Ref(dst))
end

function is_key_pressed(key::String)
    scancode = key_map[key]
    key_state = SDL_GetKeyboardState(C_NULL)
    return unsafe_load(key_state, scancode + 1) == 1
end

function process_events()
    event = Ref{SDL_Event}()
    SDL_PollEvent(event)
    if event[].type == SDL_QUIT
        return false
    end

    return true
end

function render_rect_filled(ctx::Nexa.Context, x::Int, y::Int, width::Int, height::Int, color::Color)
    SDL_SetRenderDrawColor(ctx.renderer, color.r, color.g, color.b, color.a)
    rect = SDL_Rect(x, y, width, height)
    SDL_RenderFillRect(ctx.renderer, Ref(rect))
end

function clear_screen(ctx::Nexa.Context, color::Color)
    SDL_SetRenderDrawColor(ctx.renderer, color.r, color.g, color.b, color.a)
    SDL_RenderClear(ctx.renderer)
end

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