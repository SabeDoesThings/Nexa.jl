using Nexa

function on_run()
end

function update(dt::Float64)
end

function render(ctx::Nexa.Context)
end

Nexa.start(on_run, update, render, "Simple Window", 1280, 720, false)