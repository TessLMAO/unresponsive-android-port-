function opponentNoteHit(id,data,type,sus)
    if sus == true then
        if curStep > 383 and curStep < 512 or curStep > 631 and curStep < 640 then
            cameraShake('game',0.02,0.1)
            cameraShake('hud',0.005,0.1)
        end
    end
end
function goodNoteHit(id,data,type,sus)
    if sus == true then
        if curStep > 383 and curStep < 512 then
            cameraShake('game',0.02,0.1)
            cameraShake('hud',0.005,0.1)
        end
    end
end
function onStepHit()
    if curStep == 764 then
        doTweenAlpha('byeGame','camGame',0,0.5,'linear')
    end
    if curStep == 785 then
        setProperty('camGame.alpha',1)
    end
end