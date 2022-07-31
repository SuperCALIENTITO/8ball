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
    ["never"] = "No lo creo",
    ["rarely"] = "No tanto",
    ["sometimes"] = "Puede ser",
    ["often"] = "Lo mas probable que si",
    ["normally"] = "Igual puede que si",
    ["usually"] = "Es muy probable que si",
    ["always"] = "por supuesto",
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

function 8ball_GetLanguage(phrase)
    local language = lang_table[lang:GetString()] or "english"
    return eightBall.answers[language][phrase] or phrase
end


hook.Add("PlayerSay", "8BALL_hook", function(ply, text)
    if ( string.sub(text, 1, 8) == "!8ball " ) and string.sub(text, -1) == "?" then
        local answer = table.Random(eightBall.answers.type)
        local answer_phrase = 8ball_GetLanguage(answer)
        print(eightBall.prefix .. " " .. ply:Nick() .. " asked the 8ball: " .. string.sub(text, 9, -1))
        for k, v in pairs(player.GetAll()) do
            v:ChatPrint(eightBall.prefix .. " " .. answer_phrase)
        end
    end
end)