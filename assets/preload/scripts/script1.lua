local changedImage = false
local disableImage = false

local textCreated = false
local circleCreated = false

local counterPos = {{300,230},{300,230},{300,230},{300,230}} -- first value: Three image pos X and Y. Second value: Ready? image x and y. Third value: Set image x and y. Fourth value: GO! image x and y.
local counterScale = {{1,1},{1,1},{1,1},{1,1}}


--[[
    Introducions:
    To change value in the counterPos or counterScale, just need to know that:

        tablePos: 1 = Three
        tablePos: 2 = Two/Ready?
        tablePos: 3 = One/Set?
        tablePos: 4 = Go!

    like this:
    changeCountPos(changeAll:bollean,posX:number,posY:number,tablePos)
    changeCountScale(changeAll:bollean,scaleX:number,scaleY:number,tablePos)

    changeALl = change all values in the array.

    if you want to disable the count down song, just put "-silence" in the first function in changeCountDown(), like that:
        changeCountDown('-silence','',false,false,false,false,1,1,0,0)
--]]
function onCreate()
    if songName == 'unresponsive' then
        changeCounterPos(true,450,250,1)
        changeCounterScale(true,3,3,1)
        changeCountDown('-Fatal','StartScreens/fatal_',true,true,true,false,false)
    end
end
function onCountdownTick(counter)
    if counter > 0 then
        addLuaSprite('customIntro'..counter,true)
        doTweenAlpha('byeCustomIntro'..counter,'customIntro'..counter,0,getPropertyFromClass('Conductor','crochet')/ 1000,'linear')
        if counter == 1 then
            if disableImage == true then
                setProperty('countdownReady.visible',false)
            end
            if changedImage == true then
                doTweenAlpha('byeReady','customIntro'..counter,0,0.5,'linear')
            end
        elseif counter == 2 then
            if disableImage == true then
                setProperty('countdownSet.visible',false)
            end
            removeLuaSprite('customIntro'..(counter -1),true)
        elseif counter == 3 then
            if disableImage == true then
                setProperty('countdownGo.visible',false)
            end
            removeLuaSprite('customIntro'..(counter -1),true)
        end
    end
end
function changeCountDown(songCountName,image,changeSong,changeImage,disableCountDownImage,haveThreeImage,antialiasing)
    disableImage = disableCountDownImage
    if changeSong == true then
        setProperty('introSoundsSuffix',songCountName)
    end
    if changeImage == true then
        changedImage = true
        if haveThreeImage == true then
            for countDown = 1,3 do
                makeLuaSprite('customIntro'..countDown,image..countDown,counterPos[countDown][1],counterPos[countDown][2])
                setObjectCamera('customIntro'..countDown,'hud')
                scaleObject('customIntro'..countDown,counterScale[countDown][1],counterScale[countDown ][2])
                setProperty('customIntro'..countDown..'.antialiasing',antialiasing)
            end
        else
            for countDown = 1,2 do
                makeLuaSprite('customIntro'..countDown,image..countDown,counterPos[countDown + 1][1],counterPos[countDown + 1][2])
                setObjectCamera('customIntro'..countDown,'hud')
                scaleObject('customIntro'..countDown,counterScale[countDown + 1][1],counterScale[countDown + 1][2])
                setProperty('customIntro'..countDown..'.antialiasing',antialiasing)
            end
        end
        makeLuaSprite('customIntro3',image..'go',counterPos[4][1],counterPos[4][2])
        setObjectCamera('customIntro3','hud')
        scaleObject('customIntro3',counterScale[4][1],counterScale[4][2])
        setProperty('customIntro3.antialiasing',antialiasing)
    end
end
function changeCounterPos(changeAll,posX,posY,tablePos)
    if changeAll == true then
        for counterLength = 1,#counterPos do
            table.remove(counterPos,counterLength)
            table.insert(counterPos,counterLength,{posX,posY})
        end

    else
        table.remove(counterPos,tablePos)
        table.insert(counterPos,tablePos,{posX,posY})
    end
end
function changeCounterScale(changeAll,scaleX,scaleY,tablePos)
    if changeAll == true then
        for scaleLength = 1,#counterScale do
            table.remove(counterScale,scaleLength)
            table.insert(counterScale,tablePos,{scaleX,scaleY})
        end

    else
        table.remove(counterScale,tablePos)
        table.insert(counterScale,tablePos,{scaleX,scaleY})
    end
end