local flashCounter = 0
local currentFlashDeleted = 0
function onEvent(name,v1,v2)
	if name == 'Flash' then
		local flashColor = 'FFFFFF'
		local easing = 'linear'
		local layer = 'other'
		local duration = 0.7
		local blendMode = ''
		local alpha = 1
		local ahead = false

		
		if v1 ~= '' then
			local commaStartV1 = 0
			local commaEndV1 = 0
			local commaStart2V1 = 0
			local commaEnd2V1 = 0
			commaStartV1,commaEndV1 = string.find(v1,',',0,true)
			if commaStartV1 ~= nil then
				commaStart2V1,commaEnd2V1 = string.find(v1,',',commaStartV1 + 1,true)
			end

			if commaStartV1 ~= nil then 
				flashColor = string.sub(v1,0,commaStartV1 - 1)
				if commaEnd2V1 == nil then
					blendMode = string.sub(v1,commaStartV1 + 1)
				else
					blendMode = string.sub(v1,commaStartV1 + 1,commaStart2V1 - 1)
					alpha = string.sub(v1,commaStart2V1 + 1)
				end
			else
				flashColor = v1
			end
		end
		if v2 ~= '' then
			if string.find(string.lower(v2),'ahead:true',0,true) ~= nil then
				ahead = true
			end

			local commaStartV2 = 0
			local commaEndV2 = 0
			
			local commaStart2V2 = 0
			local commaEnd2V2 = 0
			commaStartV2,commaEndV2 = string.find(v2,',',0,true)
			if commaStartV2 ~= nil then
				commaStart2V2,commaEnd2V2 = string.find(v2,',',commaStartV2 + 1,true)
			end
			if commaStartV2 ~= nil then
				duration = string.sub(v2,0,commaStartV2 - 1)
				if commaEnd2V2 == nil then
					easing = string.sub(v2,commaStartV2 + 1)
				else
					easing = string.sub(v2,commaStartV2 + 1,commaStart2V2 - 1)
					layer = string.sub(v2,commaStart2V2 + 1)
				end
			else
				duration = v2
			end
		end
		makeLuaSprite('flashEvent'..flashCounter,nil,0,0)
		setProperty('flashEvent'..flashCounter..'.alpha',alpha)
		setObjectCamera('flashEvent'..flashCounter,layer)
		makeGraphic('flashEvent'..flashCounter,screenWidth,screenHeight,flashColor)
		addLuaSprite('flashEvent'..flashCounter, ahead);
		
		if blendMode ~= nil and blendMode ~= '' then
			setBlendMode('flashEvent'..flashCounter,blendMode)
		end
		doTweenAlpha('byeFlashE'..flashCounter,'flashEvent'..flashCounter,0,duration,easing)
		flashCounter = flashCounter + 1
	end
end
function onTweenCompleted(name)
	if string.find(tag,'byeFlashE',0,true) ~= nil then
		for flashLength = currentFlashDeleted,flashCounter do
			if name == 'byeFlashE'..flashLength then
				removeLuaSprite('flashEvent'..flashLength,true)
				currentFlashDeleted = currentFlashDeleted + 1
			end
		end
	end
end