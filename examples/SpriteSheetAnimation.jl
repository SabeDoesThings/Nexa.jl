using Nexa

my_anim = Nexa.Animation(Nexa.load_texture("./src/character_spritesheet.png"), 48, 48, 4, 0.1, 1, 4)

function on_run()
end

function update(dt::Float64)
    Nexa.update_animation!(my_anim, dt)
end

function render(ctx::Nexa.Context)
    Nexa.clear_screen(ctx, Nexa.BLACK)

    Nexa.render_animation(ctx, my_anim, 100, 100)
end

Nexa.start(on_run, update, render, "Sprite Sheet Animation", 600, 600)
