using Nexa

mutable struct Square
    tex::Nexa.Texture2D
    x::Int
    y::Int
end

square = Square(Nexa.load_texture("./testing/NexaIcon.png"), 1280 / 2, 720 / 2)

my_font = Nexa.load_font("./testing/arial.ttf", 50)

function on_run()
    #Nexa.play_music_looped("./testing/music.wav")

    println("Window Size: ", Nexa.get_window_width(), ", ", Nexa.get_window_height())
    println(square.x, square.y)
end

anim_tex = Nexa.load_texture("./testing/character_spritesheet.png")
anim = Nexa.Animation(anim_tex, 48, 48, 6, 0.1, 11, 15)

function update(dt::Float64)
    if Nexa.is_key_down("w")
        square.y -= round(400 * dt)
    end
    if Nexa.is_key_down("a")
        square.x -= round(400 * dt)
    end
    if Nexa.is_key_down("s")
        square.y += round(400 * dt)
    end
    if Nexa.is_key_down("d")
        square.x += round(400 * dt)
    end

    if Nexa.is_key_pressed("p")
        Nexa.play_audio("./testing/sfx.wav")
        println("played sound")
    end

    if Nexa.is_mouse_button_pressed("left")
        println("left mouse button pressed")
    end
    if Nexa.is_mouse_button_down("right")
        println("right mouse button down")
    end

    Nexa.update_animation!(anim, dt, true)

    x, y = Nexa.get_mouse_position()
    println("x: $x", ", ", "y: $y")
end

function render(ctx::Nexa.Context)
    Nexa.clear_screen(ctx, Nexa.SKYBLUE)

    Nexa.render_texture(ctx, square.tex, square.x, square.y)

    Nexa.render_animation(ctx, anim, 100, 100, 5.0, 3.0)

    Nexa.render_rect_line(ctx, 300, 60, 64, 64, Nexa.RED)
    Nexa.render_rect_filled(ctx, 300, 400, 64, 64, Nexa.WHITE)

    Nexa.render_circle_line(ctx, 320, 240, 100, Nexa.GREEN)
    Nexa.render_circle_filled(ctx, 320, 600, 100, Nexa.YELLOW)

    Nexa.render_text(ctx, my_font, "Hello Nexa!", Nexa.BLACK, 0, 0, 2.0, 6.0)
end

Nexa.start(on_run, update, render, "My Game", 1280, 720, false)
