local splashCount = 0;

local splashThing = nil;

local sickTrack = -1;

local precacheImage = 0
local enableNewSystem = 2;

local textureSplash = 'BloodSplash';

local splashOffsetX = 70
local splashOffsetY = 35

local splashScaleX = nil
local splashScaleY = nil
local splashVelocity = 30
local splashAlpha = 1
local splashesDestroyed = 0

local splashAnims = {'note splash purple 1','note splash blue 1','note splash green 1','note splash red 1'}

function goodNoteHit(note, direction, type, sus)
	if sickTrack ~= getProperty('sicks') then
		if sus == false then
			if enableNewSystem == 2 and getPropertyFromClass('ClientPrefs','noteSplashes') == true and not sus then
				spawnCustomSplash(note, direction, type,textureSplash);
				if precacheImage == 1 then
					removeLuaSprite('noteSplashpChache',true)
					precacheImage = 2
				end
			end
		end
		sickTrack = getProperty('sicks');
	end
end

function spawnCustomSplash(noteId, noteDirection, type,textureNote)
	splashThing = splashAnims[noteDirection + 1]
	splashCount  = splashCount + 1

	makeAnimatedLuaSprite('noteSplash'..splashCount, textureNote, getPropertyFromGroup('playerStrums', noteDirection, 'x'), getPropertyFromGroup('playerStrums', noteDirection, 'y'));
	addAnimationByPrefix('noteSplash'..splashCount, 'anim', splashThing, splashVelocity, false);
	if splashScaleX ~= nil then
		setProperty('noteSplash' .. splashCount .. '.scale.x', splashScaleX);
	end
	if splashScaleY ~= nil then
		setProperty('noteSplash' .. splashCount .. '.scale.y', splashScaleY);
	end
	setProperty('noteSplash' .. splashCount .. '.offset.x', splashOffsetX);
	setProperty('noteSplash' .. splashCount .. '.offset.y', splashOffsetY);

	setProperty('noteSplash' .. splashCount .. '.alpha', splashAlpha);
	setProperty('noteSplash' .. splashCount .. '.color', getPropertyFromGroup('strumLineNotes',noteDirection,'color'))
	setObjectCamera('noteSplash'..splashCount, 'hud');
	setObjectOrder('noteSplash'..splashCount, 9999); -- this better make the splashes go in front-
	addLuaSprite('noteSplash'..splashCount,true);
end
function onUpdate()
	if enableNewSystem == 2 then
		if sickTrack ~= 0 then
			for splashes = splashesDestroyed, splashCount do
				if getProperty('noteSplash'..splashes..'.animation.curAnim.finished') then
					setProperty('noteSplash'..splashes..'.visible',false)
					removeLuaSprite('noteSplash'..splashes,true)
					splashesDestroyed = splashesDestroyed + 1
				end
			end
			for splashesDefault = 0,getProperty('grpNoteSplashes.length') do
				setPropertyFromGroup('grpNoteSplashes', splashesDefault,'visible',false)
			end
		end
	end
end