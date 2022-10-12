local spell = {
    x = 100,
    y = -70,
    active =  false
}
function spell:update()
    spell.x =  math.abs(camera.x)/2+150
    if spell.active==true then
        spell.y=spell.y+7
        local i=1
        while troops[i] do
            if math.abs(spell.x+25-troops[i].x)<50 and troops[i].dir==-1 and spell.y>10 then
                troops[i].health = troops[i].health-(10+upg[4]*2)
                troops[i].collide = true
            end
            i=i+1
        end
    end
    if spell.y>70 then
        spell.y=-90
        spell.active = false
    end
end

function spell:draw()
    if spell.active==true then
        love.graphics.draw(fireball, spell.x, spell.y)
    end
end
return spell