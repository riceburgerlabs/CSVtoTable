local public = {}
-- Translation file
local translations = {
    ["What is your name?"] = {
        ["zh"] = "你叫什么名字？",    -- Chinese
        ["ko"] = "당신의 이름은 무엇입니까?",    -- Korean
        ["es"] = "¿Cuál es su nombre?",    -- Spanish
    },
    ["How old are you?"] = {
        ["zh"] = "你几岁？",    -- Chinese
        ["ko"] = "당신은 몇 살입니까?",    -- Korean
        ["es"] = "¿Cuantos años tienes?",    -- Spanish
    },
    ["Press to continue"] = {
        ["zh"] = "按继续",    -- Chinese
        ["ko"] = "계속하려면를 누르십시오",    -- Korean
        ["es"] = "Pulse para continuar",    -- Spanish
    },
}
local lang = "es"--system.getPreference( "locale", "language"):lower()
public.t = function(text)
    return translations[text] and translations[text][lang] or text
end
return public
