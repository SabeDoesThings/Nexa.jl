include("../src/Nexa.jl")
using .Nexa

mutable struct Square
    tex::Nexa.Texture2D
    x::Int
    y::Int
end

square = Square(Nexa.load_texture("./testing/NexaIcon.png"), 100, 100)

my_font = Nexa.load_font("./testing/arial.ttf", 50)

function on_start()
    #Nexa.play_music_looped("./testing/music.wav")
end

function update()
    if Nexa.is_key_down("w")
        square.y -= 4
    end
    if Nexa.is_key_down("a")
        square.x -= 4
    end
    if Nexa.is_key_down("s")
        square.y += 4
    end
    if Nexa.is_key_down("d")
        square.x += 4
    end

    if Nexa.is_key_pressed("p")
        Nexa.play_audio("./testing/sfx.wav")
    end
end

function render(ctx::Nexa.Context)
    Nexa.clear_screen(ctx, Nexa.SKYBLUE)

    Nexa.render_rect_line(ctx, 300, 60, 64, 64, Nexa.RED)
    Nexa.render_rect_filled(ctx, 300, 400, 64, 64, Nexa.WHITE)

    Nexa.render_circle_line(ctx, 320, 240, 100, Nexa.GREEN)
    Nexa.render_circle_filled(ctx, 320, 600, 100, Nexa.YELLOW)
    
    Nexa.render_texture(ctx, square.tex, square.x, square.y)

    Nexa.render_text(ctx, my_font, "Hello Nexa!", Nexa.BLACK, 0, 0)
end

Nexa.start(on_start, update, render, "My Game", 1280, 720)