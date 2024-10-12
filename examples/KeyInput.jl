using Nexa

mutable struct Player
    x::Int
    y::Int
    w::Int
    h::Int
end

player = Player(30, 30, 64, 64)

function on_run()
end

function update(dt::Float64)
    if Nexa.is_key_down("w") # Checks if the 'w' key is held down
        player.y -= round(400 * dt)
        # Here we are multiplying by dt. We need to do this in order to keep the speed the same no matter the frame rate. 
        # You may get an error that looks something like this if you don't use the 'round()' function
        # ERROR: LoadError: InexactError: Int64(-22.8) NOTE: The number can change but all that matters is that you need to use round when multiplying anything by dt
    end
    if Nexa.is_key_down("a") # Checks if the 'a' key is held down
        player.x -= round(400 * dt)
    end
    if Nexa.is_key_down("s") # Checks if the 's' key is held down
        player.y += round(400 * dt)
    end
    if Nexa.is_key_down("d") # Checks if the 'd' key is held down
        player.x += round(400 * dt)
    end

    if Nexa.is_key_pressed("space") # Checks if the 'SPACE' key is pressed
        println("You pressed 'SPACE'!")
    end
end

function render(ctx::Nexa.Context)
    Nexa.clear_screen(ctx, Nexa.BEIGE)

    Nexa.render_rect_filled(ctx, player.x, player.y, player.w, player.h, Nexa.RED)
end

Nexa.start(on_run, update, render, "Key Input", 600, 600)