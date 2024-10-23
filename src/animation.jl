mutable struct Animation
    texture::Texture2D
    frame_width::Int
    frame_height::Int
    num_frames::Int
    frame_time::Float64
    current_frame::Int
    elapsed_time::Float64
    start_frame::Int
    end_frame::Int

    function Animation(texture::Texture2D, frame_width::Int, frame_height::Int, num_frames::Int, frame_time::Float64, start_frame::Int, end_frame::Int)
        new(texture, frame_width, frame_height, num_frames, frame_time, start_frame, 0.0, start_frame, end_frame)
    end
end


function update_animation!(anim::Animation, dt::Float64, looped::Bool=true)
    anim.elapsed_time += dt

    if anim.elapsed_time >= anim.frame_time
        anim.elapsed_time -= anim.frame_time
        anim.current_frame += 1

        if looped
            if anim.current_frame > anim.end_frame
                anim.current_frame = anim.start_frame
            end
        else
            if anim.current_frame > anim.end_frame
                anim.current_frame = anim.end_frame
            end
        end
    end
end

function render_animation(ctx::Nexa.Context, anim::Animation, dest_x::Int, dest_y::Int, scale_x::Float64 = 1.0, scale_y::Float64 = 1.0)
    tex = SDL_CreateTextureFromSurface(ctx.renderer, anim.texture.surface)

    width = Ref{Cint}(0)
    height = Ref{Cint}(0)

    if SDL_QueryTexture(tex, C_NULL, C_NULL, width, height) != 0
        error("Failed to render texture! ERROR: $(unsafe_string(SDL_GetError()))")
    end

    src_x = (anim.current_frame - 1) * anim.frame_width
    src_rect = SDL_Rect(src_x, 0, anim.frame_width, anim.frame_height)

    scaled_width = round(Int(anim.frame_width * scale_x))
    scaled_height = round(Int(anim.frame_height * scale_y))

    dst = SDL_Rect(Int(dest_x * scale_x), Int(dest_y * scale_y), scaled_width, scaled_height)

    SDL_RenderCopy(ctx.renderer, tex, Ref(src_rect), Ref(dst))

    SDL_DestroyTexture(tex)
end
