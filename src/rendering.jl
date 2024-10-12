function render_texture(ctx::Context, tex::Texture2D, tex_x::Int, tex_y::Int)
    tex = SDL_CreateTextureFromSurface(ctx.renderer, tex)

    width = Ref{Cint}(0)
    height = Ref{Cint}(0)

    if SDL_QueryTexture(tex, C_NULL, C_NULL, width, height) != 0
        error("Failed to render texture! ERROR: $(unsafe_string(SDL_GetError()))")
    end

    dst = SDL_Rect(tex_x, tex_y, width[], height[])

    SDL_RenderCopy(ctx.renderer, tex, C_NULL, Ref(dst))
end

function convert_color(c::Color)
    return SDL_Color(c.r, c.g, c.b, c.a)
end

function render_text(ctx::Context, font::Ptr{TTF_Font}, text::String, color::Color, x::Int, y::Int)
    sdl_color = convert_color(color)

    surface = TTF_RenderText_Solid(font, text, sdl_color)
    if surface == C_NULL
        error("Could not create text surface: ", SDL_GetError())
    end

    texture = SDL_CreateTextureFromSurface(ctx.renderer, surface)
    if texture == C_NULL
        SDL_FreeSurface(surface)
        error("Could not create text renderer: ", SDL_GetError())
    end

    w, h = Ref{Cint}(0), Ref{Cint}(0)
    SDL_QueryTexture(texture, C_NULL, C_NULL, w, h)

    dest_rect = SDL_Rect(x, y, w[], h[])

    SDL_RenderCopy(ctx.renderer, texture, C_NULL, Ref(dest_rect))

    SDL_DestroyTexture(texture)
    SDL_FreeSurface(surface)
end

function render_rect_filled(ctx::Nexa.Context, x::Int, y::Int, width::Int, height::Int, color::Color)
    SDL_SetRenderDrawColor(ctx.renderer, color.r, color.g, color.b, color.a)
    rect = SDL_Rect(x, y, width, height)
    SDL_RenderFillRect(ctx.renderer, Ref(rect))
end

function render_rect_line(ctx::Nexa.Context, x::Int, y::Int, width::Int, height::Int, color::Color)
    SDL_SetRenderDrawColor(ctx.renderer, color.r, color.g, color.b, color.a)
    rect = SDL_Rect(x, y, width, height)
    SDL_RenderDrawRect(ctx.renderer, Ref(rect))
end

function render_circle_line(ctx::Nexa.Context, center_x::Int, center_y::Int, radius::Int, color::Color)
    diameter = radius * 2

    x = radius - 1
    y = 0
    tx = 1
    ty = 1
    error = tx - diameter

    while x >= y
        SDL_SetRenderDrawColor(ctx.renderer, color.r, color.g, color.b, color.a)

        SDL_RenderDrawPoint(ctx.renderer, center_x + x, center_y - y)
        SDL_RenderDrawPoint(ctx.renderer, center_x + x, center_y + y)
        SDL_RenderDrawPoint(ctx.renderer, center_x - x, center_y - y)
        SDL_RenderDrawPoint(ctx.renderer, center_x - x, center_y + y)
        SDL_RenderDrawPoint(ctx.renderer, center_x + y, center_y - x)
        SDL_RenderDrawPoint(ctx.renderer, center_x + y, center_y + x)
        SDL_RenderDrawPoint(ctx.renderer, center_x - y, center_y - x)
        SDL_RenderDrawPoint(ctx.renderer, center_x - y, center_y + x)

        if error <= 0
            y += 1
            error += ty
            ty += 2
        end

        if error > 0
            x -= 1
            tx += 2
            error += tx - diameter
        end
    end
end

function render_circle_filled(ctx::Nexa.Context, center_x::Int, center_y::Int, radius::Int, color::Color)
    diameter = radius * 2

    x = radius - 1
    y = 0
    tx = 1
    ty = 1
    error = tx - diameter

    while x >= y
        SDL_SetRenderDrawColor(ctx.renderer, color.r, color.g, color.b, color.a)

        SDL_RenderDrawLine(ctx.renderer, center_x - x, center_y - y, center_x + x, center_y - y)
        SDL_RenderDrawLine(ctx.renderer, center_x - x, center_y + y, center_x + x, center_y + y)
        SDL_RenderDrawLine(ctx.renderer, center_x - y, center_y - x, center_x + y, center_y - x)
        SDL_RenderDrawLine(ctx.renderer, center_x - y, center_y + x, center_x + y, center_y + x)

        if error <= 0
            y += 1
            error += ty
            ty += 2
        end

        if error > 0
            x -= 1
            tx += 2
            error += tx - diameter
        end
    end
end

function clear_screen(ctx::Nexa.Context, color::Color)
    SDL_SetRenderDrawColor(ctx.renderer, color.r, color.g, color.b, color.a)
    SDL_RenderClear(ctx.renderer)
end