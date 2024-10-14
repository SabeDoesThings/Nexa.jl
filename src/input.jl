const key_map = Dict(
    "a" => SDL_SCANCODE_A,
    "b" => SDL_SCANCODE_B,
    "c" => SDL_SCANCODE_C,
    "d" => SDL_SCANCODE_D,
    "e" => SDL_SCANCODE_E,
    "f" => SDL_SCANCODE_F,
    "g" => SDL_SCANCODE_G,
    "h" => SDL_SCANCODE_H,
    "i" => SDL_SCANCODE_I,
    "j" => SDL_SCANCODE_J,
    "k" => SDL_SCANCODE_K,
    "l" => SDL_SCANCODE_L,
    "m" => SDL_SCANCODE_M,
    "n" => SDL_SCANCODE_N,
    "o" => SDL_SCANCODE_O,
    "p" => SDL_SCANCODE_P,
    "q" => SDL_SCANCODE_Q,
    "r" => SDL_SCANCODE_R,
    "s" => SDL_SCANCODE_S,
    "t" => SDL_SCANCODE_T,
    "u" => SDL_SCANCODE_U,
    "v" => SDL_SCANCODE_V,
    "w" => SDL_SCANCODE_W,
    "x" => SDL_SCANCODE_X,
    "y" => SDL_SCANCODE_Y,
    "z" => SDL_SCANCODE_Z,
    "space" => SDL_SCANCODE_SPACE,
    "escape" => SDL_SCANCODE_ESCAPE,
    "up" => SDL_SCANCODE_UP,
    "down" => SDL_SCANCODE_DOWN,
    "left" => SDL_SCANCODE_LEFT,
    "right" => SDL_SCANCODE_RIGHT
)

previous_key_states = Dict{String, Int}()

function is_key_down(key::String)
    scancode = key_map[key]
    key_state = SDL_GetKeyboardState(C_NULL)
    return unsafe_load(key_state, scancode + 1) == 1
end

function is_key_pressed(key::String)
    scancode = key_map[key]
    key_state = SDL_GetKeyboardState(C_NULL)

    current_state = unsafe_load(key_state, scancode + 1)

    previous_state = get(previous_key_states, key, 0)

    previous_key_states[key] = current_state

    return current_state == 1 && previous_state == 0
end

const mouse_button_map = Dict(
    "left" => SDL_BUTTON_LEFT,
    "middle" => SDL_BUTTON_MIDDLE,
    "right" => SDL_BUTTON_RIGHT,
    "x1" => SDL_BUTTON_X1,
    "x2" => SDL_BUTTON_X2
)

previous_mouse_button_states = Dict{String, Int}()

function is_mouse_button_down(button::String)
    button_code = mouse_button_map[button]
    mouse_state = SDL_GetMouseState(C_NULL, C_NULL)
    return (mouse_state & SDL_BUTTON(button_code)) != 0
end

function is_mouse_button_pressed(button::String)
    button_code = mouse_button_map[button]
    mouse_state = SDL_GetMouseState(C_NULL, C_NULL)

    current_state = (mouse_state & SDL_BUTTON(button_code)) != 0 ? 1 : 0

    previous_state = get(previous_mouse_button_states, button, 0)

    previous_mouse_button_states[button] = current_state

    return current_state == 1 && previous_state == 0
end


function process_events()
    event = Ref{SDL_Event}()
    SDL_PollEvent(event)
    if event[].type == SDL_QUIT
        return false
    end

    return true
end