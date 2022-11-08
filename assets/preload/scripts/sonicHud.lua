local hudEnabled = false
local fontStyle = 'sonic1'
local enableCustomHud = false
local enabledOldScreen = false
local middleScrollEnabled = nil

local oldScreen = 0 -- 3 to do a tween effect, 2 to go to position, 1 to do a tween back and 0 to disable
local hudStyle = 0

local textX = 20
local textY = 0
local ofs = 50
local currentMissesCount = 0
local currentMisses = 0

local currentScoreCount = 0
local currentScore = 0

local effectTime = 1

local hudTimes = {'TenMinutes','Minutes','TenSeconds','Seconds'}
local hudTimeOffset = {22,22,28,27}

local numbersOffset = {7,11}
local bordersCreated = false
local textInPosition = false
local directory = ''

function onCreate()
    if songName == 'unresponsive' then
        oldScreen = 0
        fontStyle = 'sonic3'
    end
    if not downscroll then
        textY = screenHeight - 160
    else
        textY = ofs
    end
    if fontStyle == 'sonic2' then
        numbersOffset = {8,11}
    end
end
function onCreatePost()
    directory = 'sonicUI/'..fontStyle
    middleScrollEnabled = getPropertyFromClass('ClientPrefs','middleScroll')
    enableCustomHud = getPropertyFromClass('PlayState','isPixelStage')
    makeLuaSprite('sonicMissesSprite',directory..'/misses',textX,textY)
    setProperty('sonicMissesSprite.antialiasing',false)
    scaleObject('sonicMissesSprite',3.5,3.5)
    setObjectCamera('sonicMissesSprite','hud')

    makeLuaSprite('sonicTimeSprite',directory..'/time',textX,textY + ofs)
    setProperty('sonicTimeSprite.antialiasing',false)
    scaleObject('sonicTimeSprite',3.5,3.5)
    setObjectCamera('sonicTimeSprite','hud')

    makeLuaSprite('sonicScoreSprite',directory..'/score',textX,textY + (ofs * 2))
    setProperty('sonicScoreSprite.antialiasing',false)
    scaleObject('sonicScoreSprite',3.5,3.5)
    setObjectCamera('sonicScoreSprite','hud')


    makeLuaSprite('sonicScoreText0',nil,getProperty('sonicScoreSprite.x') + (getProperty('sonicScoreSprite.width')/1.2) + 46,getProperty('sonicScoreSprite.y') + 2)
    loadGraphic('sonicScoreText0',directory..'/numbers',numbersOffset[1],numbersOffset[2])
    addAnimation('sonicScoreText0','timeHud',{0,1,2,3,4,5,6,7,8,9},0,true)
    setObjectCamera('sonicScoreText0','hud')
    setProperty('sonicScoreText0.antialiasing',false)
    scaleObject('sonicScoreText0',3,3)
    
    makeLuaSprite('sonicMissesText0',nil,getProperty('sonicMissesSprite.x') + (getProperty('sonicMissesSprite.width')/1.2) + 46,getProperty('sonicMissesSprite.y') + 2)
    loadGraphic('sonicMissesText0',directory..'/numbers',numbersOffset[1],numbersOffset[2])
    addAnimation('sonicMissesText0','timeHud',{0,1,2,3,4,5,6,7,8,9},0,true)
    setObjectCamera('sonicMissesText0','hud')
    setProperty('sonicMissesText0.antialiasing',false)
    scaleObject('sonicMissesText0',3,3)

    for time = 1,#hudTimes do
        makeLuaSprite('sonic'..hudTimes[time]..'Text',nil,getProperty('sonicTimeText'),getProperty('sonicTimeSprite.y') + 2)
        loadGraphic('sonic'..hudTimes[time]..'Text',directory..'/numbers',numbersOffset[1],numbersOffset[2])
        addAnimation('sonic'..hudTimes[time]..'Text','timeHud',{0,1,2,3,4,5,6,7,8,9},0,true)
        setObjectCamera('sonic'..hudTimes[time]..'Text','hud')
        setProperty('sonic'..hudTimes[time]..'Text.antialiasing',false)
        scaleObject('sonic'..hudTimes[time]..'Text',3,3)
    end
    makeLuaSprite('sonicColonText',directory..'/colon',getProperty('sonicTimeSprite.x') + (getProperty('sonicTimeSprite.width')/1.2) + 70,getProperty('sonicTimeSprite.y'))
    setObjectCamera('sonicColonText','hud')
    setProperty('sonicColonText.antialiasing',false)
    scaleObject('sonicColonText',3,3)
end
function onUpdate()
    if hudStyle == 0 then
        if hudEnabled == false then
            if enableCustomHud == true or enableCustomHud == 'true' then
                if getPropertyFromClass('ClientPrefs','timeBarType') ~= 'Disabled' then
                    setProperty('timeBarBG.visible',false)
                    setProperty('timeBar.visible',false)
                    setProperty('timeTxt.visible',false)
                end
                setProperty('scoreTxt.visible',false)
                
                addLuaSprite('sonicMissesSprite',true)
                setObjectOrder('sonicMissesSprite',getObjectOrder('iconP2') + 1)
                addLuaSprite('sonicTimeSprite',true)
                setObjectOrder('sonicTimeSprite',getObjectOrder('iconP2') + 1)
                addLuaSprite('sonicScoreSprite',true)
                setObjectOrder('sonicScoreSprite',getObjectOrder('iconP2') + 1)
                for scoreLength = 0,currentScore do
                    addLuaSprite('sonicScoreText'..scoreLength,true)
                end
                for missesLength = 0,currentMisses do
                    addLuaSprite('sonicMissesText'..missesLength,true)
                end
                for time = 1,#hudTimes do
                    addLuaSprite('sonic'..hudTimes[time]..'Text',true)
                end
                addLuaSprite('sonicColonText',true)
                hudEnabled = true
            end
        end
    end
    if hudEnabled == true then
        if enableCustomHud == false or enableCustomHud == 'false' then
            setProperty('scoreTxt.visible',true)
            setProperty('timeTxt.visible',true)
            if getPropertyFromClass('ClientPrefs','timeBarType') ~= 'Disabled' then
                setProperty('timeBarBG.visible',true)
                setProperty('timeBar.visible',true)
            end

            removeLuaSprite('sonicScoreSprite',false)
            removeLuaSprite('sonicTimeSprite',false)
            removeLuaSprite('sonicMissesSprite',false)
            for scoreLength = 0,currentScore do
                removeLuaSprite('sonicScoreText'..scoreLength,false)
            end
            for missesLength = 0,currentMisses do
                removeLuaSprite('sonicMissesText'..missesLength,false)
            end
            for time = 1,#hudTimes do
                removeLuaSprite('sonic'..hudTimes[time]..'Text',true)
            end
            removeLuaSprite('sonicColonText',false)
            setProperty('healthBar.x',320)
            hudEnabled = false
        end
    end
    if oldScreen == 3 then
        if bordersCreated == false then
            makeLuaSprite('blackBorderOldSonic','',-160,0)
            setObjectCamera('blackBorderOldSonic','other')
            makeGraphic('blackBorderOldSonic',160,screenHeight,'000000')
            addLuaSprite('blackBorderOldSonic',false)
            doTweenX('helloBar1','blackBorderOldSonic',0,effectTime,'quartOut')

           
            makeLuaSprite('blackBorderOldSonic2','',screenWidth,0)
            setObjectCamera('blackBorderOldSonic2','other')
            makeGraphic('blackBorderOldSonic2',160,screenHeight,'000000')
            addLuaSprite('blackBorderOldSonic2',true)
            doTweenX('helloBar2','blackBorderOldSonic2',screenWidth - 155,effectTime,'quartOut')
            
            for strumLineNotes = 0,7 do
                if strumLineNotes < 4 then
                    if not middleScrollEnabled then
                        noteTweenX('notesTweenX'..strumLineNotes,strumLineNotes,180 + (112 * strumLineNotes),effectTime,'quartOut')
                    else
                        if strumLineNotes < 2 then
                            noteTweenX('notesTweenX'..strumLineNotes,strumLineNotes,170 + (112 * strumLineNotes),effectTime,'quartOut')
                        else
                            noteTweenX('notesTweenX'..strumLineNotes,strumLineNotes,screenWidth - 620 + (112 * strumLineNotes),effectTime,'quartOut')
                        end
                    end
                else
                    if not middleScrollEnabled then
                        noteTweenX('notesTweenX'..strumLineNotes,strumLineNotes,screenWidth - 620 + (112 * (strumLineNotes - 4)),effectTime,'quartOut')
                    end
                end
            end
            bordersCreated = true
            if hudEnabled == true and textInPosition == false then
                textX = 170
                doTweenX('goScoreTxt','sonicScoreSprite',textX,effectTime,'quartOut')
                doTweenX('goMissesTxt','sonicMissesSprite',textX,effectTime,'quartOut')
                doTweenX('goTimeTxt','sonicTimeSprite',textX,effectTime,'quartOut')
                textInPosition = true
            end
            runTimer('okChange',effectTime)
        end
    end
    if oldScreen == 2 and enabledOldScreen == false then
        makeLuaSprite('blackBorderOldSonic','',0,0)
        setObjectCamera('blackBorderOldSonic','other')
        makeGraphic('blackBorderOldSonic',160,screenHeight,'000000')
        
        makeLuaSprite('blackBorderOldSonic2','',screenWidth - 155,0)
        setObjectCamera('blackBorderOldSonic2','other')
        makeGraphic('blackBorderOldSonic2',160,screenHeight,'000000')
        addLuaSprite('blackBorderOldSonic',false)
        addLuaSprite('blackBorderOldSonic2',true)
        if hudEnabled == true and textInPosition == false then
            textX = 170
            setProperty('sonicScoreSprite.x',textX)
            setProperty('sonicMissesSprite.x',textX)
            setProperty('sonicTimeSprite.x',textX)
            textInPosition = true
        end
        for strumLineNotes = 0,7 do
            if strumLineNotes < 4 then
                if middleScrollEnabled == false then
                    setPropertyFromGroup('strumLineNotes',strumLineNotes,'x',180 + (112 * strumLineNotes))
                else
                    if strumLineNotes < 2 then
                        setPropertyFromGroup('strumLineNotes',strumLineNotes,'x',170 + (112 * strumLineNotes))
                    else
                        setPropertyFromGroup('strumLineNotes',strumLineNotes,'x',screenWidth - 620 + (112 * strumLineNotes))
                    end
                end
            else
                if middleScrollEnabled == false then
                    setPropertyFromGroup('strumLineNotes',strumLineNotes,'x',screenWidth - 620 + (112 * (strumLineNotes - 4)))
                end
            end
        end
        enabledOldScreen = true
    end
    if oldScreen == 1 then
        textX = 20
        doTweenX('byeBorder','blackBorderOldSonic',getProperty('blackBorderOldSonic.width') *-1,1,'quartInOut')


        for strumLineNotes = 0,7 do
            if strumLineNotes < 4 then
                if middleScrollEnabled == false then
                    setPropertyFromGroup('strumLineNotes',strumLineNotes,'x',92 + (112 * strumLineNotes))
                else
                    if strumLineNotes < 2 then
                        setPropertyFromGroup('strumLineNotes',strumLineNotes,'x',92 + (112 * strumLineNotes))
                    else
                        setPropertyFromGroup('strumLineNotes',strumLineNotes,'x',screenWidth - 460 + (112 * strumLineNotes))
                    end
                end
            else
                if middleScrollEnabled == false then
                    setPropertyFromGroup('strumLineNotes',strumLineNotes,'x',screenWidth - 548 + (112 * (strumLineNotes - 4)))
                end
            end
        end
        oldScreen = 0
    end
    if hudEnabled == true then
        setProperty('healthBar.x',500)
        --setTextString('sonicTimeText',math.floor(getSongPosition()/60000)..':'..math.floor((getSongPosition()/10000) % 6).. math.floor(getSongPosition()/1000) % 10)
        setProperty('sonicTenSecondsText.animation.curAnim.curFrame',math.floor((getSongPosition()/10000) % 6))
        setProperty('sonicSecondsText.animation.curAnim.curFrame',math.floor((getSongPosition()/1000) % 10))
        setProperty('sonicMinutesText.animation.curAnim.curFrame',math.floor((getSongPosition()/60000) % 10))
        setProperty('sonicTenMinutesText.animation.curAnim.curFrame',math.floor((getSongPosition()/600000) % 10))
        --Misses function
        for missesLength = 0,currentMisses do
            if 10 * missesLength ~= 0 then
                setProperty('sonicMissesText'..missesLength..'.animation.curAnim.curFrame',(getProperty('songMisses')/(10 * missesLength)) % 10)
            else
                setProperty('sonicMissesText'..missesLength..'.animation.curAnim.curFrame',getProperty('songMisses') % 10)
            end
        end
        if currentMissesCount ~= 0 and getProperty('songMisses') >= currentMissesCount * 10 or currentMissesCount == 0 and getProperty('songMisses') == 10 then
            for changeMissesPos = 0,currentMisses do
                setProperty('sonicMissesText'..changeMissesPos..'.x',getProperty('sonicMissesText'..changeMissesPos..'.x') + (22 * (changeMissesPos + 1)))
            end
            makeLuaSprite('sonicMissesText'..(currentMisses + 1),nil,getProperty('sonicMissesSprite.x') + (getProperty('sonicMissesSprite.width')/1.2) + 46,getProperty('sonicMissesSprite.y') + 2)
            loadGraphic('sonicMissesText'..(currentMisses + 1),directory..'/numbers',numbersOffset[1],numbersOffset[2])
            addAnimation('sonicMissesText'..(currentMisses + 1),'timeHud',{0,1,2,3,4,5,6,7,8,9},0,true)
            setObjectCamera('sonicMissesText'..(currentMisses + 1),'hud')
            setProperty('sonicMissesText'..(currentMisses + 1)..'.antialiasing',false)
            scaleObject('sonicMissesText'..(currentMisses+ 1),3,3)
            addLuaSprite('sonicMissesText'..(currentMisses + 1),true)
            currentMisses = currentMisses + 1
            if currentMissesCount < 10 then
                currentMissesCount = 10
            else
                currentMissesCount = currentMissesCount * 10
            end
        end
        --Score functions
        for scoreLength = 0,currentScore do
            if string.sub(currentScoreCount,1,scoreLength) ~= nil and scoreLength ~= 0 then 
                setProperty('sonicScoreText'..scoreLength..'.animation.curAnim.curFrame',math.floor(getProperty('songScore')/string.sub(currentScoreCount,1,scoreLength + 1) % 10))
            end
        end

        if currentScoreCount ~= 0 and getProperty('songScore') >= currentScoreCount * 10 or currentScoreCount == 0 and getProperty('songScore') >= 10 then
            for changeScorePos = 0,currentScore do
                setProperty('sonicScoreText'..changeScorePos..'.x',getProperty('sonicScoreText'..changeScorePos..'.x') + 22)
            end
            makeLuaSprite('sonicScoreText'..(currentScore + 1),nil,getProperty('sonicScoreSprite.x') + (getProperty('sonicScoreSprite.width')/1.2) + 46,getProperty('sonicScoreSprite.y') + 2)
            loadGraphic('sonicScoreText'..(currentScore + 1),directory..'/numbers',numbersOffset[1],numbersOffset[2])
            addAnimation('sonicScoreText'..(currentScore + 1),'timeHud',{0,1,2,3,4,5,6,7,8,9},0,true)
            setObjectCamera('sonicScoreText'..(currentScore + 1),'hud')
            setProperty('sonicScoreText'..(currentScore + 1)..'.antialiasing',false)
            scaleObject('sonicScoreText'..(currentScore+ 1),3,3)
            addLuaSprite('sonicScoreText'..(currentScore + 1),true)
            currentScore = currentScore + 1
            if currentScoreCount < 10 then
                currentScoreCount = 10
            else
                currentScoreCount = currentScoreCount * 10
            end
        end
    --fix positions
        --score
        for scorePos = 0,currentScore do
            setProperty('sonicScoreText'..scorePos..'.x',getProperty('sonicScoreSprite.x') + getProperty('sonicScoreSprite.width') + 22 + (22 * (currentScore - scorePos)))
            setObjectOrder('sonicScoreText'..scorePos,getObjectOrder('iconP2') + 1)
        end
        --misses
        for missesPos = 0,currentMisses do
            setProperty('sonicMissesText'..missesPos..'.x',getProperty('sonicMissesSprite.x') + getProperty('sonicMissesSprite.width') + 22 + (22 * (currentMisses - missesPos)))
            setObjectOrder('sonicMissesText'..currentMisses,getObjectOrder('iconP2') + 1)
        end
        --time
        setProperty('sonicColonText.x',getProperty('sonicTimeSprite.x') + getProperty('sonicTimeSprite.width') + 44)
        for timePos = 1,#hudTimes do
            setProperty('sonic'..hudTimes[timePos]..'Text.x',getProperty('sonicTimeSprite.x') + getProperty('sonicTimeSprite.width') - 26 + (hudTimeOffset[timePos] * timePos))
            setObjectOrder('sonic'..hudTimes[timePos]..'Text',getObjectOrder('iconP2') + 1)
        end
    end
end
function onTweenCompleted(tag)
    if tag == 'byeBorder' then
        removeLuaSprite('blackBorderOldSonic',false)
        bordersCreated = false
    end
    if tag == 'byeBorder2' then
        removeLuaSprite('blackBorderOldSonic2',false)
        bordersCreated = false
    end
end
function onTimerCompleted(tag)
    if tag == 'okChange' and oldScreen == 3 then
        oldScreen = 2
    end 
end