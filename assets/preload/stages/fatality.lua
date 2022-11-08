function onCreate()
    makeAnimatedLuaSprite('fatalityBg1','fatal/launchbase',-1200,-900)
    addAnimationByPrefix('fatalityBg1','moviment','idle',14,true)
    setProperty('fatalityBg1.antialiasing',false)
    scaleObject('fatalityBg1',5.7,5.7)

    makeAnimatedLuaSprite('fatalityBg2','fatal/domain',-1200,-900)
    addAnimationByPrefix('fatalityBg2','moviment','idle',14,false)
    setProperty('fatalityBg2.antialiasing',false)
    scaleObject('fatalityBg2',5.7,5.7)

    makeAnimatedLuaSprite('fatalityBg2-5','fatal/domain2',-1200,-900)
    addAnimationByPrefix('fatalityBg2-5','moviment','idle',14,false)
    setProperty('fatalityBg2-5.antialiasing',false)
    scaleObject('fatalityBg2-5',5.7,5.7)

    makeAnimatedLuaSprite('fatalityBg3','fatal/truefatalstage',-1200,-900)
    addAnimationByPrefix('fatalityBg3','moviment','idle',14,true)
    setProperty('fatalityBg3.antialiasing',false)
    scaleObject('fatalityBg3',5.7,5.7)

    addLuaSprite('fatalityBg1')

    if songName == 'unresponsive' then
        setProperty('fatalityBg1.color',getColorFromHex('FF1919'))
        setProperty('fatalityBg2-5.color',getColorFromHex('FF1919'))
        setProperty('fatalityBg3.color',getColorFromHex('FF1919'))
    end
end
function onCreatePost()
   if songName == 'unresponsive' then
        setProperty('boyfriend.color',getColorFromHex('FF7F7F'))
   end
end
function onBeatHit()
    objectPlayAnimation('fatalityBg2','moviment',false)
    objectPlayAnimation('fatalityBg2-5','moviment',false)
end
function onStepHit()
    if songName == 'unresponsive' then
        if curStep == 256 then
            removeLuaSprite('fatalityBg1')
            addLuaSprite('fatalityBg2-5')
            addLuaSprite('fatalityBg2')

        end
        if curStep == 768 then
            setProperty('fatalityBg2.visible',false)
            setProperty('fatalityBg2-5.visible',false)
            setProperty('boyfriend.alpha',0.7)
            setProperty('dad.alpha',0.7)
        end
        if curStep == 1064 then
            setProperty('fatalityBg2.visible',true)
            setProperty('fatalityBg2-5.visible',true)
            setProperty('boyfriend.alpha',1)
            setProperty('dad.alpha',1)
        end
    end
end