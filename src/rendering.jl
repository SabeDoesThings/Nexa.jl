function render_texture(ctx::Nexa.Context, tex::Texture2D, tex_x::Int, tex_y::Int, scale_x::Float64 = 1.0, scale_y::Float64 = 1.0)
    tex = SDL_CreateTextureFromSurface(ctx.renderer, tex.surface)

    width = Ref{Cint}(0)
    height = Ref{Cint}(0)

    if SDL_QueryTexture(tex, C_NULL, C_NULL, width, height) != 0
        error("Failed to render texture! ERROR: $(unsafe_string(SDL_GetError()))")
    end

    scaled_tex_x = Int(tex_x * scale_x)
    scaled_tex_y = Int(tex_y * scale_y)
    scaled_width = Int(width[] * scale_x)
    scaled_height = Int(height[] * scale_y)

    dst = SDL_Rect(scaled_tex_x, scaled_tex_y, scaled_width, scaled_height)

    SDL_RenderCopy(ctx.renderer, tex, C_NULL, Ref(dst))
end


function set_texture_width(tex::Texture2D, new_width::Int)
    tex.width = new_width
end

function set_texture_height(tex::Texture2D, new_height::Int)
    tex.height = new_height
end

function convert_color(c::Color)
    return SDL_Color(c.r, c.g, c.b, c.a)
end

function render_text(ctx::Nexa.Context, font::Ptr{TTF_Font}, text::String, color::Color, x::Int, y::Int, scale_x::Float64 = 1.0, scale_y::Float64 = 1.0)
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

    scaled_x = Int(x * scale_x)
    scaled_y = Int(y * scale_y)
    scaled_width = round(Int(w[] * scale_x))
    scaled_height = round(Int(h[] * scale_y))

    dest_rect = SDL_Rect(scaled_x, scaled_y, scaled_width, scaled_height)

    SDL_RenderCopy(ctx.renderer, texture, C_NULL, Ref(dest_rect))

    SDL_DestroyTexture(texture)
    SDL_FreeSurface(surface)
end

function render_rect_filled(ctx::Nexa.Context, x::Int, y::Int, width::Int, height::Int, color::Nexa.Color)
    scaled_x = Int(x * ctx.scale_x)
    scaled_y = Int(y * ctx.scale_y)
    scaled_width = Int(width * ctx.scale_x)
    scaled_height = Int(height * ctx.scale_y)

    SDL_SetRenderDrawColor(ctx.renderer, color.r, color.g, color.b, color.a)
    rect = SDL_Rect(scaled_x, scaled_y, scaled_width, scaled_height)
    SDL_RenderFillRect(ctx.renderer, Ref(rect))
end


function render_rect_line(ctx::Nexa.Context, x::Int, y::Int, width::Int, height::Int, color::Color)
    scaled_x = Int(x * ctx.scale_x)
    scaled_y = Int(y * ctx.scale_y)
    scaled_width = Int(width * ctx.scale_x)
    scaled_height = Int(height * ctx.scale_y)

    SDL_SetRenderDrawColor(ctx.renderer, color.r, color.g, color.b, color.a)
    rect = SDL_Rect(scaled_x, scaled_y, scaled_width, scaled_height)
    SDL_RenderDrawRect(ctx.renderer, Ref(rect))
end


function render_circle_line(ctx::Nexa.Context, center_x::Int, center_y::Int, radius::Int, color::Color)
    scaled_center_x = Int(center_x * ctx.scale_x)
    scaled_center_y = Int(center_y * ctx.scale_y)
    scaled_radius_x = Int(radius * ctx.scale_x)
    scaled_radius_y = Int(radius * ctx.scale_y)

    diameter_x = scaled_radius_x * 2
    diameter_y = scaled_radius_y * 2

    x = scaled_radius_x - 1
    y = 0
    tx = 1
    ty = 1
    error_x = tx - diameter_x
    error_y = ty - diameter_y

    while x >= y
        SDL_SetRenderDrawColor(ctx.renderer, color.r, color.g, color.b, color.a)

        SDL_RenderDrawPoint(ctx.renderer, scaled_center_x + x, scaled_center_y - y)
        SDL_RenderDrawPoint(ctx.renderer, scaled_center_x + x, scaled_center_y + y)
        SDL_RenderDrawPoint(ctx.renderer, scaled_center_x - x, scaled_center_y - y)
        SDL_RenderDrawPoint(ctx.renderer, scaled_center_x - x, scaled_center_y + y)
        SDL_RenderDrawPoint(ctx.renderer, scaled_center_x + y, scaled_center_y - x)
        SDL_RenderDrawPoint(ctx.renderer, scaled_center_x + y, scaled_center_y + x)
        SDL_RenderDrawPoint(ctx.renderer, scaled_center_x - y, scaled_center_y - x)
        SDL_RenderDrawPoint(ctx.renderer, scaled_center_x - y, scaled_center_y + x)

        if error_x <= 0
            y += 1
            error_x += ty
            ty += 2
        end

        if error_x > 0
            x -= 1
            tx += 2
            error_x += tx - diameter_x
        end
    end
end


function render_circle_filled(ctx::Nexa.Context, center_x::Int, center_y::Int, radius::Int, color::Nexa.Color)
    scaled_center_x = Int(center_x * ctx.scale_x)
    scaled_center_y = Int(center_y * ctx.scale_y)
    scaled_radius = Int(radius * ctx.scale_x)

    diameter = scaled_radius * 2

    x = scaled_radius - 1
    y = 0
    tx = 1
    ty = 1
    error = tx - diameter

    while x >= y
        SDL_SetRenderDrawColor(ctx.renderer, color.r, color.g, color.b, color.a)

        SDL_RenderDrawLine(ctx.renderer, scaled_center_x - x, scaled_center_y - y, scaled_center_x + x, scaled_center_y - y)
        SDL_RenderDrawLine(ctx.renderer, scaled_center_x - x, scaled_center_y + y, scaled_center_x + x, scaled_center_y + y)
        SDL_RenderDrawLine(ctx.renderer, scaled_center_x - y, scaled_center_y - x, scaled_center_x + y, scaled_center_y - x)
        SDL_RenderDrawLine(ctx.renderer, scaled_center_x - y, scaled_center_y + x, scaled_center_x + y, scaled_center_y + x)

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


function render_line(ctx::Nexa.Context, x1::Int, y1::Int, x2::Int, y2::Int)
    scaled_x1 = Int(x1 * ctx.scale_x)
    scaled_y1 = Int(y1 * ctx.scale_y)
    scaled_x2 = Int(x2 * ctx.scale_x)
    scaled_y2 = Int(y2 * ctx.scale_y)

    SDL_RenderDrawLine(ctx.renderer, scaled_x1, scaled_y1, scaled_x2, scaled_y2)
end


function clear_screen(ctx::Nexa.Context, color::Color)
    SDL_SetRenderDrawColor(ctx.renderer, color.r, color.g, color.b, color.a)
    SDL_RenderClear(ctx.renderer)
end
