function play_audio(sound::String)
    sound = Mix_LoadWAV(sound)
    Mix_PlayChannel(-1, sound, 0)
end

function play_music_looped(music::String)
    music = Mix_LoadMUS(music)
    if music == C_NULL
        error("Failed to load music: ", SDL_GetError())
    end

    if Mix_PlayMusic(music, -1) == -1
        error("Failed to play music: ", Mix_GetError())
    end
end

function play_audio_looped(sound::String)
    sound = Mix_LoadWAV(sound)
    Mix_PlayChannel(-1, sound, -1)
end

function stop_music()
    Mix_HaltMusic()
end

function stop_audio()
    Mix_HaltChannel(-1)
end