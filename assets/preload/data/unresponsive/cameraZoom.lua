local currentZoom = 0
local currentTarget = 'boyfriend'
local firstSection = false
local currentSection = nil
function onCreatePost()
    currentZoom = getProperty('defaultCamZoom')
    setProperty('camZooming',true)
end
function onUpdate()
    if currentZoom ~= 0 then
        if currentSection ~= nil then
            if gfSection ~= true then
                if mustHitSection == false then
                    if currentSection ~= 'dad' then
                        currentTarget = 'dad'
                        currentSection = 'dad'
                    end
                else
                    if currentSection ~= 'boyfriend' then
                        currentTarget = 'boyfriend'
                        currentSection = 'boyfriend'
                    end
                end
            else
                if currentSection ~= 'gf' then
                    currentTarget = 'gf'
                    currentSection = 'gf'
                end
            end
        end
        if currentTarget == 'dad' then
            setProperty('defaultCamZoom',currentZoom)
        elseif currentTarget == 'boyfriend' then
            setProperty('defaultCamZoom',currentZoom + 0.2)
        elseif currentTarget == 'gf' then
            setProperty('defaultCamZoom',currentZoom + 0.1)
        end
    end
end
function onStepHit()
    if curStep == 772 then
        currentZoom = 0.85
    end
    if curStep == 1066 then
        currentZoom = 0.5
    end
end
function onBeatHit()
    if curBeat % 4 == 0 and currentSection == nil then
        currentSection = ''
    end
end