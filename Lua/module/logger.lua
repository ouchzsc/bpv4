local logger = {}

function logger.info(text, tag)
    print(text, "\n" .. debug.traceback())
end

function logger.error(text)
    CS.UnityEngine.Debug.LogError(text)
end

return logger
