ability = {}

ability.spell = {}
    ability.spell[1] = require 'ass/sc/spells/fireball'
    ability.spell[2] = require 'ass/sc/spells/lightning'

function ability:update(delta)
    local i=1
    while ability.spell[i] do
        ability.spell[i]:update()
        i=i+1
    end
    ability.spell[2].time = ability.spell[2].time +delta
end

function ability:draw()
    local i=1
    while ability.spell[i] do
        ability.spell[i]:draw()
        i=i+1
    end
end

return ability