function onCreatePost()
    for strumLineNotes = 0,7 do
        if strumLineNotes < 4 then
            if getPropertyFromClass('PlayState','isPixelStage') == true  then
                setPropertyFromGroup('strumLineNotes', strumLineNotes,'texture','fatal')
            end
        else
            setPropertyFromGroup('strumLineNotes', strumLineNotes,'color',getColorFromHex('FF7F7F'))
        end
    end
end
function onUpdate()
    if getPropertyFromClass('PlayState','isPixelStage') == true then
        for notesLength = 0,getProperty('notes.length') do
            if getPropertyFromGroup('notes', notesLength,'mustPress') == false then 
                if getPropertyFromGroup('notes', notesLength,'noteType') == '' then
                    setPropertyFromGroup('notes',notesLength,'texture','fatal')
                end
            else
                if getPropertyFromGroup('notes', notesLength,'noteType') == '' then
                    setPropertyFromGroup('notes',notesLength,'color',getColorFromHex('FF7F7F'))
                end
            end
        end
    end
end