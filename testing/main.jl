include("../src/Nexa.jl")
using .Nexa

mutable struct Square
    tex::Nexa.Texture2D
    x::Int
    y::Int
end

square = Square(Nexa.load_texture("./test/NexaIcon.png"), 100, 100)

function update(dt::Float64)
    if Nexa.is_key_pressed("w")
        square.y -= 4
    end
    if Nexa.is_key_pressed("a")
        square.x -= 4
    end
    if Nexa.is_key_pressed("s")
        square.y += 4
    end
    if Nexa.is_key_pressed("d")
        square.x += 4
    end
end

function render(ctx::Nexa.Context)
    Nexa.clear_screen(ctx, Nexa.SKYBLUE)
    
    Nexa.render_texture(ctx, square.tex, square.x, square.y)
end

Nexa.start(update, render, "My Game", 1280, 720)