----------------------------------
-------------- Core --------------
----------------------------------
eightBall = {}
eightBall.prefix = "[8BALL]"
eightBall.answers = {}
eightBall.answers.type = {
    "never",
    "rarely",
    "sometimes",
    "often",
    "normally",
    "usually",
    "always"
}
----------------------------------
------------ Extension -----------
----------------------------------
eightBall.gdr_enabled = false
eightBall.gdr_picture = "https://i.imgur.com/51C6Vfj.png"
eightBall.gdr_name = "8Ball"

----------------------------------
---------- Translations ----------
----------------------------------

eightBall.answers["english"] = {
    ["never"] = "Nah i dont think so...",
    ["rarely"] = "Mmmm maybe, but no",
    ["sometimes"] = "Probably... no",
    ["often"] = "mmmmmm Maybe yes or not",
    ["normally"] = "Well... yes, duh",
    ["usually"] = "Mmmm I'm sure of that",
    ["always"] = "Hell yeah",
}

eightBall.answers["spanish"] = {
    ["never"] = "Lo veo imposible",
    ["rarely"] = "Osea puede que si, pero sigue siendo no",
    ["sometimes"] = "Es probable, quien sabe...",
    ["often"] = "Es probable... probable...",
    ["normally"] = "Lo mas probable que si",
    ["usually"] = "Es muy probable que si",
    ["always"] = "Obvio que si",
}

----------------------------------
------------- Cvars --------------
----------------------------------
CreateConVar("8ball_lang", "en", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The language to use for the 8ball")


----------------------------------
------------ Functions -----------
----------------------------------
local lang_table = {
    ["en"] = "english",
    ["es"] = "spanish"
}

function eightBall_GetLanguage(phrase)
    local lang = GetConVar("8ball_lang"):GetString()
    local language = lang_table[lang] or "english"
    return eightBall.answers[language][phrase] or phrase
end


hook.Add("PlayerSay", "8BALL_hook", function(ply, text)
    if string.StartWith(text, "!8ball ") and string.EndsWith(text, "?") then
        local answer = table.Random(eightBall.answers.type)
        local answer_phrase = eightBall_GetLanguage(answer)
        print(eightBall.prefix .. " " .. ply:Nick() .. " asked the 8ball: " .. string.sub(text, 8, -1))
        timer.Simple(0.1, function()

            -- GDR
            if tGDRConfig and eightBall.gdr_enabled then
                hook.Call("GDR_sendMessage", nil, 
                eightBall.gdr_picture,
                eightBall.gdr_name,
                ply:Nick()  .. ", " .. answer_phrase)
            end

            for _, v in pairs(player.GetAll()) do
                v:ChatPrint(eightBall.prefix .. " " .. ply:Nick()  .. " " .. answer_phrase)
            end

        end)
    end
end)