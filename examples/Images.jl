using Nexa

function on_run()
end

function update(dt::Float64)
end

function render(ctx::Nexa.Context)
    Nexa.clear_screen(ctx, Nexa.WHITE)

    julia_icon = Nexa.load_texture("juliaicon.png") # Loads a texture from a path
    Nexa.render_texture(ctx, julia_icon, 0, 0) # Renders the texture

    nexa_logo = Nexa.load_texture("NexaLogo.png") # Loads a texture from a path
    Nexa.render_texture(ctx, nexa_logo, 0, 500) # Renders the texture
end

Nexa.start(on_run, update, render, "Images", 1280, 1000)