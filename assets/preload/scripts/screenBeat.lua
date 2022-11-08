local BeatPorcent = {0}
local BeatCustomPorcent = {0}

local cannotBeat = {0}
local cannotBeatCustom = {0}

local cannotBeatInverted = {0}



local Section = 0
local InvertedSection = 0
local cannotBeatSection = 0

local cannotBeatInt = false

local BeatStrentghGame = 0.015
local BeatStrentghHUD = 0.03

local Beated = false
local BeatedCustom = false

local enabledBeat = true

function onStepHit()
    for cannotBeatLength = 1,#cannotBeat do
        if cannotBeat[cannotBeatLength] ~= nil and cannotBeat[cannotBeatLength] ~= 0 then
            if cannotBeatInt == true and curBeat % cannotBeat[cannotBeatLength] == 0 or cannotBeatInt == false and (curStep/4) % cannotBeat[cannotBeatLength] == 0 then
                enabledBeat = false
            else
                enabledBeat = true
            end
        else
            enabledBeat = true
        end
    end
    for cannotBeatCustomLength = 1,#cannotBeatCustom do
        if cannotBeatCustom[cannotBeatCustomLength] ~= nil and cannotBeatCustom[cannotBeatCustomLength] ~= 0 then
            if (curStep/4) % cannotBeatSection == cannotBeatCustom[cannotBeatCustomLength] then
                enabledBeat = false
            else
                enabledBeat = true
            end
        else
            enabledBeat = true
        end
    end
    if enabledBeat == true then
        for BeatsHit = 1,#BeatPorcent do
            if BeatPorcent[BeatsHit] ~= nil and Beated == false then
                if (curStep/4) % BeatPorcent[BeatsHit] == 0 then
                    runTimer('enabledBeat',0.01)
                    triggerEvent('Add Camera Zoom',BeatStrentghGame,BeatStrentghHUD)
                    Beated = true
                else
                    Beated = false
                end
            else
                Beated = false
            end
        end
        for BeatsCustomHit = 1,#BeatCustomPorcent do
            if BeatCustomPorcent[BeatsCustomHit] ~= nil and BeatedCustom == false then
                if (curStep/4) % Section == BeatCustomPorcent[BeatsCustomHit] then
                    BeatedCustom = true
                    runTimer('enableBeatCustom',0.01)
                    triggerEvent('Add Camera Zoom',BeatStrentghGame,BeatStrentghHUD)
                else
                    BeatedCustom = false
                end
            else
                BeatedCustom = false
            end
        end
    end
    --songs
    if songName == 'unresponsive' then
        if curStep == 64 or curStep == 384  then
            clearCustomBeat()
            replaceArrayBeat(1,1)
            replaceArrayCustomBeat(1,4)
        end
        if curStep == 128 or curStep == 511 or curStep == 1064 then
            clearBeat()
            clearCustomBeat()
            replaceArrayCustomBeat(1,1)
            replaceArrayCustomBeat(2,1.5)
            replaceArrayCustomBeat(3,2.5)
            replaceArrayCustomBeat(4,3)
        end
        if curStep == 912 then
            replaceArrayCustomBeat(1,2)
        end
        if curStep == 118 or curStep == 494 or curStep == 768 then
            clearCustomBeat()
            clearBeat()
            clearCustomCannotBeat()
        end
    end
end

function onTimerCompleted(tag)
    if tag == 'enableBeat' then
        Beated = false
    end
    if tag == 'enableBeatCustom' then
        BeatedCustom = false
    end
    if tag == 'enableInverted' then
        BeatedInverted = false
    end
    if tag == 'enableCustomInverted' then
        BeatedCustomInverted = false
    end
end
function replaceArrayCannotBeat(pos,number)
    if pos == nil then
        table.insert(cannotBeat,#cannotBeat + 1,number)
    else
        if cannotBeat[pos] ~= nil then
            table.remove(cannotBeat,pos)
        end
        table.insert(cannotBeat,pos,number)
    end
end
function clearCannotBeat()
    for clearBeatCannot = 1,#cannotBeat do
        if cannotBeat[clearBeatCannot] ~= nil then
            table.remove(cannotBeat,clearBeatCannot)
        end
        table.insert(cannotBeat,clearBeatCannot,0)
    end
end

function replaceArrayCustomCannotBeat(pos,number)
    if cannotBeatSection == 0 then
        cannotBeatSection = 4
    end
    if pos == nil then
        table.insert(cannotBeatCustom,#cannotBeatCustom + 1,number)
    else
        if cannotBeatCustom[pos] ~= nil then
            table.remove(cannotBeatCustom,pos)
        end
        table.insert(cannotBeatCustom,pos,number)
    end
end
function removeArrayCustomCannotBeat(pos)
    table.remove(cannotBeatCustom,pos)
end
function clearCustomCannotBeat()
    cannotBeatSection = 0
    for clearBeatCustomCannot = 1,#cannotBeatCustom do
        if cannotBeatCustom[clearBeatCustomCannot] ~= nil then
            table.remove(cannotBeatCustom,clearBeatCustomCannot)
        end
        table.insert(cannotBeatCustom,clearBeatCustomCannot,0)
    end
end
function replaceArrayBeat(pos,number)
    if pos == nil then
        table.insert(BeatPorcent,#BeatPorcent + 1,number)
    else
        if BeatPorcent[pos] ~= nil then
            table.remove(BeatPorcent,pos)
        end
        table.insert(BeatPorcent,pos,number)
    end
end
function clearBeat()
    for clearCanBeat = 1,#BeatPorcent do
        table.remove(BeatPorcent,clearCanBeat)
        table.insert(BeatPorcent,clearCanBeat,0)
    end
end
function replaceArrayCustomBeat(pos,number)
    if Section == 0 then
        Section = 4
    end
    if pos == nil then
        table.insert(BeatCustomPorcent,#BeatCustomPorcent + 1,number)
    else
        if BeatCustomPorcent[pos] ~= nil then
            table.remove(BeatCustomPorcent,pos)
        end
        table.insert(BeatCustomPorcent,pos,number)
    end
end
function clearCustomBeat()
    Section = 0
    for clearCanBeatCustom = 1,#BeatCustomPorcent do
        table.remove(BeatCustomPorcent,clearCanBeatCustom)
        table.insert(BeatCustomPorcent,clearCanBeatCustom,0)
    end
end

function backBeat()
    BeatStrentghGame = 0.015
    BeatStrentghHUD = 0.03
end
function clearAllArrays()
    clearCannotBeat()
    clearCustomCannotBeat()
    clearBeat()
    clearCustomBeat()
end