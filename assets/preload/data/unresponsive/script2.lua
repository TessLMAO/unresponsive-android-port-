local inExecution = false
local flashEnd = true
local ColorTime = 1
function onCreate()
    addLuaScript('custom_events/Flash')

    makeLuaSprite('unresponsiveBlack',nil,0,0)
    makeGraphic('unresponsiveBlack',screenWidth,screenHeight,'000000')
    setObjectCamera('unresponsiveBlack','hud')
    for forlol = 1,2 do
        makeLuaText('unresponsiveText'..forlol,'UNRESPONSIVE',120,500,-235 + (100 * forlol))
        setTextAlignment('unresponsiveText'..forlol,'center')
        setObjectCamera('unresponsiveText'..forlol,'hud')
        scaleObject('unresponsiveText'..forlol,2.2,2.2)
        setTextFont('unresponsiveText'..forlol,'sonic-1-hud-font.ttf')
        setProperty('unresponsiveText'..forlol..'.antialiasing',false)
        setTextBorder('unresponsiveText'..forlol,0,'FFFFFF')
        addLuaText('unresponsiveText'..forlol,true)
    end
end
function onStepHit()
    if curStep == 112 then
        addLuaSprite('unresponsiveBlack',false)
        triggerEvent('Flash',0.5,'FF9999')
        flashEnd = true
        for forlol = 1,2 do
            doTweenY('unresponsiveTextY'..forlol,'unresponsiveText'..forlol,200 + (100 * forlol),0.8,'quartOut')
            doTweenColor('unresponsiveColorR'..forlol,'unresponsiveText'..forlol,'FF0000',ColorTime,'linear')
            runTimer('unresponsiveBack',1)
        end
    end
    if curStep == 240 or curStep == 496 or curStep == 1040 then
        ColorTime = 0.7
        addLuaSprite('unresponsiveBlack',false)
        triggerEvent('Flash',0.5,'FF9999')
        flashEnd = true
        for forlol = 1,2 do
            setProperty('unresponsiveText1.visible',true)
            setProperty('unresponsiveText2.visible',true)
            setProperty('unresponsiveText'..forlol..'.x',250)
            setProperty('unresponsiveText'..forlol..'.y',100 + (150 * forlol))
            scaleObject('unresponsiveText'..forlol,7,6)
            setProperty('unresponsiveText'..forlol..'.angle',60)
            doTweenAngle('unresponsiveTextAngle'..forlol,'unresponsiveText'..forlol,0,0.6,'backOut')
            runTimer('unresponsiveAngleBack',1.1)
        end
    end
    if curStep == 240 then
        flashEnd = false
    end
end
function onTimerCompleted(tag)
    if tag == 'unresponsiveAngleBack' then
        for forlol = 1,2 do
            doTweenAngle('unresponsiveTextAngleBack'..forlol,'unresponsiveText'..forlol,60,0.6,'backIn')
        end
    end
    if tag == 'unresponsiveBack' then
        for forlol = 1,2 do
            doTweenY('unresponsiveTextYBack'..forlol,'unresponsiveText'..forlol,-235 + (100 * forlol),0.8,'quartIn')
        end
    end
end
function onTweenCompleted(tag)
    if tag == 'unresponsiveColorR1' then
        doTweenColor('unresponsiveColorW1','unresponsiveText1','FFFFFF',ColorTime,'linear')
    end
    if tag == 'unresponsiveColorR2' then
        doTweenColor('unresponsiveColorW2','unresponsiveText2','FFFFFF',ColorTime,'linear')
    end
    if tag == 'unresponsiveColorW1' then
        doTweenColor('unresponsiveColorR1','unresponsiveText1','FF0000',ColorTime,'linear')
    end
    if tag == 'unresponsiveColorW2' then
        doTweenColor('unresponsiveColorR2','unresponsiveText2','FF0000',ColorTime,'linear')
    end
    if tag == 'unresponsiveTextYBack1' then
        if flashEnd == true then
            triggerEvent('Flash',0.5,'FF2222')
        end
        removeLuaSprite('unresponsiveBlack',false)
    end
    if tag == 'unresponsiveTextAngleBack1' then
        if flashEnd == true then
            triggerEvent('Flash',0.5,'FF2222')
        end
        setProperty('unresponsiveText1.visible',false)
        setProperty('unresponsiveText2.visible',false)
        removeLuaSprite('unresponsiveBlack',false)
    end
end