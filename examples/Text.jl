using Nexa

my_font = Nexa.load_font("./arial.ttf", 30) # Load the font you want

function on_run()
end

function update(dt::Float64)
end

function render(ctx::Nexa.Context)
    Nexa.clear_screen(ctx, Nexa.WHITE)

    Nexa.render_text(ctx, my_font, "Hello Nexa!", Nexa.BLACK, 30, 30) # Render the font
end

Nexa.start(on_run, update, render, "Text", 600, 600)