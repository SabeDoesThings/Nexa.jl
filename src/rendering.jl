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

function render_rect_filled(ctx::Nexa.Context, x::Int, y::Int, width::Int, height::Int, color::Color)
    SDL_SetRenderDrawColor(ctx.renderer, color.r, color.g, color.b, color.a)
    rect = SDL_Rect(x, y, width, height)
    SDL_RenderFillRect(ctx.renderer, Ref(rect))
end

function clear_screen(ctx::Nexa.Context, color::Color)
    SDL_SetRenderDrawColor(ctx.renderer, color.r, color.g, color.b, color.a)
    SDL_RenderClear(ctx.renderer)
end