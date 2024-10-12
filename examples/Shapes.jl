using Nexa

function on_run()
end

function update(dt::Float64)
end

function render(ctx::Nexa.Context)
    Nexa.clear_screen(ctx, Nexa.WHITE) # Clears the screen to a white

    Nexa.render_rect_filled(ctx, 30, 30, 64, 64, Nexa.BLUE) # Draws a filled rectangle at (30, 30) and is 64 x 64 pixels with a color of blue
    Nexa.render_rect_line(ctx, 130, 30, 64, 64, Nexa.RED) # Draws a outline rectangle at (124, 30) and is 64 x 64 pixels with a color of red

    Nexa.render_circle_filled(ctx, 62, 140, 40, Nexa.YELLOW) # Draws a filled circle as (62, 140) and has the radius of 40 with a color of yellow
    Nexa.render_circle_line(ctx, 162, 140, 40, Nexa.GREEN) # Draws a filled circle as (162, 140) and has the radius of 40 with a color of green
end

Nexa.start(on_run, update, render, "Shapes", 600, 600, false)