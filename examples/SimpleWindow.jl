using Nexa # loads in the Nexa library

# Runs only when the program started
function on_run()
end

# Run every frame
function update(dt::Float64)
end

# For Rendering things to the screen
function render(ctx::Nexa.Context) # the ctx::Nexa.Context allows to actually access the low level renderer
end

# The Nexa.start function takes in 7 arguments
Nexa.start(
    on_run,           # The function ran right when the program has started
    update,           # Called every frame
    render,           # For rendering things to the screen
    "Simple Window",  # The title of the window
    1280,             # The width of the window
    720,              # The height of the window
    false             # wether or not the window is resiable or not
)
