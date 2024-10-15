mutable struct Animation
    texture::Nexa.Texture2D
    frame_width::Int
    frame_height::Int
    num_frames::Int
    frame_duration::Float64  # Duration for each frame in seconds
    current_frame::Int
    elapsed_time::Float64

    function Animation(texture::Nexa.Texture2D, frame_width::Int, frame_height::Int, num_frames::Int, frame_duration::Float64)
        new(texture, frame_width, frame_height, num_frames, frame_duration, 1, 0.0)
    end
end

function update_animation!(anim::Animation, delta_time::Float64)
    anim.elapsed_time += delta_time

    # Check if it's time to advance to the next frame
    if anim.elapsed_time >= anim.frame_duration
        anim.current_frame = (anim.current_frame % anim.num_frames) + 1  # Looping frames
        anim.elapsed_time -= anim.frame_duration  # Reset the elapsed time
    end
end

function render_animation(ctx::Nexa.Context, anim::Animation, dest_x::Int, dest_y::Int, scale_x::Int = 1, scale_y::Int = 1)
    # Create texture from the sprite sheet surface
    tex = SDL_CreateTextureFromSurface(ctx.renderer, anim.texture.surface)

    width = Ref{Cint}(0)
    height = Ref{Cint}(0)

    # Query the texture to get its dimensions
    if SDL_QueryTexture(tex, C_NULL, C_NULL, width, height) != 0
        error("Failed to render texture! ERROR: $(unsafe_string(SDL_GetError()))")
    end

    # Calculate the source rectangle for the current frame
    src_x = (anim.current_frame - 1) * anim.frame_width
    src_rect = SDL_Rect(src_x, 0, anim.frame_width, anim.frame_height)

    # Calculate the scaled dimensions
    scaled_width = round(Int(anim.frame_width * scale_x))
    scaled_height = round(Int(anim.frame_height * scale_y))

    # Create the destination rectangle for rendering with scaled dimensions
    dst = SDL_Rect(dest_x, dest_y, scaled_width, scaled_height)

    # Render the current frame of the animation
    SDL_RenderCopy(ctx.renderer, tex, Ref(src_rect), Ref(dst))

    # Destroy the texture after use to prevent memory leaks
    SDL_DestroyTexture(tex)
end