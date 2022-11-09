local currentGameOver = ''
function onUpdate()
    if currentGameOver ~= getProperty('boyfriend.curCharacter') then
        if getProperty('boyfriend.curCharacter') == 'bf-fatal' then
            setPropertyFromClass('GameOverSubstate','characterName','bf-fatal-death')
            setPropertyFromClass('GameOverSubstate','deathSoundName','fatal-death')
            setPropertyFromClass('GameOverSubstate','loopSoundName','starved-loop')
            currentGameOver = 'bf-fatal'
        end
    end
end