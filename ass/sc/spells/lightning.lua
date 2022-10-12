local spell = {
    x = 100,
    y = -50,
    active =  true,
    time = 0
}
function spell:update()
    spell.x =  math.abs(camera.x)/2+150
    if spell.active==true then
        local i=1
        while troops[i] do
            if math.abs(spell.x+25-troops[i].x)<40 and troops[i].dir==-1 then
                troops[i].health = troops[i].health-(2+upg[4]*1)
                troops[i].stunTime = 3
                troops[i].collide = true
            end
            i=i+1
        end
    end
    if spell.time>0.5 then 
        spell.active=false
        spell.time=0
    end
end

function spell:draw()
    if spell.active==true then
        love.graphics.draw(lightning, spell.x, spell.y)
    end
end
return spell