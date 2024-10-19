![newnexa](https://github.com/user-attachments/assets/1fa6df7d-37df-45cb-9bd8-e545ff6d96d4)

# My game library: Nexa
A simple game library to make game development in the [Julia](https://julialang.org/) programming language easy. 

## My goal:
My goal for this project is to make a simple library to easily make games in Julia. Something like raylib, not too bloated, very easy to use, very powerful, and can make just about anything.

## Why am I making this? 
Well the julia game dev ecosystem is super scarce and there are only a few libraries that are actually good. 
### [GameZero](https://github.com/aviks/GameZero.jl):
It's simple but you can only use one file and doesn't really seem to be good for large scale projects. 
### [JulGame](https://github.com/Kyjor/JulGame.jl):
Its pretty good so far. The main thing that loses me is the fact that it has a required editor. I am not a big fan of that because I want something more like a "game framework" instead of a "game engine" meaning I don't really want an editor like unity or something. 
### [Bplus](https://github.com/heyx3/Bplus.jl):
It is really well made but it is very low level and I want something that's easier for someone to get into.

# Getting Started
To use Nexa.jl you first have to have [Julia](https://julialang.org/) [installed](https://julialang.org/downloads/).
Once you have that installed go into a command line and type julia.
You should see this:
![image](https://github.com/user-attachments/assets/3899e7e1-0f69-4a90-be5d-fd0bd2b36620)

If you don't see that. Check your PATH if you are on windows.
Once you have that opened though type `]` and you should see this:

![image](https://github.com/user-attachments/assets/e3a09351-6421-4fc6-a77f-a8f7ad7c5797)

This is the Julia package manager. 
Once you are here you need to type `add https://github.com/SabeDoesThings/Nexa.jl` this will add Nexa.jl to your packages.
To create a new Nexa project just go into a directory you want and go back into the command line and do the same thing and do `generate <name of project>`
Once you have that you need to activate your project. 
To do that you need to do `activate .` and you should somthing like this
`(<project name>) pkg >` instead of the julia version.
If you do have that just do the same command as before. `add https://github.com/SabeDoesThings/Nexa.jl` this will add Nexa.jl to your project.
To open up a window just go into your file in the src folder and you can copy this code to open up a window.
```julia
using Nexa # loads in the Nexa library

# Runs only when the program started
function on_run()
end

# Run every frame
function update(dt::Float64)
end

# For rendering things to the screen
function render(ctx::Nexa.Context) # the ctx::Nexa.Context is needed for the library to use the low level rendering side of things
end

# The Nexa.start function takes in 7 arguments
Nexa.start(
    on_run,           # The function ran right when the program has started
    update,           # Called every frame
    render,           # For rendering things to the screen
    "Simple Window",  # The title of the window
    1280,             # The width of the window
    720,              # The height of the window
    false             # whether or not the window is resiable or not
)
```
And with that just do `julia <file name>.jl` and you should see this:
![image](https://github.com/user-attachments/assets/d898fda9-7231-473f-8661-b2d232a746be)

Congratualtions!
You just made your first window in Nexa.jl.
If you want more example usage of Nexa.jl visit the [examples](https://github.com/SabeDoesThings/Nexa.jl/tree/main/examples) folder.
