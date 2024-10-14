using Nexa

function on_run()
    Nexa.play_music_looped("./music.wav") # Currently on .wav files are supported
    # Here we are actually using the on_run() function. This is because if we did this function in the update loop it will glitch and not play at all.
end

function update(dt::Float64)
    #### CAUTION HEADPHONE USERS ####
    # WON'T WORK
    #Nexa.play_music_looped("./src/music.wav")

    if Nexa.is_key_pressed("p")
        Nexa.play_audio("./sfx.wav")
    end
end

function render(ctx::Nexa.Context)
end

Nexa.start(on_run, update, render, "Sounds and Music")